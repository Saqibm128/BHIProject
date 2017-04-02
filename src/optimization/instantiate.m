function [t,x] = instantiate(a, b)
        init = [99, 1, 0];
        alpha = a;
        beta = b;
        function dSIR = model(t,SIR)
            dSIR = [0; 0; 0];
            dSIR(1) = -1.*alpha.*SIR(1).*SIR(2);
            dSIR(2) = alpha .* SIR(1).* SIR(2) - 1 .* beta .* SIR(2); 
            dSIR(3) = beta .* SIR(2);
        end
        [time, vals] = ode45(@model, 1:1:20, init);
        t = time;
        x = vals;
        
    end