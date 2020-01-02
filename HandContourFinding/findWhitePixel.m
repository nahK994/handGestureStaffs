function [ansX, ansY, flag] = findWhitePixel(image, startX, startY)

     Q=[]; ans1=[]; ans2=[]; 
     directionX= [0, -1, -1, -1, 0, 1, 1, 1]; directionY= [-1, -1, 0, 1, 1, 1, 0, -1];
     Q=push_back(Q,startX);   
     Q=push_back(Q,startY);
     ansX=0; ansY=0;
     [row,col,z]=size(image);
     map=zeros(row,col);
     map(startX,startY)=1;
     flag=0;
     while( isEmpty(Q) == 0 )  
         i=Q(1);
         j=Q(2);
         Q(1)=[]; Q(1)=[];      
        
         if ( cheakPixelProperties(image,i,j) == 2 && map(i,j) == 1)
             break;
         end
         
         for k=1:8;
            q=i+directionX(k) ;
            w=j+directionY(k) ;
            
            if ( cheakPixelProperties(image,q,w) >= 1 && map(q,w) == 0 )    
                map(q,w)=1;                                                
                Q=push_back(Q,q);                                          
                Q=push_back(Q,w);                                   
                
                if cheakPixelProperties(image,q,w) == 2
                  ans1=push_back(ans1,q);
                  ans2=push_back(ans2,w);
                end
            end
            
         end
     end
     

     [row,col]=size(ans1);
     if(col>0)
         flag=1;
        min=(startX-ans1(1))*(startX-ans1(1))+(startY-ans2(1))*(startY-ans2(1)); 
        minX=ans1(1);
        minY=ans2(1);                     
        
        for i=1:col;
           if( (startX-ans1(i))*(startX-ans1(i))+(startY-ans2(i))*(startY-ans2(i)) < min )
              min = (startX-ans1(i))*(startX-ans1(i))+(startY-ans2(i))*(startY-ans2(i));
              minX=ans1(i);
              minY=ans2(i);
           end
        end
        ansX=minX;
        ansY=minY;
     end
end