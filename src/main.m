%%Main script to analyze data

%%initialize and read data
nGuinea = 11.75 * 10 ^ 6;
nLiberia = 4.3 * 10 ^ 6;
nSierraLeone = 6.092 * 10 ^ 6;

[fittedCases, fittedDeaths, casesError, deathsError] = readData(false);
fittedCasesGuinea = fittedCases(:,1);
fittedDeathsGuinea = fittedDeaths(:,1);
[trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(fittedCasesGuinea, fittedDeathsGuinea);

enGraph = false;

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



[alpha, beta] = sir_optimize(trueInfected, trueRecovered, nGuinea);
disp('alpha Guinea')
disp(alpha)
disp('beta Guinea')
disp(beta)

%Liberia
[trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(fittedCases(:, 2), fittedDeaths(:, 2));

[alpha, beta] = sir_optimize(trueInfected, trueRecovered, nLiberia);
disp('alpha Liberia')
disp(alpha)
disp('beta Liberia')
disp(beta)

%Sierra Leone
[trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(fittedCases(:, 3), fittedDeaths(:, 3));

[alpha, beta] = sir_optimize(trueInfected, trueRecovered, nSierraLeone);
disp('alpha Sierra Leone')
disp(alpha)
disp('beta Sierra Leone')
disp(beta)

%all of West Africa
allCases = fittedCases(:, 1) + fittedCases(:,2) + fittedCases(:,3);
allDeaths = fittedDeaths(:,1) + fittedDeaths(:,2) + fittedDeaths(:,3);
nTotal = nSierraLeone + nLiberia + nGuinea;
[trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(allCases, allDeaths);

[alpha, beta] = sir_optimize(trueInfected, trueRecovered, nTotal);
disp('alpha West Africa')
disp(alpha)
disp('beta West Africa')
disp(beta)
