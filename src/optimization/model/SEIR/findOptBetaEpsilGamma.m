function [res, error] = findOptBetaEpsilGamma(dataInfected, dataExposed, dataRecovered, init)
    newErrorFunct = @(a)errorSEIR(a, dataInfected, dataExposed, dataRecovered, init);
    options = optimset('MaxIter',1200); %%needs more iteration power than SIR
    [res, error] = fminsearch(newErrorFunct, [1 * 10^-2, 1* 10^-3, .5], options);
end