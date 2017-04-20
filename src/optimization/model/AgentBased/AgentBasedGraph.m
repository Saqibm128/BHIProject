function [infected, recovered] = AgentBasedGraph(country, numPeople, numInfected, numConnections, numTimeSteps, infectiousConst, recoveryConst) 

%%initialize variables
people = zeros(numPeople, numConnections + 2);
infected = zeros(numTimeSteps, 1);
recovered = zeros(numTimeSteps, 1);

% districts = getDistrictInfo(country);
% districtThresh = zeros(length(fieldnames(districts)),1);
% 
% 
% for i = 1:length(fieldnames(districts))
%     fields = fieldnames(districts);
%     d = districts.(genvarname(fields{i}));
%     a = districts.(genvarname(fields{i})).population;
%     if (i == 1)
%         districtThresh = a;
%     else
%         districtThresh = districtThresh(i - 1) + a;
%     end
% end
% 
% districtThresh = districtThresh ./ districtThresh(end);


%%assign people as infected
chosenInfected = randperm(numPeople, numInfected);
people(chosenInfected, 1) = 1;

% 0 is uninfected
% 1 is infected
% 2 is recovered
%%

%%instantiate random connections
for i = 1:numPeople
    for j = 1:numConnections
        people(i,j + 2) = randi(numPeople);
    end
end

for t = 1:numTimeSteps
    for j = 1:numPeople
        isInfected = (people(j, 1) == 1);
        for e = 1:numConnections
            edge = people(j, e + 2);
            if isInfected
                if people(edge, 1) ~= 2
                    if rand < infectiousConst
                        % when contacting person is infectious, other person isn't recovered, and probability
                        people(edge, 1) = 1;
                    end
                end
            end
        end
        % should person recover now?
        if rand < recoveryConst && isInfected
            people(j, 1) = 2;
        end
    end
    % go measure people list
    for j = 1:numPeople
        if (people(j, 1) == 1)
            infected(t) = infected(t) + 1;
        end
        if (people(j, 1) == 2)
            recovered(t) = recovered(t) + 1;
        end
    end
end




end