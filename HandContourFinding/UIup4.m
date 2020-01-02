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
BW=imcrop(BW, rectangle);
[x,y]=size(BW);
a=1;
MaMn=regionprops(BW,'MajorAxisLength','MinorAxisLength');

if length(MaMn.MajorAxisLength) > 1 || x-8<=0 || MaMn.MajorAxisLength == 0 
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
[x,y]=size(BW1);
BWX=BW1;

[row,col]=size(BWX);
Image=BW1;

startX=0;
startY=0;
for i=row:-1:1;
   for j=1:col;
       if BWX(i,j) == 1  
           if startX == 0 && startY == 0                            
              startX=i; startY=j;                                   
           end                                   
       end
       
   end
end             

loop=1;
flag=1;
ansX=[]; ansY=[];

[aa,bb]=size(Image);
while(flag == 1) 
   [Image, X, Y]=saveWhitePixelSequence(Image,startX,startY);      
   [row,col]=size(X);
   [row1,col1]=size(ansX);
   for i=1:col;
      ansX(col1+i)=X(i);    
      ansY(col1+i)=Y(i);    
   end
 
   startX=ansX(col1+col); startY=ansY(col1+col);
   if startX == aa 
       break 
   end
   [startX,startY,flag]=findWhitePixel(image, startX, startY); 
   loop=loop+1;                                                
end                                                             

 [Xx, Yy]=size(ansX);
 AF=[];
 uz=1;
 rd=1;
 for rd=45:Yy-41
     if BW3(ansX(rd),ansY(rd))==1
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
     FnA(yw,1)=(atan2d((ansY(ie)-ansY(ie+40)),(ansX(ie)-ansX(ie+40))));
     FnB(yw,1)=(atan2d((ansY(ie)-ansY(ie-40)),(ansX(ie)-ansX(ie-40))));
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
         F(twe,1)=ansX(ie);
         F(twe,2)=ansY(ie);
         jp=F(twe,1);
         jl=F(twe,2);
         twe=twe+1;
     end
     wq=AF(yw+1);
     ou=sqrt((jp-ansX(wq))^2+(jl-ansY(wq))^2);
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

white_pixels=[];
rowStart=0; rowEnd=0; colStart=0; colEnd=0;
for loop=1:16;
     white_pixels(loop)=0;
     if(loop>=1 && loop<=4)
         rowStart=1; rowEnd=50;
     elseif(loop>=5 && loop<=8)
          rowStart=51; rowEnd=100;
     elseif(loop>=9 && loop<=12)
          rowStart=101; rowEnd=150;
     elseif(loop>=13 && loop<=16)
          rowStart=151; rowEnd=200;
     end
     
     aa=mod(loop,4);
     if(aa==1)
         colStart=1; colEnd=50;
     elseif(aa==2)
          colStart=51; colEnd=100;
     elseif(aa==3)
          colStart=101; colEnd=150;
     elseif(aa==0)
          colStart=151; colEnd=200;
     end
     
     for i=rowStart:rowEnd;
         for j=colStart:colEnd;
             if(BW(i,j) == 1)
             white_pixels(loop)=white_pixels(loop)+1;
             end
         end
     end
end
area=0;

for i=1;16;
    area=area+white_pixels(i);
    in(i,1)=white_pixels(i);
end

V(11,1)=area;
for q=17:30;
in(q,1)=V(q-16,1);
end
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
loop=loop+1;

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
