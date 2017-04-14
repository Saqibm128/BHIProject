<<<<<<< HEAD
function [res, error] = sir_optimize(dataInfected, dataRecovered, initS)
=======
function [alpha, beta] = sir_optimize(dataInfected, dataRecovered, init)
>>>>>>> SIR
    %initialize given data
    %create an error function
    newErrorFunct = @(a)errorSIR(a, dataInfected, dataRecovered, init);
    options = optimset('MaxIter',200);
<<<<<<< HEAD
    [res, error] = fminsearch(newErrorFunct, [1 * 10^-6, 1* 10^-6], options);
    alpha = res(1);
    beta = res(2);
    [t, x] = instantiateSIR(alpha, beta, init, length(dataInfected));
    plot(t, x);
    hold on;
    plot(dataInfected);
    plot(dataRecovered);

=======
    [alpha, beta] = fminsearch(newErrorFunct, [1 * 10^-6, .5], options); %%assume we get small infection rates
>>>>>>> SIR
end