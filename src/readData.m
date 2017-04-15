function[fittedCases, fittedDeaths, casesError, deathsError] = readData(enGraph)
%@param enGraph represents if we wanna graph the things or not
%@return fittedCases represents the number of cases data fitted to a
%piecewise function (j, i) where i is country number, j is index
%% Order of vectors: Guinea, Liberia, Sierra Leone
%@return represents the number of deaths fitted to a piecewise function
%@return casesError representing summed squared errors from cases fit
%@return deathsError representing summed squared errors form deaths fit
clc;
clf();
close all
%holds imported data from excel spreadsheet on ebola epidemic from WHO
%   dataset
load('EbolaDataFiles.mat');

%%function definiton for linear interpolation

%Drawn from 2013 data, this is total population data

nGuinea = 11.75 * 10 ^ 6;
nLiberia = 4.3 * 10 ^ 6;
nSierraLeone = 6.092 * 10 ^ 6;

%initialize variables
casesDatasets = [TotalCasesGuinea, TotalCasesLiberia, TotalCasesSierraLeone];
deathsDatasets = [TotalDeathsGuinea, TotalDeathsLiberia, TotalDeathsSierraLeone];
countryNames = {'Guinea', 'Liberia', 'Sierra Leone'};

%return variables
fittedCases = zeros(length(casesDatasets), length(casesDatasets(1,:)));
fittedDeaths = zeros(length(casesDatasets), length(casesDatasets(1,:)));
casesError = 0;
deathsError = 0;


for i = 1:length(casesDatasets(1,:))
    %initialize the datasets we wish to use this iteration
    TotalCasesCountry = casesDatasets(:,i); %Stores the current country
    TotalDeathsCountry = deathsDatasets(:,i);
    
    %This is exponential fitting, along with graph to see how well it works out
    x = 1:floor(length(DaysSinceStart)/2);
    firstHalfCases = fit(DaysSinceStart(x), TotalCasesCountry(x),'exp1');

    if(enGraph)
        figure();
        plot(firstHalfCases);
        hold on
        plot(DaysSinceStart, TotalCasesCountry);
        title(strcat('Exponential Fitting, First 78 days, Total Cases:', countryNames(i)));
        legend('Fitted Curve', 'Raw Data');
        xlabel('Days Since Start of Recordkeeping');
        ylabel('Number Of Cases');
    end


    %This is a polynomial curve fitting and plotting
    x = (floor(length(DaysSinceStart)/2) + 1):length(DaysSinceStart);
    secondHalfCases = fit(DaysSinceStart(x), TotalCasesCountry(x), 'poly5');
    if(enGraph)
        figure();
        plot(secondHalfCases);

        hold on
        plot(DaysSinceStart, TotalCasesCountry);
        title(strcat('5th Order Polynomial Fitting, Second 78 days, Total Cases:', countryNames(i)));
        legend('Fitted Curve', 'Raw Data');
        xlabel('Days');
        ylabel('Number Of Cases');
    end
    %use fit functions to generate new points
    lastDay = DaysSinceStart(length(DaysSinceStart));
    midDay = DaysSinceStart(length(DaysSinceStart)/2);
    for j = 1:lastDay;
        if (j < midDay)
            fittedCases(j,i) = (firstHalfCases(j));
        else
            fittedCases(j,i) = (secondHalfCases(j));
        end
        %casesError = casesError + (fittedCases(j,i) - TotalCasesCountry(j))^2;
        %TODO: fix the casesError datapoint
    end
    
    
    x = 1:floor(length(DaysSinceStart)/2);
    firstHalfDeaths = fit(DaysSinceStart(x), TotalDeathsCountry(x),'exp1');

    if(enGraph)
        figure();
        plot(firstHalfDeaths);
        hold on
        plot(DaysSinceStart, TotalDeathsCountry);
        title(strcat('Exponential Fitting, First 78 days, Total Deaths:', countryNames(i)));
        legend('Fitted Curve', 'Raw Data');
        xlabel('Days Since Start of Recordkeeping');
        ylabel('Number Of Cases');
    end


    %This is a polynomial curve fitting and plotting
    x = floor(length(DaysSinceStart)/2 + 1):length(DaysSinceStart);
    secondHalfDeaths = fit(DaysSinceStart(x), TotalDeathsCountry(x), 'poly5');
    if(enGraph)
        figure();

        plot(secondHalfDeaths);
        hold on
        plot(DaysSinceStart, TotalDeathsCountry);
        title(strcat('5th Order Polynomial Fitting, Second 78 days, Total Deaths:', countryNames(i)));
        legend('Fitted Curve', 'Raw Data');
        xlabel('Days');
        ylabel('Number Of Cases');
    end
    %use fit functions to generate new points
    for j = 1:lastDay
        if (j < midDay)
            fittedDeaths(j,i) = (firstHalfDeaths(j));
        else
            fittedDeaths(j,i) = (secondHalfDeaths(j));
        end
        %%deathsError = deathsError + (fittedDeaths(j,i) - TotalDeathsCountry(j))^2;
        %% TODO: fixd deathsError
    end
    
    
    
end
end