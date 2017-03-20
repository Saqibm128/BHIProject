function [alpha, beta, gamma] = sir_optimize(dataInfected)
    %initialize given data
    init = [99, 1, 0];
    
    %standard sir equations
    function dSIR = model(t,SIR)
        dSIR = [0; 0; 0];
        dSIR(1) = -1.*alpha.*SIR(1).*SIR(2);
        dSIR(2) = alpha .* SIR(1).* SIR(2) - 1 .* beta .* SIR(2); -1 .* gamma;
        dSIR(3) = beta .* SIR(2);
    end
    alpha = 1;
    beta = 2;
    gamma = 1;
    
    %create a function whose job is to substitute alpha and beta
    function [t,x] = instantiate(a, b, g)
        alpha = a;
        beta = b;
        gamma = g;
        [time, vals] = ode45(@model, 0:1:length(dataInfected), init);
        t = time;
        x = vals;
    end
    
    %create an error function
    function errorVal = error(a)
        errorVal = 0;
        [t,x] = instantiate(a(1),a(2), a(3));
        for tVal = 1:1:length(dataInfected)
            errorVal = errorVal + (x(tVal, 2) - dataInfected(tVal)) .^ 2;
        end
    end
    [alpha beta gamma] = fminsearch(@error, [1 1 1]);
    [t, x] = instantiate(alpha, beta, gamma);
    plot(t, x);
    hold on;
    plot(1:length(dataInfected), dataInfected);
end