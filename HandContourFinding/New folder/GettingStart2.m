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
pause(0.2);

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
figure('Name',int2str(loop));
c=getsnapshot(vid);
Third=c;
c=ResizingImage(c);

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

if(Ans < 1)
 close all;
beep 
beep on
subplot(1,1,1);
imshow(Second);
%aaa=input('Input Something ');
%close all;

% index1=ImageIndex(First);
% index2=ImageIndex(Second);
% fprintf('index1 = %d   index2 = %d\n',index1,index2);
str={int2str(loop),'png'};
str2=strjoin(str,'.');
imwrite(Second,str2);
loop=loop+1;
end
end
end
close all;
