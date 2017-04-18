function[result ,errorVal] = crossValidateError(dataSet, errorFunct, trainFunct)
    %%Given an error funct, perform kfold validation, where k = 10
    %%dataset is data to use
    %% trainFunct(trainDataset) returns a result to be used by errorFunct
    %% errorFunct(result, testDataset);
    %% returns errorVal, cv error
    %% returns result, best result from a fold
    indices = crossvalind('Kfold', length(dataSet), 2);
    errors = zeros(10,1);
    bestResult = [];
    bestError = -1;
    for i = 1:10
        isTest = @(num) num == i;
        isTrain = @(num) ~isTest(num);
        testIndices = arrayfun(isTest, indices);
        trainIndices = arrayfun(isTrain, indices);
        testDataset = dataSet(testIndices);
        trainDataset = dataSet(trainIndices);
        result = trainFunct(trainDataset);
        errors(i) = errorFunct(result, testDataset);
        if (errors(i) < bestError || bestError == -1)
            bestError = errors(i);
            bestResult = result;
        end
    end
    errorVal = mean(errors);
end