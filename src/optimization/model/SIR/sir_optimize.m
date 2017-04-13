function [alpha, beta] = sir_optimize(dataInfected, dataRecovered, initS)
    %initialize given data
    init = [initS, 1 * 10 ^ -7, 0];
    %create an error function
    newErrorFunct = @(a)errorSIR(a, dataInfected, dataRecovered, init);
    options = optimset('MaxIter',200);
    [alpha, beta] = fminsearch(newErrorFunct, [1 * 10^-6, 1* 10^-6], options);
end