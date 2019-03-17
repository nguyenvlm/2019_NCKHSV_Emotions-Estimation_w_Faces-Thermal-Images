function recontructedImg  = FindRestoredImageMSE(test,trainweights,avg,Uk)
%Put all of the test faces into one big matrix and project
idx = 1;
Wh = test - avg;
% T : Matrix(N*N,nTest)
% Uk : Matrix(N*N, k) 
k = size(Uk,2); % number of k eigen faces
distances = [];
testweights = Uk(:,:)' * Wh(:);
for j = 1:length(trainweights)
        distances(j) = sum((trainweights(:,j) - testweights(:)).^2);% find distance both, tested projected face and trained projected face. The space is smaller than that of the original
end
[val, best] = min(distances);

recontructedImg = Uk(:,1:k) * trainweights(:,best) + avg(:);

    

