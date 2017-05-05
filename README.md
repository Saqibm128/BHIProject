# BHIProject
BMED 4814 Final Project implemented in MatLab, Attempts to use SIR, SEIR, and Agent Based Graph to attempt to model WHO dataset

Use main.m to access the GUI developed for the project

**Initial Data Process**
*readData.m:* takes and reads imported data from an EbolaData.mat file and returns fitted cases and fitted deaths with granularity of day

*iterOde.m:* ode45 slows down significantly when S is orders of magnitudes higher than I. While Jacobian method is potentially misleading,
as the result may be significantly different depending on how many iterations are done for 1 time step, it was the only way
to allow fminsearch to traverse the domains of the problems. Jacobian method implemented in iterode

*dataCleaning/fitData.m:* used by readData.m to process and find points for entire span of the disease

*dataCleaning/interpolateTrueInfected.m:* since SIR returns people CURRENTLY infected or recovered, but WHO dataset returns CUMMULATIVE infected/cases,
this function attempts to transform WHO dataset using parameters of 12 days for average case to interpolate currently infected.




**Optimization**
**SIR**
Located in src/optimization/model/SIR

ODE based model which uses fminsearch to attempt to find the best fit.

Most of the files here are different attempts to attempt to implement SIR modeling
and error measurements.

findOptAlphaBeta.m is the function used by GUI.
findOptAlphaBetaInitial.m is a function used for random restarts.
errorSIR.m is the actual error function used

**SEIR**
Located in src/optimization/model/SEIR
findOptBetaEpsilGamma.m is function used by GUI
findOptBetaEpsilGamma.m is function used for randomRestarts
src/optimization/model/SEIR/RandomRestarts contains implementations for generating random restarts
errorSEIR.m is actual error function used

**Agent Based Graph (Markov Model)**
Located in src/optimization/model/AgentBased
findOptAgentBasedGraph is function used by GUI
findOptAgentBasedGraphInitVals is function used for randomRestarts
src/optimization/model/AgentBased/randomRestarts contains implementations for random restarts
