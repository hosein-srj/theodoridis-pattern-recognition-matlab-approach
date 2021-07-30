randn('seed',10)

S1=[.5 0 0; 0 .5 0; 0 0 .01];
S2=[1 0 0; 0 1 0; 0 0 .01];
a=6;
mv=[0 0 0; a 0 0; a/2 a/2 0; 0 a 0; -a/2 a/2 0;-a 0 0; -a/2 -a/2 0; 0 -a 0; a/2 -a/2 0]';
N=100;

X=[mvnrnd(mv(:,1),S1,N)];
for i=2:9
    X=[X; mvnrnd(mv(:,i),S2,N)];
end
X=X';
c=2;
y=[ones(1,N) 2*ones(1,8*N)]; 
figure(1), plot3(X(1,y==1),X(2,y==1),X(3,y==1),'r.',...
X(1,y==2),X(2,y==2),X(3,y==2),'b.')
figure(1), axis equal


[Sw,Sb,Sm]=scatter_mat(X,y);
[V,D]=eig(inv(Sw)*Sb);
s=diag(D);
[s,ind]=sort(s,1,'descend');
V=V(:,ind);
A=V(:,1:c-1);
Y=A'*X;
figure(2), plot(Y(y==1),0,'ro',Y(y==2),0,'b.')
figure(2), axis equal



function [Sw,Sb,Sm]=scatter_mat(X,y)
    [l,N]=size(X);
    c=max(y);
    m=[];
    Sw=zeros(l);
    for i=1:c
        y_temp=(y==i);
        X_temp=X(:,y_temp);
        P(i)=sum(y_temp)/N;
        m(:,i)=(mean(X_temp'))';
        Sw=Sw+P(i)*cov(X_temp');
    end
    m0=(sum(((ones(l,1)*P).*m)'))';
    Sb=zeros(l);
    for i=1:c
        Sb=Sb+P(i)*((m(:,i)-m0)*(m(:,i)-m0)');
    end
    Sm=Sw+Sb;
end