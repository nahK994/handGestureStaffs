clc ;
clear all ;

a=5;
a
length(a)

% a=imread('asdf.png');
% a=rgb2gray(a);
% [count,x]=imhist(a,9);
% T=otsuthresh(count);
% a=imbinarize(a,T); 
% a = medfilt2(a, [10 10]);
% a = bwmorph(a,'bridge',60);
% a = bwmorph(a,'diag',60);
% aa=ResizingImage2(a);
% aa(1)
% aa(2)
% aa(3)
% aa(4)
% a=imcrop(a,aa);
% imshow(a);

% working
% while(1)
%     a=input('Give Inout ');
%      if a == 1
% fprintf('DONE\n');
% beep
% beep on
%      end
% if a==0
%     break
% end
% end

% working
% vid=videoinput('winvideo',1) ;
% preview(vid,image(zeros(660,640,3)));

% working
% vid=videoinput('winvideo',1) ;
% while(1)
% close all;
% pause(1);
% a=getsnapshot(vid);
% aa=a;
% a=ResizingImage(a);
% subplot(2,1,1);
% imshow(aa);
% subplot(2,1,2);
% imshow(a);
% x=input('Input X\n');
% if(x == 0) 
%     break;
% end
% end
% fprintf('DONE\n');

% working
% vid=videoinput('winvideo',1) ;
% preview(vid,image(zeros(660,640,3))) ;

% working
% a=1;
% vid=videoinput('winvideo',1) ;
% while(a<=100)
% pause(1) ;
% a=getsnapshot(vid);
% subplot(2,1,1);
% imshow(a);
% pause(0.5) ;
% b=getsnapshot(vid);
% subplot(2,1,2);
% imshow(b);
% a=a+1;
% end
% close all;
% figure('Name','HiHi');
% subplot(2,1,1);
% imshow(a);
% subplot(2,1,2);
% imshow(b);

% working
% a=imread('1.png');
% a=rgb2gray(a);
% b=imresize(a,[260,260]) ;
% imshow(b);

%working
% a=imread('1.png') ;
% b=a(:,:,1) ;
% b1=a(:,:,2) ;
% b2=a(:,:,3) ;
% subplot(3,1,1);
% imshow(b) ;
% subplot(3,1,2);
% imshow(b1) ;
% subplot(3,1,3);
% imshow(b2) ;

% working
% b=imread('1.png');
% b=rgb2gray(b);
% b=imbinarize(b);
% imshow(b);

% working
% a=impixel(imread('1.jpg'));

% working
% a=imread('1.jpg');
% red=a(:,:,1);
% green=a(:,:,2);
% blue=a(:,:,3);
% out= red>=230 & red<=255 & green>=230 & green<=255 & blue>=230 & blue<=255 ;
% subplot(3,1,1) ;
% imshow( imfill(out,'holes') );
% subplot(3,1,2) ;
% imshow( out );
% subplot(3,1,3) ;
% imshow( a );

% working
% a=imread('1.jpg');
% a=rgb2gray(a);
% imshow(a);
% [q,w]=imhist(a,2);
% stem(w,q);   % Always at first X, then comes Y...........

% working
% a=imread('5.jpg');
% a=rgb2gray(a);
% [count,x]=imhist(a,10);
% T=otsuthresh(count);
% a=imbinarize(a,T); 
% subplot(3,1,1);
% imshow(a);
% a = medfilt2(a, [10 10]);
% subplot(3,1,2);
% imshow(a);
% a = bwmorph(a,'bridge',60);
% a = bwmorph(a,'diag',60);
% a = imfill(a,'holes');
% subplot(3,1,3);
% imshow(a);

% % working
% a=imread('4.jpg');
% a=rgb2gray(a);
% [count,x]=imhist(a,10);
% T=otsuthresh(count);
% a=imbinarize(a,T); 
% a = medfilt2(a, [10 10]);
% a = bwmorph(a,'bridge',60);
% a = bwmorph(a,'diag',60);
% b=imread('4.jpg');
% b=rgb2gray(b);
% [count,x]=imhist(b,10);
% T=otsuthresh(count);
% b=imbinarize(b,T); 
% b = medfilt2(b, [10 10]);
% b = bwmorph(b,'bridge',60);
% b = bwmorph(b,'diag',60);
% [x,y] =size(a);
% w=0 ;
% w1=0;
% w2=0;
% for i=1:x;
%    for j=1:y;
%        w2=w2+1;
%        if (a(i,j) == 1 && b(i,j) == 1)
%           w=w+1;           
%        else if (a(i,j) == 1 && b(i,j) == 0) || (b(i,j) == 1 && a(i,j) == 0)
%                w1=w1+1;
%            end
%        end
%    end
% end
% fprintf('%d  %d  %d  %d  %d\n',w,w1,w2,x,y);

% hiahi
% a=imread('1.jpg');
% a=imcrop(a,[-8, 0, 50000, 50000]);
% imshow(a);
