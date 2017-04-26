function randomResetsSIR100000()
load('matlab.mat');

numRestarts = 100;
% preallocate array for alphas, betas, errors
alphaBetaErrorGuineaPop100000 = zeros(numRestarts, 3); 
alphaBetaErrorSierraLeone100000 = zeros(numRestarts, 3);
alphaBetaErrorLiberia100000 = zeros(numRestarts, 3);

fittedCasesGuinea = (fittedCases(:,1));
fittedDeathsGuinea = (fittedDeaths(:,1));
fittedCasesLiberia = fittedCases(:, 2);
fittedDeathsLiberia = fittedDeaths(:, 2);
fittedCasesSierraLeone = fittedCases(:, 3);
fittedDeathsSierraLeone = fittedDeaths(:, 3);



for i = 1:numRestarts
    alpha = rand() / 10000; %% random should always be 1/10000 due to low proportion of population which got infected
    beta = rand(); %% people who are infected must recover quickly
    
    %%first do Liberia - get infected per day, recovered per day
    [trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(fittedCasesLiberia, fittedDeathsLiberia);
    [res, error] = findOptAlphaBetaInitial(trueInfected, trueRecovered, 100000, [alpha, beta]);
    alphaBetaErrorLiberia100000(i, 1) = res(1);
    alphaBetaErrorLiberia100000(i, 2) = res(2);
    alphaBetaErrorLiberia100000(i, 3) = error;
    
    %Guinea
    [trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(fittedCasesGuinea, fittedDeathsGuinea);
    [res, error] = findOptAlphaBetaInitial(trueInfected, trueRecovered, 100000, [alpha, beta]);
    alphaBetaErrorGuineaPop100000(i, 1) = res(1);
    alphaBetaErrorGuineaPop100000(i, 2) = res(2);
    alphaBetaErrorGuineaPop100000(i, 3) = error;
    
    %Sierra Leone
    [trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(fittedCasesSierraLeone, fittedDeathsSierraLeone);
    [res, error] = findOptAlphaBetaInitial(trueInfected, trueRecovered, 100000, [alpha, beta]);
    alphaBetaErrorSierraLeone100000(i, 1) = res(1);
    alphaBetaErrorSierraLeone100000(i, 2) = res(2);
    alphaBetaErrorSierraLeone100000(i, 3) = error;
end

csvwrite('alphabetaerrorsGuineaPop100000.csv', alphaBetaErrorGuineaPop100000);
csvwrite('alphabetaerrorsLiberiaPop100000.csv', alphaBetaErrorLiberia100000);
csvwrite('alphabetaerrorsSierraLeonePop100000.csv', alphaBetaErrorSierraLeone100000);