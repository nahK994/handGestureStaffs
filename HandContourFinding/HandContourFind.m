clc
clear all
tic;
a=imread('B.jpg');
%size(a)
Count=1;
image=a;
a=rgb2gray(a);
[count,x]=imhist(a,9);
T=otsuthresh(count);
a=imbinarize(a,T); 
a = medfilt2(a, [10 10]);
a = bwmorph(a,'bridge',60);
a = bwmorph(a,'diag',60);
a1=ResizingImage(a);
a=imcrop(a,a1);
a=imresize(a, [260 180]);
a = edge(a,'sobel');
[row,col]=size(a);
image=imresize(image, [260 180]);    %  This is pre-processing part


[row,col]=size(a);
count=0;


startX=0;
startY=0;
for i=row:-1:1;
   for j=1:col;
       if a(i,j) == 1
           count=count+1;
           image(i,j,1)=88; image(i,j,2)=46; image(i,j,3)=161;          % image is the RGB picture of the contour image(a)

           if startX == 0 && startY == 0                                  % this section is to constract image and find out the
              startX=i; startY=j;                                         % starting white pixel
           end   
                                                       
       else image(i,j,1)=255; image(i,j,2)=255; image(i,j,3)=255;  
       end
       
   end
end             

loop=1;
flag=1;
ansX=[]; ansY=[];

[aa,bb,cc]=size(image);
while(flag == 1) 
   [image, X, Y]=saveWhitePixelSequence(image,startX,startY);   % saveWhitePixelSequence function is to save index of contour pixels color those pixels    
   [row,col]=size(X);
   [row1,col1]=size(ansX);
   for i=1:col;
      ansX(col1+i)=X(i);    % ansX is a vector which takes rows of white pixels
      ansY(col1+i)=Y(i);    % ansY is a vector which takes columns of white pixels
   end
 
   startX=ansX(col1+col); startY=ansY(col1+col);
  % fprintf('startX = %d      startY = %d\n',startX,startY);
   if startX == aa 
       break 
   end
   [startX,startY,flag]=findWhitePixel(image, startX, startY);   % if we miss the sequence of contour pixel then 'findWhitePixel'  
   loop=loop+1;                                                  % function is to find the closest white pixel. This function is 
end                                                              % also tells us wheather we should search for contour pixels or not.
 
toc
%  [row,col]=size(ansX);
%  for i=1:col
%     fprintf('%d -> %d  %d\n',i,ansX(i),ansY(i)); 
%  end
 imshow(image);
% fprintf('count = %d    loop = %d\n',count,loop);