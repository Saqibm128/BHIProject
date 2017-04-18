function [alphabetavals, errorVal] = cvOptimizeSIR(a, cummDataInfected, init)
%% a is vector of alpha and beta for initial start
%% cumDataInfected is a vector to use to attempt to measure cummulative number of people infected at any single point
%% dataRecoverd is a vector of people who have recovered by any single point
%% init are the parameters to create with SIR
%% attempt to use initial alpha beta values, along side initial conditions, to get data
%% NOTE: cumDataInfected and dataRecovered are day granularity



errorFunct = @(result, dataset) errorSIRCummulative(result, dataset, init);
days = 1:length(cummDataInfected);
cummDataInfected = [cummDataInfected; days'];
% function result = trainfunct(dataset)
%     @(result)(error(result, d
% end
trainFunct = @(dataset)(fminsearch(@(result)(errorFunct(result, dataset)), a));


[alphabetavals, errorVal] = crossValidateError(cummDataInfected, errorFunct, trainFunct);