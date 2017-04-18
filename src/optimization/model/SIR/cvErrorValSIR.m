function errorVal = cvErrorValSIR(a, dataInfected, init)
%% a is vector of alpha and beta
%% dataInfected is a vector to use to attempt to measure number of people infected at any single point, alongside date
%% dataRecoverd is a vector of people who have recovered by any single point, alongside date
%% init are the parameters to create with SIR
%% 
%% This error function is for cross validation error with an SIR model,
    [t, x] = instantiateSIR(a(1),a(2), init, length(dataInfected));
    expectedInfected = x(:,2);
    integratedExpectedInfected = zeros(length(x), 1); %% initialize
    for i =  1:length(x)
      integratedExpectedInfected(i) = trapz(expectedInfected(1:i)); %%get a slowly expanding integration
    end
    for i = 1:length(dataInfected)
        date = dataInfected(i, 2);
        errorValI = errorValI + (dataInfected(i,1) - expectedInfected(date)) .^ 2;
    end
    errorVal = errorValI;
    end