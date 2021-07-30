m=[0; 2]';
S(:,:,1)= [0.2];
S(:,:,2)= [0.2];
P=[1/3 2/3];
N=1000;
randn('seed',0);
[X]=generate_gauss_classes(m,S,P,N);

x=-5:0.1:5;
pdfx=(1/3)*(1/sqrt(2*pi*0.2))*exp(-(x.^2)/0.4) +(2/3)*(1/sqrt(2*pi*0.2))*exp(-((x-2).^2)/0.4);
figure(1);
h=0.1;
plot(x,pdfx); 
title("N="+N+" h="+h);
hold;

pdfx_approx=Parzen_gauss_kernel(X,h,-5,5);
plot(-5:h:5,pdfx_approx,'r');

figure(2)
h=0.01;
plot(x,pdfx); 
title("N="+N+" h="+h);
hold;
pdfx_approx=Parzen_gauss_kernel(X,h,-5,5);
plot(-5:h:5,pdfx_approx,'r');

N=10000;
h=0.1;
[X]=generate_gauss_classes(m,S,P,N);
figure(3)
plot(x,pdfx); 
title("N="+N+" h="+h);
hold;
pdfx_approx=Parzen_gauss_kernel(X,h,-5,5);
plot(-5:h:5,pdfx_approx,'r');

function approx = Parzen_gauss_kernel(X,h,start_x,end_x)
    num = length(X);
    approx = zeros(1,(end_x-start_x)/h);
    p=1;
    for i=start_x:h:end_x
        sum = 0;
        for j=1:num
            sum = sum + exp(- ( ( (i-X(j)).^2 ) / (2*h.^2) ) ); 
        end 
        approx(p) = sum/(num*h*sqrt(2*pi));
        p = p + 1;
    end
end

function [X] = generate_gauss_classes(mu,sigma,Prob,num)
    X = [];
    for i=1:length(mu)  
        z1 = mvnrnd(mu(i),sigma(i),floor(Prob(i)*num)) ;
        X = [ X ; z1 ];
    end
end