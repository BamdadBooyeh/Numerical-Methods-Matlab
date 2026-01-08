 load('HandwrittenDigits.mat')
 
 I1=find(I==4);
 I2=find(I==0);

X1=X(:,I1);
X2=X(:,I2);


 p1=length(I1);
 c1=1/p1*sum(X1,2);
 x1c=X1 - c1*ones(1,p1);


 p2=length(I2);
 c2=1/p2*sum(X2,2);
 x2c=X2- c1* ones(1,p2);


 sw=x1c*x1c' + x2c*x2c';

 p = p1 + p2;
 c =1/p*sum(X,2);

sb = p1*(c1-c)*p1*(c1-c)'+p2*(c2-c)*p2*(c2-c)';

XX=[x1c,x2c];

sw2=svd(sw);
sw3=sw2.^2;
%[eig(sw),flip(sw3)];

tau=10^(-10);
epsilon = tau*max((eig(sw)));


 if (det(sw) <=10^(-10));

    disp('do regularization')
 else
     disp('no regularization')
 end
   
 