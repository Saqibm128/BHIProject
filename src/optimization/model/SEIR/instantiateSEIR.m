    function [t,x] = instantiateSEIR(b, e, g, initSEIR, num)
        %% uses an ode modeler to try to model SIRModel.m
        instSirModel = @(t, x)SEIRModel(t, x, b, e, g); %instantiated Sir model
        [time, vals] = iterOde(instSirModel, initSEIR, num, 3);
        t = time;
        x = vals;
    end
