function [infected, recovered] = AgentBasedGraph(country, numPeople, numInfected, numConnections, numTimeSteps, infectiousConst, recoveryConst) 

if (iscell(country)) 
    country = country{0};
end

%%initialize variables
people = zeros(numPeople, numConnections + 2); %% adjacency list of graph
% first column is status, 1 if infected, 2 if recovered
% second column is location
% all other columns are the actual adjacency list (index based)
infected = zeros(numTimeSteps, 1); % preallocate array to hold infected quantities of individuals over time
recovered = zeros(numTimeSteps, 1); % preallocate array to hold recovered quantities of individuals over time

%% assign numOfCountry variable
numOfCountry = 0;
if (strcmp(country, 'Guinea') == 0)
    numOfCountry = 1;
else
    if (strcmp(country, 'Sierra Leone') == 0)
        numOfCountry = 2;
    else
        if (strcmp(country, 'Liberia') == 0)
            numOfCountry = 3;
        end
    end
end

districts = getDistrictInfo(numOfCountry);

%%create districtThresh to help allocate population among districts
districtThresh = zeros(length(fieldnames(districts)),1);

fields = fieldnames(districts);
for i = 1:length(fieldnames(districts))
    d = districts.(matlab.lang.makeValidName(fields{i}));
    a = districts.(matlab.lang.makeValidName(fields{i})).population;
    districts.(matlab.lang.makeValidName(fields{i})).inhabitants = [];
    if (i == 1)
        districtThresh(1) = a;
    else
        districtThresh(i) = districtThresh(i - 1) + a;
    end
end

districtThresh = districtThresh ./ districtThresh(end);

%%assign locations within Country

for i = 1:numPeople
    locationDeterminer = i/numPeople;
    location = -1; %%not defined
    for j = 1:length(districtThresh)
        if districtThresh(j) > locationDeterminer %%works since the thresholds to decide people are increasing over time
            location = j; %%location is defined
            break;
        end
    end
    inhabitants = districts.(matlab.lang.makeValidName(fields{location})).inhabitants;
    districts.(matlab.lang.makeValidName(fields{location})).inhabitants = [inhabitants, i]; %%add new person to inhabitants
    people(i, 2) = location; %% set up person's location
end

%%assign people as infected
currentlyInfected = randperm(numPeople, numInfected);
people(currentlyInfected, 1) = 1;

% 0 is uninfected
% 1 is infected
% 2 is recovered
%%

%%instantiate random connections
for i = 1:numPeople
    for j = 1:numConnections
        location = people(i, 2);
        neighbors = districts.(matlab.lang.makeValidName(fields{location})).neighbors;
        %%TODO: pick a more formal way of choosing neighbors
        neighbors = [neighbors fields{location}]; %%can connect to within district as well
        chosenNeighborLength = 0;
        while chosenNeighborLength == 0 %%deal with edge case where one of the neighbors are uninhabited
            chosenNeighbor = neighbors{randi(length(neighbors))};
            chosenNeighborInhabitants = districts.(matlab.lang.makeValidName(chosenNeighbor)).inhabitants;
            chosenNeighborLength = length(chosenNeighborInhabitants);
        end
        people(i,j + 2) = chosenNeighborInhabitants(randi(length(chosenNeighborInhabitants)));
    end
end


for t = 1:numTimeSteps
    for j = currentlyInfected
        isInfected = (people(j, 1) == 1);
        for e = 1:numConnections
            edge = people(j, e + 2);
            if isInfected
                if people(edge, 1) ~= 2
                    if rand < infectiousConst
                        % when contacting person is infectious, other person isn't recovered, and probability
                        people(edge, 1) = 1;
                        currentlyInfected = [currentlyInfected edge];
                    end
                end
            end
        end
        % should person recover now?
        if rand < recoveryConst && isInfected
            people(j, 1) = 2;
            currentlyInfected(currentlyInfected == j) = []; %% we remove the currently infected person who just recovered
        end
    end
    % go measure people list
    % TODo: make this more efficient
    for j = 1:numPeople
        if (people(j, 1) == 1)
            infected(t) = infected(t) + 1;
        end
        if (people(j, 1) == 2)
            recovered(t) = recovered(t) + 1;
        end
    end
    
    %%simple check for efficiency ... don't waste time on model that
    %%clearly cannot converge
    if (length(currentlyInfected) > 1000) %%it was never the case that more than 1000 cases occurred at any single time
        break;
    end
end

while (length(infected) < numTimeSteps) %%since we broke early as this model clearly failed
    infected = [infected repelem(numPeople, numTimeSteps - length(infected))]; %% assume we failed to converge, everyone sick
    recovered = [recovered repelem(numPeople, numTimeSteps - length(infected))];
end



end