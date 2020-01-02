clc ;
clear all ;

vid=videoinput('winvideo',1) ;
loop=0;
while loop<=8
a=getsnapshot(vid);
First=a ;
pause(0.5) ;

b=getsnapshot(vid);
Second=b;
pause(0.5);

a=ResizingImage(a);
b=ResizingImage(b);

UnmatchedPixels=0;
c=a-b;
for i=1:260;
    for j=1:260;
        if(c(i,j) == 1)
       % if(a(i,j) ~= b(i,j))
            UnmatchedPixels=UnmatchedPixels+1;
        end
    end
end
Ans=(UnmatchedPixels/(260*260))*100;
fprintf('%f\n',Ans);

if Ans < 1
close all;
beep 
beep on

figure('Name',int2str(loop));
subplot(2,1,1);
imshow(First);
subplot(2,1,2);
imshow(Second);

%aaa=input('Input Something ');
%close all;

% index1=ImageIndex(First);
% index2=ImageIndex(Second);
% fprintf('index1 = %d   index2 = %d\n',index1,index2);
str={int2str(loop),'1'};
str1=strjoin(str,'_');
str2={str1,'png'};
str3=strjoin(str2,'.');
imwrite(First,str3);

Str={int2str(loop),'2'};
Str1=strjoin(Str,'_');
Str2={Str1,'png'};
Str3=strjoin(Str2,'.');
imwrite(Second,Str3);

loop=loop+1;
end
end
close all;
