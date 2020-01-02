function [Image, ansX, ansY] = saveWhitePixelSequence(Image, startX, startY)   
     Q=[]; ansX=[]; ansY=[];     
     directionX= [0, 0, -1, 1, -1, -1, 1, 1]; directionY= [1, -1, 0, 0, -1, 1, 1, -1];
     ansX=push_back(ansX,startX);
     ansY=push_back(ansY,startY);                  
     Q=push_back(Q,startX);       
     Q=push_back(Q,startY);                                           
     Image= colorWhitePixelAt(Image,startX,startY,startX,startY);
     while ( isEmpty(Q) == 0 )   
         i=Q(1);      
         j=Q(2);      
         Q(1)=[]; Q(1)=[];  
         for k=1:8;
            q=i+directionX(k) ;
            w=j+directionY(k) ;
            
            if ( cheakPixelProperties(Image,q,w) == 2 )       
               ansX=push_back(ansX,q);                        
               ansY=push_back(ansY,w);                        
               Image= colorWhitePixelAt(Image,q,w,i,j);    
               Q=push_back(Q,q);
               Q=push_back(Q,w);
            end
            
         end
     end
end