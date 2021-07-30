randn('seed',0);
mu1 = [0 0 0];
mu2 = [1 2 2];
mu3 = [3 3 4];
sigma = [0.8 0 0; 0 0.8 0 ; 0 0 0.8];


z1 = mvnrnd(mu1,sigma,333);
z2 = mvnrnd(mu2,sigma,333);
z3 = mvnrnd(mu3,sigma,333);
X1 = [z1;z2;z3];
num=999;
h=0.1;
[anwers_bayes] = classifier(num,X1,mu3,sigma,z1,z2,h);
[error_bayes_h_0m1] = error_calcute(num,anwers_bayes,[334,667])

h=0.01;
[anwers_bayes] = classifier(num,X1,mu3,sigma,z1,z2,h);
[error_bayes_h_0m01] = error_calcute(num,anwers_bayes,[334,667])
function [anwers_bayes] = classifier(num,X1,mu3,sigma,z1,z2,h)
    anwers_bayes = [];
    anwers_euc = [];
    anwers_mah = [];
    for i=1:num
        g1_bayes = calcute_g(X1(i,:),z1,h);
        g2_bayes = calcute_g(X1(i,:),z2,h);
        g3_bayes = ((2*pi).^(-2/2))*(det(sigma).^(1/2))*( exp((-1/2)*(X1(i,:)-mu3)*inv(sigma)*(X1(i,:)-mu3)') );
        [M,I] = max([g1_bayes,g2_bayes,g3_bayes]);
        anwers_bayes = [anwers_bayes,I];
    end
end


function sum = calcute_g(xi,X,h)
    sum=0;
    num = length(X);
    for t=1:num
        sum = sum + exp(- ( ( (xi-X(t,:))*(xi-X(t,:))' ) / (2*h.^2) ) );
    end
    sum = sum/(num*h.^3*(2*pi).^(3/2));
end


function [error_bayes]=error_calcute(num,anwers_bayes,range)

    error_bayes =0;
    for i=1:num
       if i<range(1)
           if anwers_bayes(i)~=1
               error_bayes = error_bayes +1;
           end
       elseif i>range(1)-1 && i<range(2)
           if anwers_bayes(i)~=2
               error_bayes = error_bayes +1;
           end
       else
           if anwers_bayes(i)~=3
               error_bayes = error_bayes +1;
           end
       end
    end
end


