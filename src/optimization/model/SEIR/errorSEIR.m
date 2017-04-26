function errorVal = errorSEIR(a, dataExposed, dataInfected, dataRecovered, initSEIR)
%ERRORSEIR measures error of betaEpsilGamma vals stored in a
%% a is the vector of [beta epsilon gamma]
%% dataExposed is people CURRENTLY exposed
%% dataInfected is people CURRENTLY infected
%% dataRecovere is people CURRENTLY recovered
%% initSEIR is initial distibution of population
numToGen = length(dataInfected);
[t, x] = instantiateSEIR(a(1), a(2), a(3), initSEIR, numToGen);
errorValE = sum((x(:, 2) - dataExposed) .^ 2);
errorValI = sum((x(:, 3) - dataInfected) .^ 2);
errorValR = sum((x(:, 4) - dataRecovered) .^ 2);
errorVal = errorValI + errorValR + errorValE;
end

