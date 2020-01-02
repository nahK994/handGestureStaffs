function ans=isEmpty(a)
    [row, col]=size(a);
    if row == 0 || col == 0
        ans=1;
    else ans=0;
    end
end
