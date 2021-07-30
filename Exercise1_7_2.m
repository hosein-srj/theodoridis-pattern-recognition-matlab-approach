m=[0 0;0 2];
S(:,:,1)= [[0.2 0];[0 0.2]];
S(:,:,2)= [[0.2 0];[0 0.2]];
P=[1/3 2/3];
N=1000;
h=0.1;
randn('seed',0);
[X]=generate_gauss_classes(m,S,P,N);

[x1,x2] = meshgrid(-4:0.05:4); 
pdfx=(1/3)*(1/(2*pi*0.2))*exp(-(x1.^2 + x2.^2)/(2*0.2^2)) +(2/3)*(1/(2*pi*0.2))*exp(-(x1.^2 + (x2-2).^2)/(2*0.2^2));
figure(1)
surf(x1,x2,pdfx)


[x1,x2] = meshgrid(-4:h:4); 
pdfx_approx=Parzen_gauss_kernel(X,h,-4,4);
figure(2)
surf(x1,x2,pdfx_approx)

function approx = Parzen_gauss_kernel(X,h,start_x,end_x)
    num = length(X);   
    approx = zeros((end_x-start_x)/h,(end_x-start_x)/h);
    o1=1;
    for i=start_x:h:end_x
        o2=1;
        for j=start_x:h:end_x
            sum=0;
            for t=1:num
                sum = sum + exp(- ( (  ([i;j]-X(t,:)')'*([i;j]-X(t,:)') ) / (2*h.^2) ) );
            end    
            approx(o2,o1) = sum/(num*h.^2*2*pi);
            o2 = o2 +1;
        end 
        o1 = o1 +1;
    end
end

function [X] = generate_gauss_classes(mu,sigma,Prob,num)
    X = [];
    for i=1:length(mu)
        z1 = mvnrnd(mu(:,i),sigma(:,:,i),floor(Prob(i)*num)) ;
        X = [ X ; z1 ];
    end
end