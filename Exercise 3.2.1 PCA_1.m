randn('seed',0);
%clc;clear;
mu1 = [-6 6 6];
mu2 = [6 6 6];
sigma = [[0.3 1 1];[1 9 1];[1 1 9]];
N=400;
z1 = mvnrnd(mu1,sigma,N/2);
z2 = mvnrnd(mu2,sigma,N/2);
X1 = [z1;z2];
X1 = X1';

[eigenval, eigenvec,Y] = pca_fun(X1,3);

figure(1)

subplot(3,2,1);
hold on;
p1 = plot(X1(1,1:200),X1(2,1:200),'r.');
p2 = plot(X1(1,201:400),X1(2,201:400),'b.');
xlabel('x1')
ylabel('x2')
xlim([-20 20])
ylim([-20 20])
legend ([p1 p2],['class1' ;'class2'],'Location','north');

subplot(3,2,2);
hold on;
p1 = plot(Y(1,1:200),Y(2,1:200),'r.');
p2 = plot(Y(1,201:400),Y(2,201:400),'b.');
xlabel('y1')
ylabel('y2')
xlim([-20 20])
ylim([-20 20])
legend ([p1 p2],['class1' ;'class2'],'Location','north');

subplot(3,2,3);
hold on;
p1 = plot(X1(1,1:200),X1(3,1:200),'r.');
p2 = plot(X1(1,201:400),X1(3,201:400),'b.');
xlabel('x1')
ylabel('x3')
xlim([-20 20])
ylim([-20 20])
legend ([p1 p2],['class1' ;'class2'],'Location','north');

subplot(3,2,4);
hold on;
p1 = plot(Y(1,1:200),Y(3,1:200),'r.');
p2 = plot(Y(1,201:400),Y(3,201:400),'b.');
xlabel('y1')
ylabel('y3')
xlim([-20 20])
ylim([-20 20])
legend ([p1 p2],['class1' ;'class2'],'Location','north');

subplot(3,2,5);
hold on;
p1 = plot(X1(2,1:200),X1(3,1:200),'r.');
p2 = plot(X1(2,201:400),X1(3,201:400),'b.');
xlabel('x2')
ylabel('x3')
xlim([-20 20])
ylim([-20 20])
legend ([p1 p2],['class1' ;'class2']);

subplot(3,2,6);
hold on;
p1 = plot(Y(2,1:200),Y(3,1:200),'r.');
p2 = plot(Y(2,201:400),Y(3,201:400),'b.');
xlabel('y2')
ylabel('y3')
xlim([-20 20])
ylim([-20 20])
legend ([p1 p2],['class1' ;'class2']);
title('Mean1:-6 6 6 , Mean2:6 6 6')
cov(Y')

function [eigenval,eigenvec,Y]=pca_fun(X,m)
    [l,N]=size(X);
    mean_vec=mean(X')';
    X_zero=X-mean_vec*ones(1,N);
    R=cov(X_zero');
    [V,D]=eig(R);
    eigenval=diag(D);
    [eigenval,ind]=sort(eigenval,1,'descend');
    eigenvec=V(:,ind);
    explain=eigenval/sum(eigenval);
    eigenval=eigenval(1:m);
    eigenvec=eigenvec(:,1:m);
    A=eigenvec(:,1:m)';
    Y=A*X;
end