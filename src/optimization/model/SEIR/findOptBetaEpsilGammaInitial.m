function [res, error] = findOptBetaEpsilGammaInitial(dataInfected, dataExposed, dataRecovered, initSEIR, initBetaEpsilGamma) 
    newErrorFunct = @(a)errorSEIR(a, dataInfected, dataExposed, dataRecovered, initSEIR);
    options = optimset('MaxIter',1200); %%needs more iteration power than SIR
    [res, error] = fminsearch(newErrorFunct, initBetaEpsilGamma, options);
end