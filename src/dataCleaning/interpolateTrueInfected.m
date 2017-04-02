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
summedII = 12; % 6 + 6.3 ~= 12 days


%%initializations
trueInfected = zeroes(length(cummulativeInfected));
trueExposed = zeroes(length(cummulativeInfected));
trueRecovered = zeroes(length(cummulativeInfected));

for i = 1:6
    trueInfected(i) = cummulativeInfected(i);
    %%cannot properly calculate here, so using the original cummulative
end
for i = 7:12
    trueInfected(i) = trueInfected(i);
    trueExposed(i - daysIncubation) = trueInfected(i);
end


for i = 13:length(cummulativeInfected)
    trueInfected(i) = cummulativeInfected(i) - cummulativeInfected(i - daysInfectious);
    %%we assume that after summedII days, infected individuals leave
    %%population for recovered subpopulation
    trueInfected(i) = trueInfected(i) - cummulativeDead(i);
    %%we then remove those who have died from infected count
    trueExposed(i - daysIncubation) = trueInfected(i) - trueInfected(i - daysIncubation);
    
    %%we find change in num infected over an incubation period and assume
    %%that it reflects the true exposed. In reality, this skews distribution forward a
    %%bit, as not all exposed individuals would leave subpopulation at same
    %%time
    
    %%TODO find a way to incorporate death into trueExposed statistic, as
    %%well as prevent it from being so forward leaning
    trueRecovered(i - daysInfectious) = trueInfected(i);
end