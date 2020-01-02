function varargout = UIup1(varargin)
% UIup1 MATLAB code for UIup1.fig
%      UIup1, by itself, creates a new UIup1 or raises the existing
%      singleton*.
%
%      H = UIup1 returns the handle to a new UIup1 or the handle to
%      the existing singleton*.
%
%      UIup1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UIup1.M with the given input arguments.
%
%      UIup1('Property','Value',...) creates a new UIup1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UIup1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UIup1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UIup1

% Last Modified by GUIDE v2.5 14-Apr-2017 18:02:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UIup1_OpeningFcn, ...
                   'gui_OutputFcn',  @UIup1_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before UIup1 is made visible.
function UIup1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UIup1 (see VARARGIN)

% Choose default command line output for UIup1
Blank=imread('WB.jpg');
handles.output = hObject;
axes(handles.axes1);
imshow(Blank);
% Update handles structure
guidata(hObject, handles);
axes(handles.axes4);
imshow(Blank);
AB='Press Start';
set(handles.edit1, 'String', AB);
% UIWAIT makes UIup1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = UIup1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Startbutton.
function Startbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Startbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Test(1)='0';
Test(2)='1';
Test(3)='2';
Test(4)='3';
Test(5)='4';
Test(6)='5';
Test(7)='6';
Test(8)='7';
Test(9)='8';
Test(10)='9';
Test(11)='A';
Test(12)='B';
Test(13)='C';
Test(14)='D';
Test(15)='E';
Test(16)='F';
Test(17)='G';
Test(18)='H';
Test(19)='I';
Test(20)='J';
Test(21)='K';
Test(22)='L';
Test(23)='M';
Test(24)='N';
Test(25)='O';
Test(26)='P';
Test(27)='Q';
Test(28)='R';
Test(29)='S';
Test(30)='T';
Test(31)='U';
Test(32)='V';
Test(33)='W';
Test(34)='X';
Test(35)='Y';
Test(36)='Z';
Test(37)='_';
TDF=' ';
load('NNF.mat');
AB='Show Sign';
set(handles.edit1, 'String', AB);
vid=videoinput('winvideo',1);
hImage=image(zeros(660,640,3),'Parent',handles.axes1);
preview(vid,hImage);
pause(2);
pre_val=0;
loop=1;
while(1)    
AB='New';
set(handles.edit1, 'String', AB);
aN=getsnapshot(vid);
%size(aN)
pause(0.2) ;
bN=getsnapshot(vid);
pause(0.2);
DBN=bN;

aN=rgb2gray(aN);
[count,x]=imhist(aN,9);
T=otsuthresh(count);
aN=imbinarize(aN,T); 
aN = medfilt2(aN, [10 10]);
aN = bwmorph(aN,'bridge',60);
aN = bwmorph(aN,'diag',60);
a1=ResizingImage(aN);
if a1(1) == -1 || a1(2) == -1 || a1(3) == -1 || a1(4) == -1
    continue
end
%size(aN)
aN=imcrop(aN,a1);
aN=imresize(aN,[260 260]);
%size(aN)
aN = medfilt2(aN, [10 10]);
aN = bwmorph(aN,'bridge',60);
aN = bwmorph(aN,'diag',60);

bN=rgb2gray(bN);
[count,x]=imhist(bN,9);
T=otsuthresh(count);
bN=imbinarize(bN,T); 
bN = medfilt2(bN, [10 10]);
bN = bwmorph(bN,'bridge',60);
bN = bwmorph(bN,'diag',60);
b1=ResizingImage(bN);
if b1(1) == -1 || b1(2) == -1 || b1(3) == -1 || b1(4) == -1
    continue
end
bN=imcrop(bN,b1);
bN=imresize(bN,[260 260]);
bN = medfilt2(bN, [10 10]);
bN = bwmorph(bN,'bridge',60);
bN = bwmorph(bN,'diag',60);


UnmatchedPixels=0;
cN=xor(aN,bN);
for i=1:260;
    for j=1:260;
        if(cN(i,j) == 1)
            UnmatchedPixels=UnmatchedPixels+1;
        end
    end
end
Ans=(UnmatchedPixels/(260*260))*100;
threshold=5;
if Ans < threshold
    dN=getsnapshot(vid);
    pause(0.5);
    
    dN=rgb2gray(dN);
    [count,x]=imhist(dN,9);
    T=otsuthresh(count);
    dN=imbinarize(dN,T); 
    dN = medfilt2(dN, [10 10]);
    dN = bwmorph(dN,'bridge',60);
    dN = bwmorph(dN,'diag',60);
    d1=ResizingImage(dN);
    if d1(1) == -1 || d1(2) == -1 || d1(3) == -1 || d1(4) == -1
      continue
    end
    dN=imcrop(dN,d1);
    dN=imresize(dN,[260 260]);
    dN = medfilt2(dN, [10 10]);
    dN = bwmorph(dN,'bridge',60);
    dN = bwmorph(dN,'diag',60);
    
    UnmatchedPixels=0;
cN=xor(dN,bN);
UnmatchedPixels=0;
for i=1:260;
    for j=1:260;
        if(cN(i,j) == 1)
            UnmatchedPixels=UnmatchedPixels+1;
        end
    end
end
Ans=(UnmatchedPixels/(260*260))*100;
if Ans < threshold
    DB=DBN;
AB='Done';
set(handles.edit1, 'String', AB);

DB=imresize(DB,[260 260]);
DBW=DB;
DBW=rgb2gray(DBW);
[counts,~] = imhist(DBW,10);
T = otsuthresh(counts);
for ot=0:0.01:0.1;
BW = imbinarize(DBW,T-ot);
BW= medfilt2(BW, [10 10]);
BW = bwmorph(BW,'bridge',60);
BW = bwmorph(BW,'diag',60);
BW= imfill(BW,'holes');
cca = bwconncomp(BW);
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

if ot>0.1
    continue;
end

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
BW= medfilt2(BW, [10 10]);
BW = bwmorph(BW,'bridge',50);
BW = bwmorph(BW,'diag',50);
BW= imfill(BW,'holes');
end

if angle>360
    continue
end

rectangle=ResizingImage(BW);

if(rectangle(3) <= 0 || rectangle(4) <= 0)
    continue
end

BW=imcrop(BW, rectangle);
[x,y]=size(BW);
a=1;
MaMn=regionprops(BW,'MajorAxisLength','MinorAxisLength');

if length(MaMn.MajorAxisLength) > 1
    continue
end
if x-8<=0 || MaMn.MajorAxisLength == 0 
    continue
end

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
   %  zr(yw,1)=ou;
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
%fprintf('%f',in(1,1));
% for aaa=2:30;
%     fprintf(' %f',in(aaa,1));
% end
% fprintf('\n');
Result=NNF(in);
val = 1; %value to find
tmp = abs(Result-val);
[idx idx] = min(tmp); %index of closest value
closest = Result(idx);


if pre_val == idx && idx == 1
    break
end
if pre_val == idx && idx ~= 37
    continue
end


pre_val=idx;
% str0={int2str(loop),Test(idx)};
% str1=strjoin(str0,'_');
% str2={str1,'png'};
% str3=strjoin(str2,'.');
% imwrite(DBN,str3);
% 
% str4={int2str(loop+100),Test(idx)};
% str5=strjoin(str4,'_');
% str6={str5,'png'};
% str7=strjoin(str6,'.');
% imwrite(BW,str7);
loop=loop+1;

%fprintf('loop = %d idx = %f  closest = %f\n output = %c',loop,idx,closest,Test(idx));
TDF=strcat(TDF,Test(idx));
if idx ~= 37
   TDF = strrep(TDF,'__','') ;
   TDF = strrep(TDF,'_',' ') ;
end
set(handles.edit2, 'String', TDF);
axes(handles.axes4);
imshow(DW1);
hold on;
plot(F(:,2),F(:,1), 'b*', 'MarkerSize', 10)
hold off;
end
end
end
function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Resetbutton.
function Resetbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Resetbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Blank=imread('WB.jpg');
axes(handles.axes1);
imshow(Blank);
axes(handles.axes2);
imshow(Blank);
axes(handles.axes4);
imshow(Blank);
AB='Press Start';
set(handles.edit1, 'String', AB);
clear all;



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
