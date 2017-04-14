    function [t,x] = instantiateSIR(a, b, init, num)
        alpha = a;
        beta = b;
        instSirModel = @(t, x)SIRModel(t, x, a, b); %instantiated Sir model
        [time, vals] = iterOde(instSirModel, init, num, 10);
        t = time;
        x = vals;
    end