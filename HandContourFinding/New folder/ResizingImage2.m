function aa = ResizingImage2(a)

% [count,x]=imhist(a,9);
% T=otsuthresh(count);
% a=imbinarize(a,T); 
% a = medfilt2(a, [10 10]);
% a = bwmorph(a,'bridge',60);
% a = bwmorph(a,'diag',60);

[row,col]=size(a);

xMin=0; yMin=0; Height=0; Width=0; 
%fprintf('Stage One\n');
flag=1;
for i=1:row;   % for yMin
    for j=1:col;
    if a(i,j) == 1
        yMin=i;
        flag=0;
        break;
    end
    end
    if flag == 0
        break;
    end
end
%fprintf('Stage Two\n');
flag=1;
for i=1:col;   % for xMin
    for j=1:row;
    if a(j,i) == 1
        xMin=i;
        flag=0;
        break;
    end
    end
    if flag == 0
        break;
    end
end
%fprintf('Stage Three\n');
flag=1;
for i=row:-1:1;    % for height
    for j=1:col;
        if a(i,j) == 1
        Height=i-yMin;
        flag=0;
        break;
    end
    end
    if flag == 0
        break;
    end
end     
%fprintf('Stage Four\n');
flag=1;
for j=col:-1:1;   % for width
    for i=1:row;
          if a(i,j) == 1
        Width=j-xMin;
        flag=0;
        break;
    end
    end
    if flag == 0
        break;
    end
end
%fprintf('Stage Five\n');

xMin=xMin-10; yMin=yMin-10; Height=Height+10; Width=Width+20;

%fprintf('Stage Six\n');
%fprintf('xMin = %d\nyMin = %d\nWidth = %d\nHeight = %d\nrow = %d\ncol = %d\n',xMin,yMin,Width,Height,row,col);
if(xMin>0 & yMin>0 & Height>0 & Width>0)
% a=imcrop(a,[xMin,yMin,Width,Height]);
% a=imresize(a,[260 260]);
% a = medfilt2(a, [10 10]);
% a = bwmorph(a,'bridge',60);
% a = bwmorph(a,'diag',60);
aa=[xMin,yMin,Width,Height];
else aa=[-1 -1 -1 -1];
end
end