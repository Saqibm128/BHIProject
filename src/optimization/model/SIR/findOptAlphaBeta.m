function [res, error] = findOptAlphaBeta(dataInfected, dataRecovered, init) 
%% like SIR optimize but instead of using interpoplate true infected, attempt to 
    initRes = [1 * 10^-8, 1* 10^-1];

    [res, error] = findOptAlphaBetaInitial(dataInfected, dataRecovered, init, initRes);
end
