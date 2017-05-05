function [res, error] = findOptAgentBasedInitVals(dataInfect, dataRecovered, init, initGuess, varargin)
%% init is country, numPeople, numInfected, numConnections,
errorFunct = @(a)errorAgentBasedGraph(dataInfect, dataRecovered, init, a(1), a(2));
if (nargin == 5)
    maxIter = varargin{1};
else
    maxIter = 40;
end
options = optimset('Display', 'iter', 'MaxIter', maxIter); %%needs more iteration power than SIR
[res, error] = fminsearch(errorFunct, initGuess, options);
end