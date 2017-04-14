function [res, error] = sir_optimize(dataInfected, dataRecovered, initS)
    %initialize given data
    init = [initS, 1 * 10 ^ -7, 0];
    %create an error function
    newErrorFunct = @(a)errorSIR(a, dataInfected, dataRecovered, init);
    options = optimset('MaxIter',200);
    [res, error] = fminsearch(newErrorFunct, [1 * 10^-6, 1* 10^-6], options);
    alpha = res(1);
    beta = res(2);
    [t, x] = instantiateSIR(alpha, beta, init, length(dataInfected));
    plot(t, x);
    hold on;
    plot(dataInfected);
    plot(dataRecovered);

end