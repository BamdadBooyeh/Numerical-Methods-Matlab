%first assignment
load ModelReductionData.mat;%load data
figure();
scatter(X(3,:), X(5,:), 15, 'k','filled');%scatter plot the 3rd and 5th rows
X_centered = X - mean(X, 2);%center the data
[U,S,V] = svd(X_centered);%compute svd
sigma = diag(S);%singular  value 
figure();
plot(sigma, 'o', 'LineWidth', 2);
Z= U(:,1:6)' * X_centered; %projecting principle components 
figure();
plot(Z(1,:),Z(2,:),'k','MarkerSize',10);
w=0;
for i=1:5
    for j=i+1:6
        w=w+1;
        subplot(5,3,w);
        plot(Z(i,:),Z(j,:),'k*','MarkerSize',5);
        axis('equal');
    end
end

