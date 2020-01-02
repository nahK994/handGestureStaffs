function ans= cheakPixelProperties(Image,a,b)
[row, col,z]=size(Image);    

   if(a>=1 && a<=row && b>=1 && b<=col)
%    if(Image(a,b,1) == 88 && Image(a,b,2) == 46 && Image(a,b,3) == 161) ans=2;
%     else ans=1;
%     end
   if(Image(a,b) == 1) ans=2;
    else ans=1;
   end
else ans=0;
end
end

