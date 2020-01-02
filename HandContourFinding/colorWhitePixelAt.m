function Image= colorWhitePixelAt(image, row, col, parentPixelRow, parentPixelCol)

%   image(row,col,1)=image(parentPixelRow,parentPixelCol,1)+20; image(row,col,2)=159; image(row,col,3)=90;
%   if(image(row,col,1)>203)
%       image(row,col,1)=103;
%   end
   image(row,col)=0;
  Image=image;
end