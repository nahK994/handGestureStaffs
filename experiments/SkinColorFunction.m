function image=SkinColourFunction(DB)
DB=imresize(DB,[260 260]);
DBW=DB;
ybr=rgb2ycbcr(DBW);
DBW=rgb2gray(DBW);
cb=ybr(:,:,2);
cr=ybr(:,:,3);
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
for ot=0:0.01:0.1;
BW = imbinarize(MBW,T+ot);
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
BW1 = imbinarize(MBW,0.95-ot);
BW1 = medfilt2(BW1, [10 10]);
BW1 = bwmorph(BW1,'bridge',60);
BW1 = bwmorph(BW1,'diag',60);
BW1 = imfill(BW1,'holes');
cca = bwconncomp(BW1);
fj=0;
lj=0;
ww=0;
for n=1:260;
    for m=1:260;
        if(BW1(n,m)==1)
           ww=ww+1;
        end
    end
end
for ih=1:260;
    if BW1(ih,4)==1 || BW1(4,ih)==1 || BW1(ih,256)==1
       fj=1;
    end
    if BW1(ih,4)==1 || BW1(4,ih)==1 || BW1(256,ih)==1
       lj=1;
    end
end
if cca.NumObjects==1 && (fj==0 || lj==0) && ww>5000 && ww<60000
   BW=BW1;
    break
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
image=BW;
end