    function dSIR = SIRModel(t,SIR, alpha, beta)
        dSIR = zeros(3, 1);
        dSIR(1) = -1.*alpha.*SIR(1).*SIR(2);
        dSIR(2) = alpha .* SIR(1).* SIR(2) - 1 .* beta .* SIR(2);
        dSIR(3) = beta .* SIR(2);
        dSIR = [dSIR(1) dSIR(2) dSIR(3)];
    end