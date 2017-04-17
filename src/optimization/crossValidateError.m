function[errorVal] = crossValidateError(dataSet, errorFunct, trainFunct)
    %%Given an error funct, perform kfold validation, where k = 10
    %%dataset is data to use
    %% trainFunct returns a result to be used by errorFunct
    %% errorFunct(result, testDataset);
    indices = crossvalind('Kfold', length(dataSet), 10);
    errors = zeros(10,1);
    for i = 1:10
        isTest = @(num) num == i;
        isTrain = @(num) ~isTest(num);
        testIndices = arrayfun(isTest, indices);
        trainIndices = arrayfun(isTrain, indices);
        testDataset = dataSet(testIndices);
        trainDataset = dataSet(trainIndices);
        result = trainFunct(trainDataset);
        errors(i) = errorFunct(result, testDataset);
    end
    errorVal = mean(errors);
end