function [res, error] = findOptAlphaBeta(cummDataInfected, init) 
%% like SIR optimize but instead of using interpoplate true infected, attempt to 
%% use cummulative data
    %initialize given data
    %create an error function
    newErrorFunct = @(a)errorSIRCummulative(a, cummDataInfected, init);
    options = optimset('MaxIter',600);
    [res, error] = fminsearch(newErrorFunct, [1 * 10^-6, 1* 10^-6], options);
end
