%randn('seed',0);
mu1 = [1, 1];
sigma1 = [5 3; 3 4];
mu2 = [14, 7];
sigma2 = [5 3; 3 4];
mu3 = [16, 1];
sigma3 = [5 3; 3 4];
z1 = mvnrnd(mu1,sigma1,333);
z2 = mvnrnd(mu2,sigma2,333);
z3 = mvnrnd(mu3,sigma3,334);
X2 = [z1;z2;z3];
num=1000;

ang=0:0.01:2*pi; 
r=[2,4,6,8,10,12,14,16];
figure(1)
hold on
plot(z1(:,1),z1(:,2),'b.',z2(:,1),z2(:,2),'r.',z3(:,1),z3(:,2),'g.');
for i=1:length(r)
    [xp_1,yp_1,xp_2,yp_2,xp_3,yp_3]=calcute_var(sigma1,sigma2,sigma3,r,ang,i);
    
    
    plot(mu1(1)+xp_1,mu1(1)+yp_1,'b');
    plot(mu2(1)+xp_1,mu2(2)+yp_1,'r');
    plot(mu3(1)+xp_1,mu3(2)+yp_1,'g');
end
plot(mu1(1),mu1(2),'kx','linewidth',2);
plot(mu2(1),mu2(2),'kx','linewidth',2);
plot(mu3(1),mu3(2),'kx','linewidth',2);

[anwers_mah,anwers_euc,anwers_bayes] = classifier(num,[1/3,1/3,1/3],X2,mu1,mu2,mu3,sigma1,sigma2,sigma3);
[error_euc,error_bayes,error_mah] = error_calcute(num,anwers_euc,anwers_bayes,anwers_mah,[334,667])

function [xp_1,yp_1,xp_2,yp_2,xp_3,yp_3]=calcute_var(sigma1,sigma2,sigma3,r,ang,i)

    a = r(i)*sigma1(1,1);
    c = r(i)*sigma1(2,2);
    b = r(i)*sigma1(2,1);
    l11 = ((a+c)/2) + sqrt(((a-c)/2)^2 + b^2);
    l21 = ((a+c)/2) - sqrt(((a-c)/2)^2 + b^2);
    teta1 = 0;
    if b==0 && a<c
        teta1 = pi/2;
    else
        teta1 = atan2(l11-a,b);
    end

    a = r(i)*sigma2(1,1);
    c = r(i)*sigma2(2,2);
    b = r(i)*sigma2(2,1);
    l12 = ((a+c)/2) + sqrt(((a-c)/2)^2 + b^2);
    l22 = ((a+c)/2) - sqrt(((a-c)/2)^2 + b^2);
    teta2 = 0;
    if b==0 && a<c
        teta2 = pi/2;
    else
        teta2 = atan2(l12-a,b);
    end

    a = r(i)*sigma3(1,1);
    c = r(i)*sigma3(2,2);
    b = r(i)*sigma3(1,2);
    l13 = ((a+c)/2) + sqrt(((a-c)/2)^2 + b^2);
    l23 = ((a+c)/2) - sqrt(((a-c)/2)^2 + b^2);
    teta3 = 0;
    if b==0 && a<c
        teta3 = pi/2;
    else
        teta3 = atan2(l13-a,b);
    end


    xp_1= (sqrt(l11)*cos(teta1)*cos(ang) - sqrt(l21)*sin(teta1)*sin(ang));
    yp_1= (sqrt(l11)*sin(teta1)*cos(ang) + sqrt(l21)*cos(teta1)*sin(ang));
    xp_2= (sqrt(l12)*cos(teta2)*cos(ang) - sqrt(l22)*sin(teta2)*sin(ang));
    yp_2= (sqrt(l12)*sin(teta2)*cos(ang) + sqrt(l22)*cos(teta2)*sin(ang));
    xp_3= (sqrt(l13)*cos(teta3)*cos(ang) - sqrt(l23)*sin(teta3)*sin(ang));
    yp_3= (sqrt(l13)*sin(teta3)*cos(ang) + sqrt(l23)*cos(teta3)*sin(ang));


        

    
end

function [error_euc,error_bayes,error_mah]=error_calcute(num,anwers_euc,anwers_bayes,anwers_mah,range)
    error_euc =0;
    error_bayes =0;
    error_mah =0;
    for i=1:num
       if i<range(1)
           if anwers_euc(i)~=1
               error_euc = error_euc +1;
           end
           if anwers_bayes(i)~=1
               error_bayes = error_bayes +1;
           end
           if anwers_mah(i)~=1
               error_mah = error_mah +1;
           end
       elseif i>range(1)-1 && i<range(2)
           if anwers_euc(i)~=2
               error_euc = error_euc +1;
           end
           if anwers_bayes(i)~=2
               error_bayes = error_bayes +1;
           end
           if anwers_mah(i)~=2
               error_mah = error_mah +1;
           end
       else
           if anwers_euc(i)~=3
               error_euc = error_euc +1;
           end
           if anwers_bayes(i)~=3
               error_bayes = error_bayes +1;
           end
           if anwers_mah(i)~=3
               error_mah = error_mah +1;
           end
       end
    end
end

function [anwers_mah,anwers_euc,anwers_bayes] = classifier(num,P,X1,mu1,mu2,mu3,sigma1,sigma2,sigma3)
    anwers_bayes = [];
    anwers_euc = [];
    anwers_mah = [];
    for i=1:num
        g1_bayes = ((2*pi).^(-2/2))*(det(sigma1).^(1/2))*( exp((-1/2)*(X1(i,:)-mu1)*inv(sigma1)*(X1(i,:)-mu1)') )*P(1);  %(1/4)*(X1(i,:)-mu1)*(X1(i,:)-mu1).';
        g2_bayes = ((2*pi).^(-2/2))*(det(sigma2).^(1/2))*( exp((-1/2)*(X1(i,:)-mu2)*inv(sigma2)*(X1(i,:)-mu2)') )*P(2);
        g3_bayes = ((2*pi).^(-2/2))*(det(sigma3).^(1/2))*( exp((-1/2)*(X1(i,:)-mu3)*inv(sigma3)*(X1(i,:)-mu3)') )*P(3);
        [M,I] = max([g1_bayes,g2_bayes,g3_bayes]);
        anwers_bayes = [anwers_bayes,I];

        g1_euc = -sqrt((X1(i,:)-mu1)*(X1(i,:)-mu1)');
        g2_euc = -sqrt((X1(i,:)-mu2)*(X1(i,:)-mu2)');
        g3_euc = -sqrt((X1(i,:)-mu3)*(X1(i,:)-mu3)');
        [M,I] = max([g1_euc,g2_euc,g3_euc]);
        anwers_euc = [anwers_euc,I];

        g1_mah = (-1/4)*(X1(i,:)-mu1)*inv(sigma3)*(X1(i,:)-mu1)';
        g2_mah = (-1/4)*(X1(i,:)-mu2)*inv(sigma3)*(X1(i,:)-mu2)';
        g3_mah = (-1/4)*(X1(i,:)-mu3)*inv(sigma3)*(X1(i,:)-mu3)';
        [M,I] = max([g1_mah,g2_mah,g3_mah]);
        anwers_mah = [anwers_mah,I];

    end
end
