function[errorVal] = crossValidateError(dataSet, days, errorFunct)
    indices = crossvalind('Kfold', length(dataSet), 10);
    for i = 1:10
        isTest = @(num) num == i;
        isTrain = @(num) ~isTest(num);
        testIndices = arrayfun(isTest, indices);
        trainIndices = arrayfun(isTrain, indices);
        
    end
end