function [res, error] = findOptAgentBased(dataInfect, dataRecovered, init)
%%init is country, numPeople, numInfected, numConnections,
initGuess = [.01, .1];
[res, error] = findOptAgentBasedInitVals(dataInfect, dataRecovered, init, initGuess);
end