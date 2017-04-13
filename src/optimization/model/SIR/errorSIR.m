    function errorVal = errorSIR(a, dataInfected, dataRecovered, init)
        [t, x] = instantiateSIR(a(1),a(2), init, length(dataInfected));
        errorValI = sum((x(:, 2) - dataInfected) .^ 2);
        errorValR = sum((x(:, 3) - dataRecovered) .^ 2);
        errorVal = errorValI + errorValR;
    end