%DemoTest_PCA_ThermalData_Neutral_10Feb2015_Glasses


folderName = 'D:\LVThS K27\Thermal Database Ver2.0\';

%folderName = '../data/Thermal Database/';

emotions = {'anger','disgust','fear','happy','neutral','sadness','surprise'};

for temp=1:1:10
    
    
    imageTests = {}; 
    imageTrainsClass = {};
    for nEmotion = 1:1:7
      
              % emotionFolder = strcat(folderName,emotions{nEmotion},'\');
    emotionFolder = [folderName emotions{nEmotion}];

        
      %  Faces = LoadImageFaces(emotionFolder);
      %% fix code here
      if nEmotion ==1
          frame = 3000;
      elseif nEmotion ==2
          frame = 400;
      elseif nEmotion == 3
          frame = 300;
      elseif nEmotion ==4
          frame = 900;
      elseif nEmotion ==5
          frame = 100;
      elseif nEmotion ==6
          frame = 900;          
      else
          frame = 900;
      end
      %%%frame = 200;
      Faces = LoadThermalGlasses(emotionFolder,frame); %%%%%%%%Fixed code
      
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      
        %% Old code%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%Test each Expression%%%%%
        if nEmotion == 5
            [train, test] = DivideFaces(Faces);
        
            %train = {};
            %test = {};
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%
                nEmotionBegin = length(imageTests);
            %%%%%%%%%%%%%%%%%%%%%%%
                for nTest=1:length(test)
                    nSizetest = length(imageTests); 
                    imageTests{nSizetest + 1} = test(nTest);
                end;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            nEmotionEnd = length(imageTests);
            imageTestClass{nEmotion} = [nEmotionBegin + 1 nEmotionEnd];
        else train = AddFacesToTrain(Faces);
        end
        
        imageTrainsClass{nEmotion} = train;
        
    end;

    % TRAINING AND SAVING 

    trainingfiles = {'weight_train.mat', 'avg_train.mat', 'uk_train.mat'};
    k = 2000;% heuristic choose, can be changed
    avgTrainsClass = {};
    ukTrainsClass = {};
    weightTrainsClass = {};
    for nEmotion = 1:1:7
        train =  imageTrainsClass{nEmotion};
        [trainweights,avg,uk] = TrainFunction(train,trainingfiles,k);% note: if don't want to reload config file, just use [trainweights,avg,U] for recognition part
        avgTrainsClass{nEmotion} = avg;
        ukTrainsClass{nEmotion} = uk;
        weightTrainsClass{nEmotion} = trainweights;

    end;

    %recognitionFigure = figure;
   % axis off;
    %colormap(gray);
    %set(gcf, 'Name', 'Facial expressions Results');

    % Find
    nCorrect = 0;
    
    nWronganger = 0;n_Wrongdisgust = 0; nWrongfear =0;nWronghappy = 0;
    nWrongneutral=0;nWrongsadness=0;nWrongsurprise =0;
    
    for i = 1:length(imageTests)
        X = double(imageTests{i}.data);
        for nEmotion = 1:1:7
            recontructedImg  = FindRestoredImageMSE(X,weightTrainsClass{nEmotion},avgTrainsClass{nEmotion},ukTrainsClass{nEmotion});
            distances(nEmotion) = sum((recontructedImg - X(:)).^2);
        end;
        [val, best] = min(distances);
         % check with the original expression
     %   if i >= imageTestClass{best}(1) && i <= imageTestClass{best}(2)
        if best == 5
            nCorrect = nCorrect + 1;
        end;
        
        %%%%if not correct, what exp i emotion belongs to?
        %% Find the wrong Recognition
        %for ii = 1:1:7
         %   if i >= imageTestClass{ii}(1) && i <= imageTestClass{ii}(2)
          %      break
           % end
        %end
                
        if (best==1) nWronganger = nWronganger +1;
        elseif (best==2) n_Wrongdisgust = n_Wrongdisgust +1;
        elseif (best==3) nWrongfear = nWrongfear +1;
        elseif (best==4) nWronghappy = nWronghappy +1;
        %elseif (best==5) nWrongneutral = nWrongneutral +1;
        elseif (best==6) nWrongsadness = nWrongsadness +1;
        elseif (best==7) nWrongsurprise = nWrongsurprise +1;
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Drawing
      % emotions{best}    
     %   if i <= 64
     %   tightsubplot(8,idx, X, emotions{best});
     %   axis off;
     %   idx = idx + 1;
     %   drawnow;
     %   end;
     end;
     nTest = length(imageTests)
     nCorrect
     percentage  = nCorrect/length(imageTests)
     
     percentageWrongA  = nWronganger/length(imageTests)
     percentageWrongD  = n_Wrongdisgust/length(imageTests)
     percentageWrongF  = nWrongfear/length(imageTests)
     percentageWrongH  = nWronghappy/length(imageTests)
    % percentageWrongN  = nWrongneutral/length(imageTests)
     percentageWrongSa  = nWrongsadness/length(imageTests)
     percentageWrongSu  = nWrongsurprise/length(imageTests)
    
     
     expWNMatrix(temp) = percentage;
     
     expWAMatrix(temp)=percentageWrongA   
     expWDMatrix(temp)=percentageWrongD
     expWFMatrix(temp)=percentageWrongF 
     expWHMatrix(temp)=percentageWrongH
    % expWNMatrix(temp)=percentageWrongN 
     expWSaMatrix(temp)=percentageWrongSa
     expWSuMatrix(temp)=percentageWrongSu
    
     
   % d=[expMatrix;expWAMatrix;expWHMatrix;expWFMatrix;expWNMatrix;expWSaMatrix;]
    d=[expWAMatrix;expWDMatrix;expWFMatrix;expWHMatrix;expWNMatrix;expWSaMatrix;expWSuMatrix]
end

    xlswrite('D:\LVThS K27\PCA_Thermalimg v5\ResultNotROIs\neutral2018.xls',d);




