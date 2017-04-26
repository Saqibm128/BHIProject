function [res, error] = findOptBetaEpsilGamma(dataInfected, dataExposed, dataRecovered, initSEIR)
    initBetaEpsilGamma = [1 * 10^-2, 1* 10^-3, .5];
    [res, error] = findOptBetaEpsilGammaInitial(dataInfected, dataExposed, dataRecovered, initSEIR, initBetaEpsilGamma);
end