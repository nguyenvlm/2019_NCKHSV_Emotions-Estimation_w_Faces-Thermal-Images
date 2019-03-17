
%First, extract the faces into training and test faces
function train = AddFacesToTrain(Faces)

train = {};

% choose 30% for testing and 70% for training
    for i = 1:length(Faces),
            X = double(Faces{i});
            train(i).data = X;
            
    end        
           
        
end
