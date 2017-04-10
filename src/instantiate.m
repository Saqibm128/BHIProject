    function [t,x] = instantiate(a, b, init)
        alpha = a;
        beta = b;
        [time, vals] = ode23(@model, [1, 7], init);
        t = time;
        x = vals;
        function dSIR = model(t,SIR)
        
            dSIR(1) = -1.*alpha.*SIR(1).*SIR(2);
            dSIR(2) = alpha .* SIR(1).* SIR(2) - 1 .* beta .* SIR(2);
            dSIR(3) = beta .* SIR(2);
            dSIR = [dSIR(1) dSIR(2) dSIR(3)]';
        end
    end