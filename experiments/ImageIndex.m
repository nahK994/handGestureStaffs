function ImageINDEX = ImageIndex(DB)
load('NNF.mat');
DB=imresize(DB,[260 260]);
DBW=DB;
ybr=rgb2ycbcr(DBW);
DBW=rgb2gray(DBW);
cb=ybr(:,:,2);
cr=ybr(:,:,3);
% fprintf('asdf 1\n');
for gt=2:-1:0;
for pp=0:1:25;
   [r, c, ~]=find(cb>(80+gt) & cb <(127+gt) & cr>(140-pp) & cr<(180-pp));% skin
   numid=size(r,1);
   MBW=DBW;
   for i=1:numid
       MBW(r(i),c(i),:)=255;
   end
MBW= medfilt2(MBW, [5 5]);
[counts,~] = imhist(MBW,4);
T = otsuthresh(counts);

BW = imbinarize(MBW,T);
BW= medfilt2(BW, [10 10]);
BW = bwmorph(BW,'bridge',60);
BW = bwmorph(BW,'diag',60);
BW= imfill(BW,'holes');
cca = bwconncomp(BW);
% fprintf('asdf 2\n');
fj=0;
lj=0;
ww=0;
for n=1:260;
    for m=1:260;
        if(BW(n,m)==1)
           ww=ww+1;
        end
    end
end
for ih=1:260; 
    if BW(ih,4)==1 || BW(4,ih)==1 || BW(ih,256)==1
       fj=1;
    end
    if BW(ih,4)==1 || BW(4,ih)==1 || BW(256,ih)==1
       lj=1;
    end
end
if cca.NumObjects==1 && (fj==0 || lj==0) && ww>5000 && ww<60000
   break
end
end
if cca.NumObjects==1 && (fj==0 || lj==0) && ww>5000 && ww<60000
    break
end
end
% fprintf('asdf 3\n');
rotation=0;
for angle=0:90:360;
BW = imrotate(BW,-angle, 'bilinear');
[x,y]=size(BW);
n=x-10;
w=0;
for m=1:y;
    if (BW(n,m)==1)
        w=w+1;
    end
end
if (w>=15)
    break
end
rotation=rotation+1;
BW = medfilt2(BW, [10 10]);
BW = bwmorph(BW,'bridge',50);
BW = bwmorph(BW,'diag',50);
BW = imfill(BW,'holes');
end
Qj=0;
Lj=0;
Kj=0;
Wj=0;
FJ=0;
vj=0;
for Rh=260:-1:1
for Dh=1:260;
    if BW(Rh,Dh)==1
        Qj=Dh;
        break
    end
end
for Dh=260:-1:1;
    if BW(Rh,Dh)==1
        Lj=Dh;
        break
    end
end
if Lj-Qj>=Kj
    Wj=Wj+1;
else
    Wj=0;
  %  vj=Kj;
end
Kj=Lj-Qj;
if Wj>20 % && Kj-vj>3
    FJ=260-(Rh+18);
    break
end
end
% fprintf('asdf 4\n');
A=regionprops(BW, 'BoundingBox');
x=A.BoundingBox(1)-10;
y=A.BoundingBox(2)-10;
w=A.BoundingBox(3)+20;
h=A.BoundingBox(4)+10-FJ;
rectangle=[x y w h];
BW=imcrop(BW, rectangle);
[x,y]=size(BW);
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
             ED(sf,2)=sy; BW1(sx+1,sy)=0;
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
% fprintf('asdf 5\n');
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
in(q,1)=W(q,1);
end
for q=17:30;
in(q,1)=V(q-16,1);
end
Result=NNF(in);
val = 1; %value to find
tmp = abs(Result-val);
[idx idx] = min(tmp); %index of closest value
% fprintf('idx = %d\n',idx);
ImageINDEX=idx;
end