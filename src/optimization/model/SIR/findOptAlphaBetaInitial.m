function [res, error] = findOptAlphaBetaInitial(dataInfected, dataRecovered, initialS, initialStart) 
%% like SIR optimize but instead of using interpoplate true infected, attempt to 

    %initialize given data
    %create an error function
    initSIR = [initialS, 1, 0];
    newErrorFunct = @(a)errorSIR(a, dataInfected, dataRecovered, initSIR);
    options = optimset('MaxIter',1200);
    
    [res, error] = fminsearch(newErrorFunct, initialStart, options);
end