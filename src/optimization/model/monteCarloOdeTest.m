%%Test file for iterOde

%%first test shows a random function dx/dt, aka e^-x
testFunct = @(t, x) -x;
init = [1];
maxNum = 10;
[t x] = iterOde(testFunct, init, maxNum, 1000);
plot(t, x);

%%second test attempts to use model

testFunct = @(t, x)SIRModel(t, x, .0001, .0001);
init = [10 * 10^6, 1, 0];
maxNum = 100;
[t x] = iterOde(testFunct, init, maxNum, 1000);
plot(t, x);