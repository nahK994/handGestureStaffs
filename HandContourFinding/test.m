clc
clear all
% vid=videoinput('winvideo',1);
% preview(vid,image(zeros(660,640,3)));



% a=imread('bangla3.jpg');
% size(a)
% a=imresize(a, [200 200]);
% Count=1;
% image=a;
% a=rgb2gray(a);
% [count,x]=imhist(a,9);
% T=otsuthresh(count);
% a=imbinarize(a,T); 
% a = medfilt2(a, [10 10]);
% a = bwmorph(a,'bridge',60);
% a = bwmorph(a,'diag',60);
% %a = edge(a,'sobel');
% [row,col]=size(a);
% 
% white_pixels=[];
% rowStart=0; rowEnd=0; colStart=0; colEnd=0;
% for loop=1:16;
%      white_pixels(loop)=0;
%      if(loop>=1 && loop<=4)
%          rowStart=1; rowEnd=50;
%      elseif(loop>=5 && loop<=8)
%           rowStart=51; rowEnd=100;
%      elseif(loop>=9 && loop<=12)
%           rowStart=101; rowEnd=150;
%      elseif(loop>=13 && loop<=16)
%           rowStart=151; rowEnd=200;
%      end
%      
%      aa=mod(loop,4);
%      if(aa==1)
%          colStart=1; colEnd=50;
%      elseif(aa==2)
%           colStart=51; colEnd=100;
%      elseif(aa==3)
%           colStart=101; colEnd=150;
%      elseif(aa==0)
%           colStart=151; colEnd=200;
%      end
%      
%      for i=rowStart:rowEnd;
%          for j=colStart:colEnd;
%              if(a(i,j) == 1)
%              white_pixels(loop)=white_pixels(loop)+1;
%              end
%          end
%      end
% end
% 
% r=50;
% c=50;
% white_pixel=[];
% white_pixel(1)=0;
% for n=1:r;
%     for m=1:c;
%         if (a(n,m)==1)
%             white_pixel(1)=white_pixel(1)+1;
%         end
%     end
% end
% white_pixel(1);
% white_pixel(2)=0;
% for n=1:r;
%     for m=(c+1):2*c;
%         if (a(n,m)==1)
%             white_pixel(2)=white_pixel(2)+1;
%         end
%     end
% end
% white_pixel(2);
% white_pixel(3)=0;
% for n=1:r;
%     for m=(2*c+1):3*c;
%         if(a(n,m)==1)
%             white_pixel(3)=white_pixel(3)+1;
%         end
%     end
% end
% white_pixel(3);
% white_pixel(4)=0;
% for n=1:r;
%    for m=(3*c+1):4*c;
%        if(a(n,m)==1)
%            white_pixel(4)=white_pixel(4)+1;
%        end
%    end
% end
% white_pixel(4);
% white_pixel(5)=0;
% for n=(r+1):2*r;
%     for m=1:c;
%         if(a(n,m)==1)
%            white_pixel(5)=white_pixel(5)+1;
%         end
%     end
% end
% white_pixel(5);
% white_pixel(6)=0;
% for n=(r+1):2*r;
%     for m=(c+1):2*c;
%         if(a(n,m)==1)
%             white_pixel(6)=white_pixel(6)+1;
%         end
%     end
% end
% white_pixel(6);
% white_pixel(7)=0;
% for n=(r+1):2*r;
%     for m=(2*c+1):3*c;
%         if(a(n,m)==1)
%             white_pixel(7)=white_pixel(7)+1;
%         end
%     end
% end
% white_pixel(7);
% white_pixel(8)=0;
% for n=(r+1):2*r;
%     for m=(3*c+1):4*c;
%         if(a(n,m)==1)
%             white_pixel(8)=white_pixel(8)+1;
%         end
%     end
% end
% white_pixel(8);
% white_pixel(9)=0;
% for n=(2*r+1):3*r;
%     for m=1:c;
%         if(a(n,m)==1)
%             white_pixel(9)=white_pixel(9)+1;
%         end
%     end
% end
% white_pixel(9);
% white_pixel(10)=0;
% for n=(2*r+1):3*r;
%     for m=(c+1):2*c;
%         if(a(n,m)==1)
%             white_pixel(10)=white_pixel(10)+1;
%         end
%     end
% end
% white_pixel(10);
% white_pixel(11)=0;
% for n=(2*r+1):3*r;
%     for m=(2*c+1):3*c;
%         if(a(n,m)==1)
%             white_pixel(11)=white_pixel(11)+1;
%         end
%     end
% end
% white_pixel(11);
% white_pixel(12)=0;
% for n=(2*r+1):3*r;
%     for m=(3*c+1):4*c;
%         if(a(n,m)==1)
%             white_pixel(12)=white_pixel(12)+1;
%         end
%     end
% end
% white_pixel(12);
% white_pixel(13)=0;
% for n=(3*r+1):4*r;
%     for m=1:c;
%         if(a(n,m)==1)
%             white_pixel(13)=white_pixel(13)+1;
%         end
%     end
% end
% white_pixel(13);
% white_pixel(14)=0;
% for n=(3*r+1):4*r;
%     for m=(c+1):2*c;
%         if(a(n,m)==1)
%             white_pixel(14)=white_pixel(14)+1;
%         end
%     end
% end
% white_pixel(14);
% white_pixel(15)=0;
% for n=(3*r+1):4*r;
%     for m=(2*c+1):3*c;
%         if(a(n,m)==1)
%             white_pixel(15)=white_pixel(15)+1;
%         end
%     end
% end
% white_pixel(15);
% white_pixel(16)=0;
% for n=(3*r+1):4*r;
%     for m=(3*c+1):4*c;
%         if(a(n,m)==1)
%             white_pixel(16)=white_pixel(16)+1;
%         end
%     end
% end
% white_pixel(16);
% 
% count=0;
% for i=1: 16;
%     if(white_pixels(i) ~= white_pixel(i))
%         count=count+1;
%         fprintf('%d   %d  %d\n',i,white_pixels(i),white_pixel(i));
%     end
% end
% count
% imshow(a);