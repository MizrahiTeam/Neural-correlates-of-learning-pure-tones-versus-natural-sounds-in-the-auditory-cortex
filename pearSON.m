function s=pearSON(X,Y)

        C = cov(X,Y);

s=C(1,2) / sqrt(C(1,1) * C(2,2));
    

     