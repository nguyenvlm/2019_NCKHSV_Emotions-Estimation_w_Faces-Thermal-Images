function Recognition(test,trainweights,avg,Uk,train)
%Put all of the test faces into one big matrix and project
idx = 1;
for i = 1:length(test),
    X = double(test(i).data);
    Wh = X - avg;
    T(:, idx) = Wh(:);
    idx = idx + 1;
end;
% T : Matrix(N*N,nTest)
% Uk : Matrix(N*N, k) 
k = size(Uk,2); % number of k eigen faces
for i = 1:min(64,length(test))
testweights = Uk(:,:)' * T(:,i);% 
end;
clear distances;
idx = 1;
numTest = length(test)
recognitionFigure = figure;
axis off;
colormap(gray);
set(gcf, 'Name', 'Recognition Results');
for i = 1:min(64,numTest) % just show 64 image as maximun

    testweights = Uk(:,:)' * T(:,i);
    for j = 1:length(train),
        distances(j) = sum((trainweights(:,j) - testweights(:)).^2);% find distance both, tested projected face and trained projected face. The space is smaller than that of the original
    end;
    [val, best] = min(distances);
    
    tightsubplot(8, idx, test(i).data ); 
    
    axis off;
    tightsubplot(8, idx+1, train(best).data ); axis off;
    idx = idx + 2;
    drawnow;
end;
