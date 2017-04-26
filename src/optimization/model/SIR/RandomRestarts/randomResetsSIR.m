function randomResetsSIR()
load('matlab.mat');

numRestarts = 100;
% preallocate array for alphas, betas, errors
alphaBetaErrorGuineaPop = zeros(numRestarts, 3); 
alphaBetaErrorSierraLeone = zeros(numRestarts, 3);
alphaBetaErrorLiberia = zeros(numRestarts, 3);

fittedCasesGuinea = (fittedCases(:,1));
fittedDeathsGuinea = (fittedDeaths(:,1));
fittedCasesLiberia = fittedCases(:, 2);
fittedDeathsLiberia = fittedDeaths(:, 2);
fittedCasesSierraLeone = fittedCases(:, 3);
fittedDeathsSierraLeone = fittedDeaths(:, 3);



for i = 1:numRestarts
    alpha = rand() / 50000; %% random should always be 1/50000 due to low proportion of population which got infected
    beta = rand(); %% people who are infected must recover quickly
    
    %%first do Liberia - get infected per day, recovered per day
    [trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(fittedCasesLiberia, fittedDeathsLiberia);
    [res, error] = findOptAlphaBetaInitial(trueInfected, trueRecovered, nLiberia, [alpha, beta]);
    alphaBetaErrorLiberia(i, 1) = res(1);
    alphaBetaErrorLiberia(i, 2) = res(2);
    alphaBetaErrorLiberia(i, 3) = error;
    
    %Guinea
    [trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(fittedCasesGuinea, fittedDeathsGuinea);
    [res, error] = findOptAlphaBetaInitial(trueInfected, trueRecovered, nGuinea, [alpha, beta]);
    alphaBetaErrorGuineaPop(i, 1) = res(1);
    alphaBetaErrorGuineaPop(i, 2) = res(2);
    alphaBetaErrorGuineaPop(i, 3) = error;
    
    %Sierra Leone
    [trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(fittedCasesSierraLeone, fittedDeathsSierraLeone);
    [res, error] = findOptAlphaBetaInitial(trueInfected, trueRecovered, nSierraLeone, [alpha, beta]);
    alphaBetaErrorSierraLeone(i, 1) = res(1);
    alphaBetaErrorSierraLeone(i, 2) = res(2);
    alphaBetaErrorSierraLeone(i, 3) = error;
end

csvwrite('alphabetaerrorsGuineaPop.csv', alphaBetaErrorGuineaPop);
csvwrite('alphabetaerrorsLiberiaPop.csv', alphaBetaErrorLiberia);
csvwrite('alphabetaerrorsSierraLeonePop.csv', alphaBetaErrorSierraLeone);