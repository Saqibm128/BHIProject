function [alpha, beta] = sir_optimize(dataInfected, dataRecovered, initS)
    %initialize given data
    init = [initS, 1, 0];
    
    i = 0;
    %create an error function
    function errorVal = error(a)
        [t, x] = instantiate(a(1),a(2), init);
        i = i + 1;
        disp(i)


        errorValI = sum((x(:, 2) - dataInfected(tVal)) .^ 2);
        errorValR = sum((x(:, 3) - dataRecovered(tVal)) .^ 2);
        errorVal = errorValI + errorValR;
    end
    options = optimset('MaxIter',200);
    [alpha beta] = fminsearch(@error, [.01 .01], options);
end