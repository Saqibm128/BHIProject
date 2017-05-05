function randomRestartsAGB()
%% explore starting points for fminsearch for SEIR

load('matlab.mat');

numRestarts = 20;
% preallocate array for alphas, betas, errors
probErrorGuinea = zeros(numRestarts, 5); 
probErrorSierraLeone = zeros(numRestarts, 5);
probErrorLiberia = zeros(numRestarts, 5);

fittedCasesGuinea = (fittedCases(:,1));
fittedDeathsGuinea = (fittedDeaths(:,1));
fittedCasesLiberia = fittedCases(:, 2);
fittedDeathsLiberia = fittedDeaths(:, 2);
fittedCasesSierraLeone = fittedCases(:, 3);
fittedDeathsSierraLeone = fittedDeaths(:, 3);



for i = 1:numRestarts
    probInfected = rand();
    probRecovered = rand(); %% people who are infected may vary
    numPeople = randi(50000) + 1; %% trying to limit numPeople to below 1 million
    numConnect = randi(5) + 1; %% try to control number of connections among each of the nodes
    %%first do Liberia - get infected per day, recovered per day
    [trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(fittedCasesLiberia, fittedDeathsLiberia);
    [res, error] = findOptAgentBasedInitVals(trueInfected, trueRecovered, [{'Liberia'}, numPeople, 1, numConnect], [probInfected, probRecovered], 20);    
    probErrorLiberia(i, 1) = res(1);
    probErrorLiberia(i, 2) = res(2);
    probErrorLiberia(i, 3) = error;
    probErrorLiberia(i, 4) = numPeople;
    probErrorLiberia(i, 5) = numConnect;
    
    %Guinea
    [trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(fittedCasesGuinea, fittedDeathsGuinea);
    [res, error] = findOptAgentBasedInitVals(trueInfected, trueRecovered, [{'Guinea'}, numPeople, 1, numConnect], [probInfected, probRecovered], 20);    
    probErrorGuinea(i, 1) = res(1);
    probErrorGuinea(i, 2) = res(2);probErrorLiberia(i, 1) = res(1);
    probErrorGuinea(i, 2) = res(2);
    probErrorGuinea(i, 3) = error;
    probErrorGuinea(i, 4) = numPeople;
    probErrorGuinea(i, 5) = numConnect;
    
    %Sierra Leone
    [trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(fittedCasesSierraLeone, fittedDeathsSierraLeone);
    [res, error] = findOptAgentBasedInitVals(trueInfected, trueRecovered, [{'Sierra Leone'}, numPeople, 1, numConnect], [probInfected, probRecovered], 20);    
    probErrorSierraLeone(i, 1) = res(1);
    probErrorSierraLeone(i, 2) = res(2);probErrorLiberia(i, 1) = res(1);
    probErrorSierraLeone(i, 2) = res(2);
    probErrorSierraLeone(i, 3) = error;
    probErrorSierraLeone(i, 4) = numPeople;
    probErrorSierraLeone(i, 5) = numConnect;
end

csvwrite('AGBProbErrorsGuineaNaturalPopAttempt2.csv', probErrorGuinea);
csvwrite('AGBProbErrorsEpsilLiberiaPopNaturalPopAttempt2.csv', probErrorLiberia);
csvwrite('AGBProbErrorsEpsilSierraLeonePopNaturalPopAttempt2.csv', probErrorSierraLeone);