function F = LoadThermalFaces(folderName,frame)

basename = folderName;
files = dir(basename);
j=1;
F ={};
for i = 1 : size(files,1),
        if files(i).isdir == 1 || size(find(files(i).name=='.'),2) < 1 
            continue;
        end;
        files(i).name % such a KR.NE3.73.tiff
               
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       fstart = frame-20;       
       for k=fstart:8:frame
           %Y = ReadFileSVX(strcat(basename,files(i).name),k);
           Y = ReadFileSVX([basename '/' files(i).name],k);
           for m = 1:1:240
               for n = 1:1:320
                   if Y(m,n,k)<= 29
                      H(m,n) = 0;
                   else H(m,n)=Y(m,n,k);
                   end
               end            
           end
            F{j} = H;
            j=j+1;   
            
       end

         %%%%%%%%%%%%%%%%%%%%%%%%
        
end;
