function randomResetsSIR10000()
load('matlab.mat');

numRestarts = 100;
% preallocate array for alphas, betas, errors
alphaBetaErrorGuineaPop10000 = zeros(numRestarts, 3); 
alphaBetaErrorSierraLeone10000 = zeros(numRestarts, 3);
alphaBetaErrorLiberia10000 = zeros(numRestarts, 3);

fittedCasesGuinea = (fittedCases(:,1));
fittedDeathsGuinea = (fittedDeaths(:,1));
fittedCasesLiberia = fittedCases(:, 2);
fittedDeathsLiberia = fittedDeaths(:, 2);
fittedCasesSierraLeone = fittedCases(:, 3);
fittedDeathsSierraLeone = fittedDeaths(:, 3);



for i = 1:numRestarts
    alpha = rand() / 1000; %% random should always be 1/100 due to low proportion of population which got infected
    beta = rand(); %% people who are infected must recover quickly
    
    %%first do Liberia - get infected per day, recovered per day
    [trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(fittedCasesLiberia, fittedDeathsLiberia);
    [res, error] = findOptAlphaBetaInitial(trueInfected, trueRecovered, 10000, [alpha, beta]);
    alphaBetaErrorLiberia10000(i, 1) = res(1);
    alphaBetaErrorLiberia10000(i, 2) = res(2);
    alphaBetaErrorLiberia10000(i, 3) = error;
    
    %Guinea
    [trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(fittedCasesGuinea, fittedDeathsGuinea);
    [res, error] = findOptAlphaBetaInitial(trueInfected, trueRecovered, 10000, [alpha, beta]);
    alphaBetaErrorGuineaPop10000(i, 1) = res(1);
    alphaBetaErrorGuineaPop10000(i, 2) = res(2);
    alphaBetaErrorGuineaPop10000(i, 3) = error;
    
    %Sierra Leone
    [trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(fittedCasesSierraLeone, fittedDeathsSierraLeone);
    [res, error] = findOptAlphaBetaInitial(trueInfected, trueRecovered, 10000, [alpha, beta]);
    alphaBetaErrorSierraLeone10000(i, 1) = res(1);
    alphaBetaErrorSierraLeone10000(i, 2) = res(2);
    alphaBetaErrorSierraLeone10000(i, 3) = error;
end

csvwrite('alphabetaerrorsGuineaPop10000.csv', alphaBetaErrorGuineaPop10000);
csvwrite('alphabetaerrorsLiberiaPop10000.csv', alphaBetaErrorLiberia10000);
csvwrite('alphabetaerrorsSierraLeonePop10000.csv', alphaBetaErrorSierraLeone10000);