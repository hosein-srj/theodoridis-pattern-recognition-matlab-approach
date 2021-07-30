randn('seed',0);
u1 = [1, 1]; u2 = [8, 6]; u3 = [13, 1];
sigma = 6*eye(2);
prob = [1/3 1/3 1/3];
N=1000;
w1 = mvnrnd(u1,sigma,floor(prob(1)*N));
w2 = mvnrnd(u2,sigma,floor(prob(1)*N));
w3 = mvnrnd(u3,sigma,floor(prob(3)*N));
X = [w1;w2;w3]';
z1 = mvnrnd(u1,sigma,floor(prob(1)*N));
z2 = mvnrnd(u2,sigma,floor(prob(1)*N));
z3 = mvnrnd(u3,sigma,floor(prob(3)*N));
Z = [z1;z2;z3]';
v = [ ones(1,floor(prob(1)*N)) 2*ones(1,floor(prob(2)*N)) 3*ones(1,floor(prob(3)*N)) ];

y_est_k_1 = k_nn_classifier(Z,v,1,X);
error_k_1 = compute_error(v,y_est_k_1)

y_est_k_11 = k_nn_classifier(Z,v,11,X);
error_k_11 = compute_error(v,y_est_k_11)

figure(1)
hold on;
plot(z1(:,1),z1(:,2),'.r')
plot(z2(:,1),z2(:,2),'.b')
plot(z3(:,1),z3(:,2),'.g')
title("training data");
legend('w1','w2','w3')
figure(2)
hold on;
for i=1:999
    if i<334
        if y_est_k_1(i)==1
            p1= plot(X(1,i),X(2,i),'.r');
        else
            p2 = plot(X(1,i),X(2,i),'xk');
        end
    elseif i<667
        if y_est_k_1(i)==2
            p3 = plot(X(1,i),X(2,i),'.b');
        else
            p4 = plot(X(1,i),X(2,i),'ok');
        end
    else
        if y_est_k_1(i)==3
            p5 = plot(X(1,i),X(2,i),'.g');
        else
            p6 = plot(X(1,i),X(2,i),'sk');
        end
    end   
end

legend([p1 p2 p3 p4 p5 p6],{'w1 True estimate','w1 False estimate','w2 True estimate','w2 False estimate','w3 True estimate','w3 False estimate'})
title("Test data(X) , k=1")

figure(3)
hold on;
for i=1:999
    if i<334
        if y_est_k_11(i)==1
            p1= plot(X(1,i),X(2,i),'.r');
        else
            p2 = plot(X(1,i),X(2,i),'xk');
        end
    elseif i<667
        if y_est_k_11(i)==2
            p3 = plot(X(1,i),X(2,i),'.b');
        else
            p4 = plot(X(1,i),X(2,i),'ok');
        end
    else
        if y_est_k_11(i)==3
            p5 = plot(X(1,i),X(2,i),'.g');
        else
            p6 = plot(X(1,i),X(2,i),'sk');
        end
    end   
end

legend([p1 p2 p3 p4 p5 p6],{'w1 True estimate','w1 False estimate','w2 True estimate','w2 False estimate','w3 True estimate','w3 False estimate'})
title("Test data(X) , k=11")

