function [trueInfected, trueExposed, trueRecovered] = interpolateTrueInfected(cummulativeInfected, cummulativeDead)
%% Attempt to extrapolate information about exactly how many individuals are infected during a time slice
%%  Solve problem with WHO not recording number of recovered individuals
%%  FOR USE WITH SIR AND SEIR
%% @param cummulativeInfected the number of individuals infected since beginning
%% @param cummulativeDead number dead since beginning
%% @return trueInfected number of individuals believed to be CURRENTLY infected
%% @return trueRecovered cummulative number of individuals who have recovered

daysIncubation = 6; %mean incubation as per CDC paper (actually ~6.3 days)
daysInfectious = 6; %mean data as per CDC paper
summedII = daysIncubation + daysInfectious; % 6 + 6.3 ~= 12 days


%%initializations
trueInfected = zeros(length(cummulativeInfected), 1);
trueExposed = zeros(length(cummulativeInfected), 1);
trueRecovered = zeros(length(cummulativeInfected), 1);
i = 1;
%before data is useful
while cummulativeInfected(i) == 0 || cummulativeInfected(i + 1) == 0
    trueInfected(i) = cummulativeInfected(i);
    i = i + 1;
    %%cannot properly calculate here, so using the original cummulative
end
%we cannot easily calculate anything useful here
for j = i :i+daysIncubation
    trueInfected(j) = cummulativeInfected(j);
end
for j = i + daysIncubation + 1:i+summedII
    trueInfected(j) = cummulativeInfected(j);
    trueExposed(j - daysIncubation) = trueInfected(j);
end

%%attempt to interpolate data
for j = (i + summedII + 1):length(cummulativeInfected)
    trueInfected(j) = cummulativeInfected(j) - cummulativeInfected(j - daysInfectious);
    %%we assume that after summedII days, infected individuals leave
    %%population for recovered subpopulation
    %%trueInfected(i) = trueInfected(i) - cummulativeDead(i) - cummulativeDead(i - daysInfectious);
    %%TODO:take into account dead
    %%we then remove those who have died from infected count
    trueExposed(j - daysIncubation) = trueInfected(j) - trueInfected(j - daysIncubation);
    
    %%we find change in num infected over an incubation period and assume
    %%that it reflects the true exposed. In reality, this skews distribution forward a
    %%bit, as not all exposed individuals would leave subpopulation at same
    %%time
    
    %%TODO find a way to incorporate death into trueExposed statistic, as
    %%well as prevent it from being so forward leaning
    trueRecovered(j) = cummulativeInfected(j) - trueInfected(j);
    %%num recovered is total who were ever infected - number who are
    %%infected now
    %%assume dead is another word for infected @TODO:dont assume this
    
end