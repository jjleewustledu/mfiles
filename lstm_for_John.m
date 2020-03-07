




% lgraph = lstm3(32);

% lgraph = denselstm2(32);

% lgraph = denselstm3(32);

function net = trainNet(input,output,lgraph)

% Will need to set up your training data here, can be tricky with regression. Matlab has some decent examples where they use cell arrays

options = trainingOptions('adam', ...
    'MaxEpochs',5000, ...
    'GradientThreshold',1, ...
    'InitialLearnRate',0.001, ...
    'LearnRateSchedule','piecewise', ...
    'ValidationFrequency',10, ...
    'ValidationPatience',5, ...
    'ValidationData',{inVal(:,:)',outVal(1850:end,:)'}, ...
    'LearnRateDropPeriod',25, ...
    'LearnRateDropFactor',0.9, ...
    'plots','training-progress');
net = trainNetwork(in,out,lgraph,options);

end

function lgraph = lstm3(nodes)
lgraph = layerGraph();
tempLayers = sequenceInputLayer(1,"Name","sequence","Normalization","zerocenter");
lgraph = addLayers(lgraph,tempLayers);
tempLayers = bilstmLayer(nodes,"Name","bilstm_1","BiasL2Factor",1);
lgraph = addLayers(lgraph,tempLayers);
tempLayers = bilstmLayer(nodes,"Name","bilstm_2","BiasL2Factor",1);
lgraph = addLayers(lgraph,tempLayers);
tempLayers = bilstmLayer(nodes,"Name","bilstm_3","BiasL2Factor",1);
lgraph = addLayers(lgraph,tempLayers);
tempLayers = [
    concatenationLayer(1,4,"Name","concat")
    fullyConnectedLayer(1,"Name","fc","BiasL2Factor",1)
    regressionLayer("Name","regressionoutput")];
lgraph = addLayers(lgraph,tempLayers);
lgraph = connectLayers(lgraph,"sequence","bilstm_1");
lgraph = connectLayers(lgraph,"sequence","concat/in4");
lgraph = connectLayers(lgraph,"bilstm_1","bilstm_2");
lgraph = connectLayers(lgraph,"bilstm_1","concat/in3");
lgraph = connectLayers(lgraph,"bilstm_2","bilstm_3");
lgraph = connectLayers(lgraph,"bilstm_2","concat/in2");
lgraph = connectLayers(lgraph,"bilstm_3","concat/in1");
end

function lgraph = denselstm2(nodes)
lgraph = layerGraph();
tempLayers = sequenceInputLayer(1,"Name","sequence","Normalization","zerocenter");
lgraph = addLayers(lgraph,tempLayers);
tempLayers = bilstmLayer(nodes,"Name","bilstm_1","BiasL2Factor",1);
lgraph = addLayers(lgraph,tempLayers);
tempLayers = concatenationLayer(1,2,"Name","concat_1");
lgraph = addLayers(lgraph,tempLayers);
tempLayers = bilstmLayer(nodes,"Name","bilstm_2","BiasL2Factor",1);
lgraph = addLayers(lgraph,tempLayers);
tempLayers = [
    concatenationLayer(1,2,"Name","concat_2")
    fullyConnectedLayer(1,"Name","fc","BiasL2Factor",1)
    regressionLayer("Name","regressionoutput")];
lgraph = addLayers(lgraph,tempLayers);
lgraph = connectLayers(lgraph,"sequence","bilstm_1");
lgraph = connectLayers(lgraph,"sequence","concat_1/in1");
lgraph = connectLayers(lgraph,"bilstm_1","concat_1/in2");
lgraph = connectLayers(lgraph,"concat_1","bilstm_2");
lgraph = connectLayers(lgraph,"concat_1","concat_2/in1");
lgraph = connectLayers(lgraph,"bilstm_2","concat_2/in2");
end

function lgraph = denselstm3(nodes)
lgraph = layerGraph();
tempLayers = sequenceInputLayer(1,"Name","sequence","Normalization","zerocenter");
lgraph = addLayers(lgraph,tempLayers);
tempLayers = bilstmLayer(nodes,"Name","bilstm_1","BiasL2Factor",1);
lgraph = addLayers(lgraph,tempLayers);
tempLayers = concatenationLayer(1,2,"Name","concat_1");
lgraph = addLayers(lgraph,tempLayers);
tempLayers = bilstmLayer(nodes,"Name","bilstm_2","BiasL2Factor",1);
lgraph = addLayers(lgraph,tempLayers);
tempLayers = concatenationLayer(1,2,"Name","concat_2");
lgraph = addLayers(lgraph,tempLayers);
tempLayers = bilstmLayer(nodes,"Name","bilstm_3","BiasL2Factor",1);
lgraph = addLayers(lgraph,tempLayers);
tempLayers = [
    concatenationLayer(1,2,"Name","concat_3")
    fullyConnectedLayer(1,"Name","fc","BiasL2Factor",1)
    regressionLayer("Name","regressionoutput")];
lgraph = addLayers(lgraph,tempLayers);
lgraph = connectLayers(lgraph,"sequence","bilstm_1");
lgraph = connectLayers(lgraph,"sequence","concat_1/in1");
lgraph = connectLayers(lgraph,"bilstm_1","concat_1/in2");
lgraph = connectLayers(lgraph,"concat_1","bilstm_2");
lgraph = connectLayers(lgraph,"concat_1","concat_2/in1");
lgraph = connectLayers(lgraph,"bilstm_2","concat_2/in2");
lgraph = connectLayers(lgraph,"concat_2","bilstm_3");
lgraph = connectLayers(lgraph,"concat_2","concat_3/in1");
lgraph = connectLayers(lgraph,"bilstm_3","concat_3/in2");
end