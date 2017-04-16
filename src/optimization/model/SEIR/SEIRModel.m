  function dSEIR = SEIRModel(t,SEIR, alpha, beta, gamma)
  %%SEIR is previous iteration
  %%t is required arg
  %%beta is transfer to exposed from S
  %%epsilon is fromE to I
  %%gamma is from I to R
  dSEIR = zeros(4,1);
  dSEIR(1) =  -1 .* SEIR(1) .* beta .* SEIR(3); %% dS/dt = -b[s][i]
  dSEIR(2) = -1 .* dSEIR(1) - epsilon .* SEIR(2); %%dE/dt = b[s][i] - epsilon[e] = -dS/dt - eps * [e]
  dSEIR(3) = epsilon .* SEIR(2) - gamma .* SEIR(3); %%dI/dt = epsilon [e] - gamma [i]
  dSEIR(4) = gamma .* SEIR(3); %% dR/dt = gamma [i]
  end