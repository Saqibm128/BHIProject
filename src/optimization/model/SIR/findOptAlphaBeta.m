function [res, error] = findOptAlphaBeta(dataInfected, dataRecovered, init) 
%% like SIR optimize but instead of using interpoplate true infected, attempt to 

    %initialize given data
    %create an error function
    newErrorFunct = @(a)errorSIR(a, dataInfected, dataRecovered, init);
    options = optimset('MaxIter',600);
    [res, error] = fminsearch(newErrorFunct, [1 * 10^-8, 1* 10^-1], options);
end
