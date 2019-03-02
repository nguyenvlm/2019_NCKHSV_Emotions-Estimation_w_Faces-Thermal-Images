
%First, extract the faces into training and test faces
function [train, test] = DivideFaces(Faces)
trainidx = 1;
testidx = 1;
train = {};
test = {};

% choose 30% for testing and 70% for training
for i = 1:length(Faces),
        X = double(Faces{i});
        if( rand > 0.4 )
            train(trainidx).data = X;
            trainidx = trainidx + 1;
        else
            test(testidx).data = X;
            testidx = testidx + 1;
        end;
        
end;
