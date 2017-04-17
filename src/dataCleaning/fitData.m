function [fittedCases, fittedDeaths] = fitData(TotalCasesCountry, TotalDeathsCountry, DaysSinceStart);
fittedCases = zeros(length(TotalCasesCountry), 1);
fittedDeaths = zeros(length(TotalDeathsCountry), 1);
casesError = 0;
deathsError = 0;


%This is exponential fitting, along with graph to see how well it works out
x = 1:floor(length(DaysSinceStart)/2);
firstHalfCases = fit(DaysSinceStart(x), TotalCasesCountry(x),'exp1');



%This is a polynomial curve fitting and plotting
x = (floor(length(DaysSinceStart)/2) + 1):length(DaysSinceStart);
secondHalfCases = fit(DaysSinceStart(x), TotalCasesCountry(x), 'poly5');

%use fit functions to generate new points
lastDay = DaysSinceStart(length(DaysSinceStart));
midDay = DaysSinceStart(length(DaysSinceStart)/2);
for j = 1:lastDay;
    if (j < midDay)
        fittedCases(j) = (firstHalfCases(j));
    else
        fittedCases(j) = (secondHalfCases(j));
    end
    %casesError = casesError + (fittedCases(j,i) - TotalCasesCountry(j))^2;
    %TODO: fix the casesError datapoint
end


x = 1:floor(length(DaysSinceStart)/2);
firstHalfDeaths = fit(DaysSinceStart(x), TotalDeathsCountry(x),'exp1');


%This is a polynomial curve fitting and plotting
x = floor(length(DaysSinceStart)/2 + 1):length(DaysSinceStart);
secondHalfDeaths = fit(DaysSinceStart(x), TotalDeathsCountry(x), 'poly5');

%use fit functions to generate new points
for j = 1:lastDay
    if (j < midDay)
        fittedDeaths(j) = (firstHalfDeaths(j));
    else
        fittedDeaths(j) = (secondHalfDeaths(j));
    end
    %%deathsError = deathsError + (fittedDeaths(j,i) - TotalDeathsCountry(j))^2;
    %% TODO: fixd deathsError
end