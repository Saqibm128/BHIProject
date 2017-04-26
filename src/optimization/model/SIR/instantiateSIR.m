    function [t,x] = instantiateSIR(a, b, init, num)
        %% uses an ode modeler to try to model SIRModel.m
        alpha = a;
        beta = b;
        instSirModel = @(t, x)SIRModel(t, x, a, b); %instantiated Sir model
        [time, vals] = iterOde(instSirModel, init, num, 12);
        t = time;
        x = vals;
    end
