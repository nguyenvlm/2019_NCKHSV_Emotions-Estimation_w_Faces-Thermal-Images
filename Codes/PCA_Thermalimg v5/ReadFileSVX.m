function H= ReadFileSVX(filename,frame)

fid=0;
%fid=fopen('E:\Working\SVX\thienh6.SVX','r');
fid=fopen(filename,'r');
    if fid==-1 
     disp('file read error')
    end
    
status=fseek(fid,128,'bof');

Cal=fread(fid,2,'int32','l');
Cal(1);
Cal(2);
CA=Cal(1)/(2.^16);
CB=Cal(2)/(2.^16);

status=fseek(fid,1104,'bof');

m=1;
for m=1:frame
   Image=fread(fid,76800,'int16','b');
   CImage=Image.*CB+CA;
    
   k=1;
   for i=1:240
       for j=1:320
       Image3D(i,j,m)=CImage(k);
       k=k+1;
    end
   end
   
   status=fseek(fid,2592,'cof');
   m=m+1;

end

H = Image3D;
%Image3D(1,1,300)
%H(1,1,300)

status=fclose(fid);






