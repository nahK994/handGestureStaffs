function aa = ResizingImage(a)
[row,col]=size(a);
length=0;
if(row>col) length=row;
else length=col;
end
xMin=0; yMin=0; yMax=0; xMax=0; Height=0; Width=0; 

flag1=1;
flag2=1;
flag3=1;
flag4=1;
for i=1:length;   
    for j=1:length;
    if i<=row && j<=col && a(i,j) == 1 && flag1 == 1
        yMin=i;
        flag1=0;
    end
    if  row-(i-1)>0 && row-(i-1)<=row && j<=col && a(row-(i-1),j) == 1 && flag2 == 1
        yMax=row-(i-1);
        flag2=0;
    end
    
    if j<=row && i<=col && a(j,i) == 1 && flag3 == 1
        xMin=i;
        flag3=0;
        break;
    end
     
    if j<=row && col-(i-1)>0 && col-(i-1)<=col && a(j,col-(i-1)) == 1 && flag4 == 1
        xMax=col-(i-1);
        flag4=0;
        break;
    end
    
    if  flag1 == 0 && flag2 == 0 && flag3 == 0 && flag4 == 0 
        break;
    end
    end
    
    if  flag1 == 0 && flag2 == 0 && flag3 == 0 && flag4 == 0 
        break;
    end
end

 xMin=xMin-10; yMin=yMin-10; Height=(yMax-yMin)+10; Width=(xMax-xMin)+10;

aa=[xMin,yMin,Width,Height];
end

% [row,col]=size(a);
% 
% xMin=0; yMin=0; Height=0; Width=0; 
% %fprintf('Stage One\n');
% flag=1;
% for i=1:row;   % for yMin
%     for j=1:col;
%     if a(i,j) == 1
%         yMin=i;
%         flag=0;
%         break;
%     end
%     end
%     if flag == 0
%         break;
%     end
% end
% %fprintf('Stage Two\n');
% flag=1;
% for i=1:col;   % for xMin
%     for j=1:row;
%     if a(j,i) == 1
%         xMin=i;
%         flag=0;
%         break;
%     end
%     end
%     if flag == 0
%         break;
%     end
% end
% %fprintf('Stage Three\n');
% flag=1;
% for i=row:-1:1;    % for height
%     for j=1:col;
%         if a(i,j) == 1
%         Height=i-yMin;
%         flag=0;
%         break;
%     end
%     end
%     if flag == 0
%         break;
%     end
% end     
% %fprintf('Stage Four\n');
% flag=1;
% for j=col:-1:1;   % for width
%     for i=1:row;
%           if a(i,j) == 1
%         Width=j-xMin;
%         flag=0;
%         break;
%     end
%     end
%     if flag == 0
%         break;
%     end
% end
% %fprintf('Stage Five\n');
% 
% xMin=xMin-10; yMin=yMin-10; Height=Height; Width=Width+20;
% 
% %fprintf('Stage Six\n');
% %fprintf('xMin = %d\nyMin = %d\nWidth = %d\nHeight = %d\nrow = %d\ncol = %d\n',xMin,yMin,Width,Height,row,col);
% if(xMin>0 & yMin>0 & Height>0 & Width>0)
% % a=imcrop(a,[xMin,yMin,Width,Height]);
% % a=imresize(a,[260 260]);
% % a = medfilt2(a, [10 10]);
% % a = bwmorph(a,'bridge',60);
% % a = bwmorph(a,'diag',60);
% % aa=a;
% aa=[xMin,yMin,Width,Height];
% else aa=[-1 -1 -1 -1];
% end