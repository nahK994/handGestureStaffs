clc;
clear all;
load('imageDB.mat');
for v=1:1850;
imageDB{v}=imresize(imageDB{v},[260 260]);
DB=imageDB{v};
DB=rgb2gray(DB);
[counts,x] = imhist(DB,10);
T = otsuthresh(counts);
for ot=0:0.01:0.5;
BW = imbinarize(DB,T-ot);
BW= medfilt2(BW, [10 10]);
BW = bwmorph(BW,'bridge',60);
BW = bwmorph(BW,'diag',60);
BW= imfill(BW,'holes');
cc = bwconncomp(BW);
 if cc.NumObjects<2
   break
 end
end
angle=0;
rotation=0;
for angle=0:90:360;
BW = imrotate(BW,-angle, 'bilinear');
[x,y]=size(BW);
n=x;
w=0;
for m=1:y;
    if (BW(n,m)==1)
        w=w+1;
    end
end
if (w>=10)
    break
end
rotation=rotation+1;
BW= medfilt2(BW, [10 10]);
BW = bwmorph(BW,'bridge',60);
BW = bwmorph(BW,'diag',60);
BW= imfill(BW,'holes');
end
A=regionprops(BW, 'BoundingBox');
x=A.BoundingBox(1)-10;
y=A.BoundingBox(2)-10;
w=A.BoundingBox(3)+20;
h=A.BoundingBox(4)+20;
rectangle=[x y w h];
BW=imcrop(BW, rectangle);
[x,y]=size(BW);
a=1;
MaMn=regionprops(BW,'MajorAxisLength','MinorAxisLength');
Ecc=((MaMn.MinorAxisLength)/(MaMn.MajorAxisLength));
Elong=y/x;
DW=BW;
DW=imresize(DW, [260 180]);
s = regionprops(DW,'centroid');
C = cat(1, s.Centroid);
ab = bwconvhull(DW, 'objects');
BW1 = edge(DW,'sobel');
DW1=BW1;
BW2 = edge(ab,'sobel');
BW3= BW1 & BW2 ;
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
        else
            continue;
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
     elseif BW1(sx,sy-1)==1 && vb==0
             ED(sf,1)=sx;
             ED(sf,2)=sy-1;
             BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx-1,sy-1)=0;
     elseif BW1(sx-1,sy-1)==1 && vh==0
             ED(sf,1)=sx-1;
             ED(sf,2)=sy-1;
             BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif BW1(sx-1,sy)==1 && vc==0
             ED(sf,1)=sx-1;
             ED(sf,2)=sy;
             BW1(sx+1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx-1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif BW1(sx-1,sy+1)==1 && vg==0
             ED(sf,1)=sx-1;
             ED(sf,2)=sy+1;
             BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx-1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif BW1(sx,sy+1)==1 && va==0
             ED(sf,1)=sx;
             ED(sf,2)=sy+1;
             BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx-1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif BW1(sx+1,sy+1)==1 && ve==0
             ED(sf,1)=sx+1;
             ED(sf,2)=sy+1;
             BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx-1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif BW1(sx+1,sy)==1 && vd==0
             ED(sf,1)=sx+1;
             ED(sf,2)=sy; 
             BW1(sx-1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx-1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif BW1(sx+1,sy-1)==1 && vf==0
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
     elseif BW1(sx,sy+1)==1 && va==0
             ED(sf,1)=sx;
             ED(sf,2)=sy+1;
             BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx-1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif BW1(sx+1,sy+1)==1 && ve==0
             ED(sf,1)=sx+1;
             ED(sf,2)=sy+1;
             BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx-1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif BW1(sx+1,sy)==1 && vd==0
             ED(sf,1)=sx+1;
             ED(sf,2)=sy;
             BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx-1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif BW1(sx+1,sy-1)==1 && vf==0
             ED(sf,1)=sx+1;
             ED(sf,2)=sy-1;
             BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx-1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif BW1(sx,sy-1)==1 && vb==0
             ED(sf,1)=sx;
             ED(sf,2)=sy-1;
             BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx-1,sy-1)=0;
     elseif BW1(sx-1,sy-1)==1 && vh==0
             ED(sf,1)=sx-1;
             ED(sf,2)=sy-1;
             BW1(sx+1,sy)=0;
             BW1(sx-1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif BW1(sx-1,sy)==1 && vc==0
             ED(sf,1)=sx-1;
             ED(sf,2)=sy;
             BW1(sx+1,sy)=0;
             BW1(sx+1,sy+1)=0;
             BW1(sx-1,sy+1)=0;
             BW1(sx,sy+1)=0;
             BW1(sx+1,sy-1)=0;
             BW1(sx-1,sy-1)=0;
             BW1(sx,sy-1)=0;
     elseif BW1(sx-1,sy+1)==1 && vg==0
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
 AF=[];
 uz=1;
 rd=1;
 for rd=45:Xx-41
    if BW3(ED(rd,1),ED(rd,2))==1
       AF(uz,1)=rd;
       uz=uz+1;       
    end
 end
[ks, kd]=size(AF);
F=[1 1;1 1;1 1;1 1;1 1];
V=[0;0;0;0;0;0;0;0;0;0;0;0;0;0];
FnT=[];
 twe=1;
 ou=11;
 zr=[];
 jp=1;
 jl=1;
 for yw=1:(ks-1)
     ie=AF(yw);
     FnA(yw,1)=(atan2d((ED(ie,2)-ED(ie+40,2)),(ED(ie,1)-ED(ie+40,1))));
     FnB(yw,1)=(atan2d((ED(ie,2)-ED(ie-40,2)),(ED(ie,1)-ED(ie-40,1))));
     if FnA(yw,1)<0
         FnA(yw,1)=360+FnA(yw,1);
     end
     if FnB(yw,1)<0
         FnB(yw,1)=360+FnB(yw,1);
     end
     ddf=abs(FnA(yw,1)-FnB(yw,1));
     if ddf>180
         ddf=360-ddf;
     end
   ddf=round(ddf);
       FnT(yw,1)=ddf;
     if ddf<55 && ddf>10 && ou>22
         F(twe,1)=ED(ie,1);
         F(twe,2)=ED(ie,2);
         jp=F(twe,1);
         jl=F(twe,2);
         twe=twe+1;
     end
     wq=AF(yw+1);
     ou=sqrt((jp-ED(wq,1))^2+(jl-ED(wq,2))^2);
     zr(yw,1)=ou;
 end
for i=1:(twe-1)
V(i,1)= sqrt((F(i,2)-C(1,1))^2 + (F(i,1)-C(1,2))^2);
V(i+5,1) = -atan2d((F(i,1)-C(1,2)) , (F(i,2)-C(1,1)));
end
V(12,1)=Ecc;
V(13,1)=Elong;
V(14,1)=rotation;
BW=imresize(BW, [200 200]);
r=50;
c=50;
white_pixel=0;
for n=1:r;
    for m=1:c;
        if (BW(n,m)==1)
            white_pixel=white_pixel+1;
        end
    end
end
white_pixel;
white_pixel_1=0;
for n=1:r;
    for m=(c+1):2*c;
        if (BW(n,m)==1)
            white_pixel_1=white_pixel_1+1;
        end
    end
end
white_pixel_1;
white_pixel_2=0;
for n=1:r;
    for m=(2*c+1):3*c;
        if(BW(n,m)==1)
            white_pixel_2=white_pixel_2+1;
        end
    end
end
white_pixel_2;
white_pixel_3=0;
for n=1:r;
   for m=(3*c+1):4*c;
       if(BW(n,m)==1)
           white_pixel_3=white_pixel_3+1;
       end
   end
end
white_pixel_3;
white_pixel_4=0;
for n=(r+1):2*r;
    for m=1:c;
        if(BW(n,m)==1)
           white_pixel_4=white_pixel_4+1;
        end
    end
end
white_pixel_4;
white_pixel_5=0;
for n=(r+1):2*r;
    for m=(c+1):2*c;
        if(BW(n,m)==1)
            white_pixel_5=white_pixel_5+1;
        end
    end
end
white_pixel_5;
white_pixel_6=0;
for n=(r+1):2*r;
    for m=(2*c+1):3*c;
        if(BW(n,m)==1)
            white_pixel_6=white_pixel_6+1;
        end
    end
end
white_pixel_6;
white_pixel_7=0;
for n=(r+1):2*r;
    for m=(3*c+1):4*c;
        if(BW(n,m)==1)
            white_pixel_7=white_pixel_7+1;
        end
    end
end
white_pixel_7;
white_pixel_8=0;
for n=(2*r+1):3*r;
    for m=1:c;
        if(BW(n,m)==1)
            white_pixel_8=white_pixel_8+1;
        end
    end
end
white_pixel_8;
white_pixel_9=0;
for n=(2*r+1):3*r;
    for m=(c+1):2*c;
        if(BW(n,m)==1)
            white_pixel_9=white_pixel_9+1;
        end
    end
end
white_pixel_9;
white_pixel_10=0;
for n=(2*r+1):3*r;
    for m=(2*c+1):3*c;
        if(BW(n,m)==1)
            white_pixel_10=white_pixel_10+1;
        end
    end
end
white_pixel_10;
white_pixel_11=0;
for n=(2*r+1):3*r;
    for m=(3*c+1):4*c;
        if(BW(n,m)==1)
            white_pixel_11=white_pixel_11+1;
        end
    end
end
white_pixel_11;
white_pixel_12=0;
for n=(3*r+1):4*r;
    for m=1:c;
        if(BW(n,m)==1)
            white_pixel_12=white_pixel_12+1;
        end
    end
end
white_pixel_12;
white_pixel_13=0;
for n=(3*r+1):4*r;
    for m=(c+1):2*c;
        if(BW(n,m)==1)
            white_pixel_13=white_pixel_13+1;
        end
    end
end
white_pixel_13;
white_pixel_14=0;
for n=(3*r+1):4*r;
    for m=(2*c+1):3*c;
        if(BW(n,m)==1)
            white_pixel_14=white_pixel_14+1;
        end
    end
end
white_pixel_14;
white_pixel_15=0;
for n=(3*r+1):4*r;
    for m=(3*c+1):4*c;
        if(BW(n,m)==1)
            white_pixel_15=white_pixel_15+1;
        end
    end
end
white_pixel_15;
area=white_pixel+white_pixel_1+white_pixel_2+white_pixel_3+white_pixel_4+white_pixel_5+white_pixel_6+white_pixel_7+white_pixel_8+white_pixel_9+white_pixel_10+white_pixel_11+white_pixel_12+white_pixel_13+white_pixel_14+white_pixel_15;
V(11,1)=area;
W=[white_pixel;white_pixel_1;white_pixel_2;white_pixel_3;white_pixel_4;white_pixel_5;white_pixel_6;white_pixel_7;white_pixel_8;white_pixel_9;white_pixel_10;white_pixel_11;white_pixel_12;white_pixel_13;white_pixel_14;white_pixel_15 ];
for q=1:16;
    inputvector(q,v)=W(q,1);
end
for q=17:30;
    inputvector(q,v)=V(q-16,1);
end
end
for h=1:37;
    for g=1:1850;
            if h==1 && g<=50
            target(h,g)=1;
            elseif h==2 && g>=51 && g<=100
            target(h,g)=1;
            elseif h==3 && g>=101 && g<=150 
            target(h,g)=1;
            elseif h==4 && g>=151 && g<=200 
            target(h,g)=1;
            elseif h==5 && g>=201 && g<=250 
            target(h,g)=1;
            elseif h==6 && g>=251 && g<=300 
            target(h,g)=1;
            elseif h==7 && g>=301 && g<=350 
            target(h,g)=1;
            elseif h==8 && g>=351 && g<=400 
            target(h,g)=1;
            elseif h==9 && g>=401 && g<=450 
            target(h,g)=1;
            elseif h==10 && g>=451 && g<=500 
            target(h,g)=1;
            elseif h==11 && g>=501 && g<=550 
            target(h,g)=1;
            elseif h==12 && g>=551 && g<=600 
            target(h,g)=1;
            elseif h==13 && g>=601 && g<=650 
            target(h,g)=1;
            elseif h==14 && g>=651 && g<=700 
            target(h,g)=1;
            elseif h==15 && g>=701 && g<=750 
            target(h,g)=1;
            elseif h==16 && g>=751 && g<=800 
            target(h,g)=1;
            elseif h==17 && g>=801 && g<=850 
            target(h,g)=1;
            elseif h==18 && g>=851 && g<=900 
            target(h,g)=1;
            elseif h==19 && g>=901 && g<=950 
            target(h,g)=1;
            elseif h==20 && g>=951 && g<=1000 
            target(h,g)=1;
            elseif h==21 && g>=1001 && g<=1050 
            target(h,g)=1;
            elseif h==22 && g>=1051 && g<=1100 
            target(h,g)=1;
            elseif h==23 && g>=1101 && g<=1150 
            target(h,g)=1;
            elseif h==24 && g>=1151 && g<=1200 
            target(h,g)=1;
            elseif h==25 && g>=1201 && g<=1250 
            target(h,g)=1;
            elseif h==26 && g>=1251 && g<=1300 
            target(h,g)=1;
            elseif h==27 && g>=1301 && g<=1350 
            target(h,g)=1;
            elseif h==28 && g>=1351 && g<=1400 
            target(h,g)=1;
            elseif h==29 && g>=1401 && g<=1450 
            target(h,g)=1;
            elseif h==30 && g>=1451 && g<=1500 
            target(h,g)=1;
            elseif h==31 && g>=1501 && g<=1550 
            target(h,g)=1;
            elseif h==32 && g>=1551 && g<=1600 
            target(h,g)=1;
            elseif h==33 && g>=1601 && g<=1650 
            target(h,g)=1;
            elseif h==34 && g>=1651 && g<=1700 
            target(h,g)=1;
            elseif h==35 && g>=1701 && g<=1750 
            target(h,g)=1;
            elseif h==36 && g>=1751 && g<=1800 
            target(h,g)=1;
            elseif h==37 && g>=1801 && g<=1850 
            target(h,g)=1;
            else
            target(h,g)=0;
        end
    end
end
 