function [t, x] = iterOde(funct, init, maxNum, numSplits)
%%ODE 45 is extraordinarily slow here so iterative Monte Carlo is appropriate for
%%cross validation studies
%%  @param numSplits tells how accurate to be
%%  more splits means more accuracy but longer time
%%  @param funct is the ODE to try to evaluate (takes params(t, SIR))
%%  @param init is the initial configuration of the ODE

% initialize variables
lengthOfX = length(init);
x = zeros(maxNum, lengthOfX);
x(1,:) = init; 
t = 1:maxNum;

for i = 2:maxNum
    %returns dX
    splitInterval = 1.0/numSplits;
    tempX = zeros(numSplits + 1, lengthOfX); %holds info for split monte carlo
    tempX(1,:) = x(i - 1,:); %initialize tempX with last value
    for j = 1:numSplits
        dX = funct(i, tempX(j,:));
        tempX(j + 1, :) = tempX(j,:) + dX .* splitInterval;
    end
    x(i, :) = tempX(numSplits + 1, :);
end
end