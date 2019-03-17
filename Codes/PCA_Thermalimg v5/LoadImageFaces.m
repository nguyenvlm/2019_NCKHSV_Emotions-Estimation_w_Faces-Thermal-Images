function F = LoadImageFaces(folderName)
%basename = 'D:\banHung\work\Other\jaffe\JAFFE\';
basename = folderName;
files = dir(basename);
j=1;
F ={};
for i = 1 : size(files,1)
        if files(i).isdir == 1 || size(find(files(i).name=='.'),2) < 1 
            continue;
        end
        files(i).name % such a KR.NE3.73.tiff
        Y = imread(strcat(basename,files(i).name));
        
        if ndims(Y) == 3
            X = rgb2gray(Y);
        else X = Y;
        end
        %X=rgb2gray(Y);   
       % X = imresize(X, [100 100]);
        F{j} = X;
        j=j+1 ;  
end
