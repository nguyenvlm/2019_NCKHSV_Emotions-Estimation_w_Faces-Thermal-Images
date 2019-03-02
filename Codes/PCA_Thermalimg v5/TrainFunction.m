function [trainweights,avg,uk] = TrainFunction(train,trainingfiles,k)
avg = meanface(train);
%Put all of the training faces into one big matrix and do svd
idx = 1;
for i = 1:length(train),
    X = double(train(i).data);
    W = X - avg;
    M(:, idx) = W(:);
    idx = idx + 1;
end;

[U, W, V] = svd(M,0);% using Single Value Decomposition
k = min(size(W,1)/2,k);
for i = 1:length(train)
    trainweights(:,i) = U(:,1:k)' * M(:,i);
end;
% Those values should be saved to hard disk after training done
uk = U(:,1:k);
% temporary don't save to file
%save(trainingfiles{1},'trainweights');
%save(trainingfiles{2},'avg');
%save(trainingfiles{3},'uk');