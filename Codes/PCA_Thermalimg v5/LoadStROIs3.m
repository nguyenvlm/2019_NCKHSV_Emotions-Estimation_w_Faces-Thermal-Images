function F = LoadStROIs(folderName,frame)

basename = folderName;
files = dir(basename);
j=1;
F ={};

%thresholdTop = 34.5; thresholdLeft = 29;
%wide = 160;height = 120;HeightFace = 170;

for i = 1 : size(files,1),
        if files(i).isdir == 1 || size(find(files(i).name=='.'),2) < 1 
            continue;
        end;
        files(i).name % such a KR.NE3.73.tiff
               
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       fstart = frame-9;      
       
       %Y = ReadFileSVX(strcat(basename,files(i).name),frame);
       Y =  ReadFileSVX([basename '/' files(i).name],frame);
             
       for k=fstart:8:frame       
           [Txmax Tymax] = max(Y(:,:,k));
           [Tmax Tcmax]= max(Txmax);
           [Txmin Tymin] = min(Y(:,:,k));
           [Tmin Tcmin]= min(Txmin);
                    
            grayImage = min(Y(:,:,k), [], 3); % Useful for finding image and color map regions of image.
       
            [indexedImage storedColorMap] = gray2ind(grayImage,16);
          
           [counts, edges] = histcounts(indexedImage(:), 0:255);
           [maxcount, maxidx] = max(counts);
           Tgray = edges(maxidx);
           
                           
           DeltaT =(Tmax-Tmin) * (Tgray ./ maxcount);
           
           for m = 1:1:240 
               for n = 1:1:320
                   if ((Y(m,n,k)<= double(Tmin) + DeltaT) || (Y(m,n,k)>= double(Tmax)- DeltaT)) 
                     H(m,n) = 0;
                   else H(m,n)=Y(m,n,k);
                 %H(m,n)=Y(m,n,k);
                   end
               end            
           end
           % L = ContractionMapping( H, thresholdTop,thresholdLeft, wide,height,HeightFace );
            F{j} = H;
            j=j+1;   
            
       end

         %%%%%%%%%%%%%%%%%%%%%%%%
        
end;
