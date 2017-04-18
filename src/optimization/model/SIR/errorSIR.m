function errorVal = errorSIR(a, dataInfected, dataRecovered, init)
%% a is vector of alpha and beta
%% dataInfected is a vector to use to attempt to measure number of people infected at any single point
%% dataRecoverd is a vector of people who have recovered by any single point
%% init are the parameters to create with SIR

[t, x] = instantiateSIR(a(1),a(2), init, length(dataInfected));
errorValI = sum((x(:, 2) - dataInfected) .^ 2);
errorValR = sum((x(:, 3) - dataRecovered) .^ 2);
errorVal = errorValI + errorValR;
end