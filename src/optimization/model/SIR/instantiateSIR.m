    function [t,x] = instantiateSIR(a, b, init, num)
        alpha = a;
        beta = b;
        instSirModel = @(t, x)SIRModel(t, x, a, b); %instantiated Sir model
        [time, vals] = iterOde(instSirModel, init, num, 500);
        t = time;
        x = vals;
        function dSIR = model(t, SIR)
        
            dSIR(1) = -1.*alpha.*SIR(1).*SIR(2);
            dSIR(2) = alpha .* SIR(1).* SIR(2) - 1 .* beta .* SIR(2);
            dSIR(3) = beta .* SIR(2);
            dSIR = [dSIR(1) dSIR(2) dSIR(3)]';
        end
    end