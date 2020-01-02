function v=push_back(aa,a)
    [row,col]=size(aa);
    aa(col+1)=a;
    v=aa;
end