function errorVal = errorSEIRCumm(a, dataInfected, init)
%%an error function that does not depend on interpolating who is infected
%%at any given time
dSEIR = @(t, SEIR) SEIRModel(t, SEIR, a(1), a(2), a(3));
instantiateSEIR = @(alpha, beta, gamma, num) iterOde(SEIRModel, init, num, 10);

[t, x] = instantiateSEIR(a(1), a(2), a(3), length(dataInfected));

expectedInfected = x(:,3);
    integratedExpectedInfected = zeros(length(x), 1); %% initialize
    for i =  1:length(x)
      integratedExpectedInfected(i) = trapz(expectedInfected(1:i)); %%get a slowly expanding integration
    end
    errorValI = sum((integratedExpectedInfected - dataInfected) .^ 2);
    errorVal = errorValI;
end