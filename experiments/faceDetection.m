clc
clear all

I=imread('paper3.jpg');
I=imresize(I,[260 260]);
subplot(1,3,1);
imshow(I);
r=I(:,:,1);
g=I(:,:,2);
b=I(:,:,3);

hsv = rgb2hsv(I); 
hsv=imresize(hsv,[260 260]);
h = hsv(:,:,1); 
s = hsv(:,:,2); 
v = hsv(:,:,3); 
for i=1:260
    for j=1:260
        
  % if r(i,j)>95 & g(i,j)>40 & b(i,j)>20 & max(r(i,j),max(g(i,j),b(i,j)))-min(r(i,j),min(g(i,j),b(i,j)))>15 & abs(r(i,j)-g(i,j))>15 & r(i,j)>g(i,j)  & r(i,j)>b(i,j) 
   
    if h(i,j)>=0.0 & h(i,j)<=50.0 & 0.23<=s(i,j) & s(i,j)<=0.68 & r(i,j)>95 & g(i,j)>40 && b(i,j)>20 & r(i,j)>g(i,j) & r(i,j)>b(i,j) & abs(r(i,j)-g(i,j))>15 & max(r(i,j),max(g(i,j),b(i,j)))-min(r(i,j),min(g(i,j),b(i,j)))>15
        ans(i,j)=1;
        
        aa=30;
%       if (r(i,j) - (g(i,j)+b(i,j))>aa) || (g(i,j) - (r(i,j)+b(i,j))>aa) || (b(i,j) - (r(i,j)+g(i,j))>aa)
%           ans(i,j)=0;
%       end
        
    else ans(i,j)=0;
    end  
    
    end
end
subplot(1,3,2);
imshow(ans);

for i=1:260
    for j=1:260
        
  % if r(i,j)>95 & g(i,j)>40 & b(i,j)>20 & max(r(i,j),max(g(i,j),b(i,j)))-min(r(i,j),min(g(i,j),b(i,j)))>15 & abs(r(i,j)-g(i,j))>15 & r(i,j)>g(i,j)  & r(i,j)>b(i,j) 
   
    if h(i,j)>=0.0 & h(i,j)<=50.0 & 0.23<=s(i,j) & s(i,j)<=0.68 & r(i,j)>95 & g(i,j)>40 & b(i,j)>20 & r(i,j)>g(i,j) & r(i,j)>b(i,j) & abs(r(i,j)-g(i,j))>15 & max(r(i,j),max(g(i,j),b(i,j)))-min(r(i,j),min(g(i,j),b(i,j)))>15
        ans(i,j)=1;
        
        aa=30;
      if (r(i,j) - (g(i,j)+b(i,j))>aa) || (g(i,j) - (r(i,j)+b(i,j))>aa) || (b(i,j) - (r(i,j)+g(i,j))>aa)
          ans(i,j)=0;
      end
        
    else ans(i,j)=0;
    end  
    
    end
end
%ans = medfilt2(ans, [2 2]);
%ans= imfill(ans,'holes');
subplot(1,3,3);
imshow(ans);