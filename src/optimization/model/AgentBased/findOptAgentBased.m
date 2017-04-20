function [res, error] = findOptAgentBased(dataInfect, dataRecovered, init)
%%init is countryCode, numPeople, numInfected, numConnections,
errorFunct = @(a)errorAgentBasedGraph(dataInfect, dataRecovered, init, a(1), a(2));
options = optimset('Display', 'iter'); %%needs more iteration power than SIR
[res, error] = fminsearch(errorFunct, [.01, .1], options);
end