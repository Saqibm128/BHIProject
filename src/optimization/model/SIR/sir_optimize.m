function [res, error] = sir_optimize(dataInfected, dataRecovered, init)
    %initialize given data
    %create an error function
    newErrorFunct = @(a)errorSIR(a, dataInfected, dataRecovered, init);
    options = optimset('MaxIter',200);
    [res, error] = fminsearch(newErrorFunct, [1 * 10^-6, 1* 10^-6], options);
    alpha = res(1);
    beta = res(2);
end