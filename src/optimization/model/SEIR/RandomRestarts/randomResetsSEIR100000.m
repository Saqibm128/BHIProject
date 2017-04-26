function randomResetsSEIR100000()
%% explore starting points for fminsearch for SEIR

load('matlab.mat');

numRestarts = 100;
% preallocate array for alphas, betas, errors
betaEpsilGammaErrorGuineaPop = zeros(numRestarts, 4); 
betaEpsilGammaErrorSierraLeone = zeros(numRestarts, 4);
betaEpsilGammaErrorLiberia = zeros(numRestarts, 4);

fittedCasesGuinea = (fittedCases(:,1));
fittedDeathsGuinea = (fittedDeaths(:,1));
fittedCasesLiberia = fittedCases(:, 2);
fittedDeathsLiberia = fittedDeaths(:, 2);
fittedCasesSierraLeone = fittedCases(:, 3);
fittedDeathsSierraLeone = fittedDeaths(:, 3);



for i = 1:numRestarts
    alpha = rand() / 1000; %% random should always be 1/10000 due to low proportion of population which got infected
    beta = rand(); %% people who are infected may vary
    epsilon = rand();
    
    %%first do Liberia - get infected per day, recovered per day
    [trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(fittedCasesLiberia, fittedDeathsLiberia);
    [res, error] = findOptBetaEpsilGammaInitial(trueInfected, trueExposed, trueRecovered, [100000, 0, 1, 0], [alpha, beta, epsilon]);
    betaEpsilGammaErrorLiberia(i, 1) = res(1);
    betaEpsilGammaErrorLiberia(i, 2) = res(2);
    betaEpsilGammaErrorLiberia(i, 3) = res(3);
    betaEpsilGammaErrorLiberia(i, 4) = error;
    
    %Guinea
    [trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(fittedCasesGuinea, fittedDeathsGuinea);
    [res, error] = findOptBetaEpsilGammaInitial(trueInfected, trueExposed, trueRecovered, [100000, 0, 1, 0], [alpha, beta, epsilon]);
    betaEpsilGammaErrorGuineaPop(i, 1) = res(1);
    betaEpsilGammaErrorGuineaPop(i, 2) = res(2);
    betaEpsilGammaErrorGuineaPop(i, 3) = res(3);
    betaEpsilGammaErrorGuineaPop(i, 4) = error;
    
    %Sierra Leone
    [trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(fittedCasesSierraLeone, fittedDeathsSierraLeone);
    [res, error] = findOptBetaEpsilGammaInitial(trueInfected, trueExposed, trueRecovered, [100000, 0, 1, 0], [alpha, beta, epsilon]);
    betaEpsilGammaErrorSierraLeone(i, 1) = res(1);
    betaEpsilGammaErrorSierraLeone(i, 2) = res(2);
    betaEpsilGammaErrorSierraLeone(i, 3) = res(3);
    betaEpsilGammaErrorSierraLeone(i, 4) = error;
end

csvwrite('BetaEpsilGammaErrorsGuineaNaturalPop100000.csv', betaEpsilGammaErrorGuineaPop);
csvwrite('BetaEpsilGammaErrorsEpsilLiberiaPopNaturalPop100000.csv', betaEpsilGammaErrorLiberia);
csvwrite('BetaEpsilGammaErrorsEpsilSierraLeonePopNaturalPop100000.csv', betaEpsilGammaErrorSierraLeone);