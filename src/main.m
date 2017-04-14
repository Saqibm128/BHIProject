%%Main script to analyze data

%%initialize and read data
nGuinea = 11.75 * 10 ^ 6;
nLiberia = 4.3 * 10 ^ 6;
nSierraLeone = 6.092 * 10 ^ 6;

%%to change later
nGuinea = 30000;
nLiberia = 30000;
nSierraLeone = 30000;

[fittedCases, fittedDeaths, casesError, deathsError] = readData(false);
fittedCasesGuinea = (fittedCases(:,1) ./ nGuinea) * 100;
fittedDeathsGuinea = (fittedDeaths(:,1)./ nGuinea) * 100;
[trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(fittedCasesGuinea, fittedDeathsGuinea);

enGraph = true;

%%TODO:Sanity check with interpolated data



if (enGraph)
plot(trueInfected)
hold on
plot(trueExposed)
hold on
plot(trueRecovered)
legend('Infected in Guinea', 'Exposed in Guinea', 'Recovered in Guinea')
xlabel('Days Since Start')
ylabel('People')
end



[alphaBetaVal, error] = sir_optimize(trueInfected, trueRecovered, nGuinea);
disp('alpha Guinea and beta Guinea')
disp(alphaBetaVal)
disp('error Guinea')
disp(error)
disp('')

%Liberia
[trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected((fittedCases(:, 2) ./ nLiberia) * 100, (fittedDeaths(:, 2) ./ nLiberia) * 100);

[alphaBetaVal, error] = sir_optimize(trueInfected, trueRecovered, 100);
disp('alpha Liberia, beta liberia')
disp(alphaBetaVal)
disp('error')
disp(error)

%Sierra Leone
[trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected((fittedCases(:, 3) ./ nSierraLeone) * 100, (fittedDeaths(:, 3) ./ nSierraLeone) * 100);

[alphaBetaVal, error] = sir_optimize(trueInfected, trueRecovered, 100);
disp('alpha Sierra Leone, beta Sierra Leone')
disp(alphaBetaVal)
disp('error Sierra Leone')
disp(error)

%all of West Africa
% allCases = fittedCases(:, 1) + fittedCases(:,2) + fittedCases(:,3);
% allDeaths = fittedDeaths(:,1) + fittedDeaths(:,2) + fittedDeaths(:,3);
% nTotal = nSierraLeone + nLiberia + nGuinea;
% [trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(allCases, allDeaths);
% 
% [alpha, beta] = sir_optimize(trueInfected, trueRecovered, nTotal);
% disp('alpha West Africa')
% disp(alpha)
% disp('beta West Africa')
disp(error)
