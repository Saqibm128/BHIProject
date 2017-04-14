function [alpha, beta] = sir_optimize(dataInfected, dataRecovered, init)
    %initialize given data
    %create an error function
    newErrorFunct = @(a)errorSIR(a, dataInfected, dataRecovered, init);
    options = optimset('MaxIter',200);
    [alpha, beta] = fminsearch(newErrorFunct, [1 * 10^-6, .5], options); %%assume we get small infection rates
end