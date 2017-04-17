function [newlyInfected, newlyRecovered] = AgentBasedGraph(numPeople, numInfected, numConnections, numTimeSteps) 
people = zeros(numPeople, numConnections + 2);
newlyInfected = 0;
newlyRecovered = 0;
%%instantiate random connections
for i = 1:numPeople
    for j = 1:numConnections
        people(i,j + 2) = randi(numPeople);
    end
end


end