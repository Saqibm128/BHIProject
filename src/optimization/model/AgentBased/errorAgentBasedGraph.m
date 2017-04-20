function errorVal = errorAgentBasedGraph(dataInfected, dataRecovered, init, infectP, recoverP)
%%init is countryCode, numPeople, numInfected, numConnections,
numTimesteps = length(dataInfected);
[infected, recovered] = AgentBasedGraph(init(1), init(2), init(3), init(4), numTimesteps, infectP, recoverP);
errorVal = sum((infected - dataInfected) .^2) + sum((recovered - dataRecovered) .^2);
end