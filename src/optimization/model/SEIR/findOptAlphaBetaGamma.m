function [res, error] = findOptAlphaBetaGamma(cummDataInfected, init)
    newErrorFunct = @(a)errorSEIRCummulative(a, cummDataInfected, init);
    options = optimset('MaxIter',600);
    [res, error] = fminsearch(newErrorFunct, [1 * 10^-3, 1* 10^-3, .5], options);
end