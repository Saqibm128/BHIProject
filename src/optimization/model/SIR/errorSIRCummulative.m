    function errorVal = errorSIRCummulative(a, dataInfected, init)
    %%This is a function similar to errorSIR but uses cummulative dataInfected
    %%in other words, i do not attempt to extrapolate dataInfected per day info
    [t, x] = instantiateSIR(a(1),a(2), init, length(dataInfected));
    expectedInfected = x(:,2);
    integratedExpectedInfected = zeros(length(x), 1); %% initialize
    for i =  1:length(x)
      integratedExpectedInfected(i) = trapz(expectedInfected(1:i)); %%get a slowly expanding integration
    end
    errorValI = sum((integratedExpectedInfected - dataInfected) .^ 2);
    errorVal = errorValI;
    end
