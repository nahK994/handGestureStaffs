clc
clear all
tic;
a=imread('B.jpg');
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
%size(a)
a = edge(a,'sobel');
[row,col]=size(a);
image=imresize(image, [260 180]);


startX=0;
startY=0;
loop=1;
[row,col]=size(a);
count=0;

BW1=a;

sa=1;
ED=zeros(400,2);
[x,y]=size(BW1);
BWX=BW1;
for fx=x:-1:x-8;
    for fy=1:y;
        if BW1(fx,fy)==1
             ED(sa,1)=fx;
             ED(sa,2)=fy;
             sa=sa+1;
             break;
        end
    end
end
sf=sa-1;
wh=0;
 while(1)
     wh=wh+1;
     sx=ED(sf,1);
     sy=ED(sf,2);
     px=ED(sf-1,1);
     py=ED(sf-1,2);
     va=0;
     vb=0;
     vc=0;
     vd=0;
     ve=0;
     vf=0;
     vg=0;
     vh=0;
     for kl=sf-7:sf-1
         if sx==ED(kl,1) && sy+1==ED(kl,2)
             va=1;
         elseif sx==ED(kl,1) && sy-1==ED(kl,2)
             vb=1;
         elseif sx-1==ED(kl,1) && sy==ED(kl,2)
             vc=1;
         elseif sx+1==ED(kl,1) && sy==ED(kl,2)
             vd=1;
         elseif sx+1==ED(kl,1) && sy+1==ED(kl,2)
             ve=1;
         elseif sx+1==ED(kl,1) && sy-1==ED(kl,2)
             vf=1;
         elseif sx-1==ED(kl,1) && sy+1==ED(kl,2)
             vg=1;
         elseif sx-1==ED(kl,1) && sy-1==ED(kl,2)
             vh=1;
         end
     end           
     sf=sf+1;
     if ED(sf-1,1)<ED(sf-2,1)
     if px==x-1;
         break;
     elseif sy-1>=1 && BW1(sx,sy-1)==1 && vb==0
             ED(sf,1)=sx;
             ED(sf,2)=sy-1;
             BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx-1,sy-1)=0;
     elseif sx-1>=1 && sy-1>=1 && BW1(sx-1,sy-1)==1 && vh==0
             ED(sf,1)=sx-1;
             ED(sf,2)=sy-1;
             BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif sx-1>=1 && BW1(sx-1,sy)==1 && vc==0
             ED(sf,1)=sx-1;
             ED(sf,2)=sy;
             BW1(sx+1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx-1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif sx-1>=1 && sy+1<=y && BW1(sx-1,sy+1)==1 && vg==0
             ED(sf,1)=sx-1;
             ED(sf,2)=sy+1;
             BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx-1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif sy+1<=y && BW1(sx,sy+1)==1 && va==0
             ED(sf,1)=sx;
             ED(sf,2)=sy+1;
             BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx-1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif sx+1<=x && sy+1<=y && BW1(sx+1,sy+1)==1 && ve==0
             ED(sf,1)=sx+1;
             ED(sf,2)=sy+1;
             BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx-1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif sx+1<=x && BW1(sx+1,sy)==1 && vd==0
             ED(sf,1)=sx+1;
             ED(sf,2)=sy; 
             BW1(sx-1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx-1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif sx+1<=x && sy-1>=1 && BW1(sx+1,sy-1)==1 && vf==0
             ED(sf,1)=sx+1;
             ED(sf,2)=sy-1;
             BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx-1,sy-1)=0;
             BW1(sx,sy-1)=0;
     else
           ND=zeros(20,1);
           [nx,ny]=size(ED);
           for qr=1:nx
               if ED(qr,1)>0
               jr=ED(qr,1);
               jc=ED(qr,2);
               BWX(jr,jc)=0;
               end
           end
           [r, c]=find(BWX==1); 
           nlk=size(r,1);
           hx=sx;
           hy=sy;
           for i=1:nlk 
           ND(i,1)=sqrt((hx-r(i))^2+(hy-c(i))^2);
           end
           [bv bv]=min(ND);
           ED(sf,1)=r(bv);
           ED(sf,2)=c(bv);
     end
     else
     if px==x-1;
         break;    
     elseif sy+1<=y && BW1(sx,sy+1)==1 && va==0
             ED(sf,1)=sx;
             ED(sf,2)=sy+1;
             BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx-1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif sy+1<=y && sx+1<=x && BW1(sx+1,sy+1)==1 && ve==0
             ED(sf,1)=sx+1;
             ED(sf,2)=sy+1;
             BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx-1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif sx+1<=x && BW1(sx+1,sy)==1 && vd==0
             ED(sf,1)=sx+1;
             ED(sf,2)=sy; BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx-1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif sx+1<=x && sy-1>=1 && BW1(sx+1,sy-1)==1 && vf==0
             ED(sf,1)=sx+1;
             ED(sf,2)=sy-1;
             BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx-1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif sy-1>=1 && BW1(sx,sy-1)==1 && vb==0
             ED(sf,1)=sx;
             ED(sf,2)=sy-1;
             BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx-1,sy-1)=0;
     elseif sx-1>=1 && sy-1>=1 && BW1(sx-1,sy-1)==1 && vh==0
             ED(sf,1)=sx-1;
             ED(sf,2)=sy-1;
             BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif sx-1>=1 && BW1(sx-1,sy)==1 && vc==0
             ED(sf,1)=sx-1;
             ED(sf,2)=sy;
             BW1(sx+1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx-1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif sx-1>=1 && sy+1<=y && BW1(sx-1,sy+1)==1 && vg==0
             ED(sf,1)=sx-1;
             ED(sf,2)=sy+1;
             BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx-1,sy-1)=0;
             BW1(sx,sy-1)=0;
     else
           ND=zeros(2,1);
           [nx,ny]=size(ED);
           for qr=1:nx
               if ED(qr,1)>0
               jr=ED(qr,1);
               jc=ED(qr,2);
               BWX(jr,jc)=0;
               end
           end
           [r, c]=find(BWX==1); 
           nlk=size(r,1);
           hx=sx;
           hy=sy;
           for i=1:nlk 
           ND(i,1)=sqrt((hx-r(i))^2+(hy-c(i))^2);
           end
           [bv bv]=min(ND);
           ED(sf,1)=r(bv);
           ED(sf,2)=c(bv);
     end
     end
         
 end
 
[Xx, Yy]=size(ED);

count=0;
[row,col]=size(BW1);
 for i=row:-1:1;
   for j=1:col;
       if BW1(i,j) == 1
           count=count+1;
           image(i,j,1)=150; image(i,j,2)=150; image(i,j,3)=250;
       
       else image(i,j,1)=255; image(i,j,2)=255; image(i,j,3)=255;  
       end
       
   end
 end
 
 toc
 for i=1: Xx;
   % fprintf('%d -> %d    %d\n',i,ED(i,1),ED(i,2));
    image(ED(i,1),ED(i,2),1)=142; image(ED(i,1),ED(i,2),2)=245; image(ED(i,1),ED(i,2),3)=190; 
 end
%  fprintf('Count = %d\n',count);
  imshow(image);