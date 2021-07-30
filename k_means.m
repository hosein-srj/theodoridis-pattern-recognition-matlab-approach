function [theta,bel,J]=k_means(X,theta)
[l,N]=size(X);
[l,m]=size(theta);
e=1;
iter=0;
while(e~=0)
    iter=iter+1;
    theta_old=theta;
    dist_all=[];
    for j=1:m
        dist=sum(((ones(N,1)*theta(:,j)'-X').^2)');
        dist_all=[dist_all; dist];
    end
    [q1,bel]=min(dist_all);
    J=sum(min(dist_all));
    
    for j=1:m
        if(sum(bel==j)~=0)
            theta(:,j)=sum(X'.*((bel==j)'*ones(1,l))) / sum(bel==j);
        end
    end
    e=sum(sum(abs(theta-theta_old)));
end