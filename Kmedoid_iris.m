load ("IrisDataAnnotated .mat")
%finding the k-medoids with norm1 rng(’default ’)
%data matrix
%s = rng; %initial seed fixed to have the same results
%distance matrix to be defined from X
%Here we want to make the distance matrix between all pairs of data %base on the norm 1,
%so if the j and i would be the same, the distance is 0, otherwise %the l1 distance is computed
rng(1);
dim=size(X,1);
[n,m]=size(X);
p=m;

for i=1:p
  for j=i:p
    if (i==j) 
            D(i,j)=0;
       else
            D(i,j)=norm(X(:,i)-X(:,j),2);
     %NORM 1 
%D(i,j)=norm(X(:,i)-X(:,j),2);
%To check with Norm2(Euclidean Norm)
    end
  end
end
D=D+D';

I_m =[33 ,99 ,101];


figure()
plot(X(1,:), X(2,:), 'bo', 'MarkerSize', 8);
hold on;
plot(X(1, I_m), X(2, I_m), 'mp', 'MarkerSize', 12, 'LineWidth', 2);
legend('Data', 'Random Centroids')

Err=1;
itmax = 100;
tol=1.0e-10;
iter=0;

D_m = D(1:end,I_m)
[q,I_assign]= min(D_m')

Q=sum(q)

k=length(I_m)
oldI_m=I_m;
clear I_m

for ell=1:k
    I_ell = find(I_assign == ell)
    D_ell = D(I_ell ,I_ell)
    s=sum(D_ell)
    [qq(ell),j] = min(sum(D_ell))
    I_m(ell) = I_ell(j);
    newI_m=I_m
oldI_m
end






figure ()
for j=1:k
 X_l{j} = X(:,find(I_assign == j));
end


figure ()
plot(X(1,:),X(2,:),'bo', 'MarkerSize', 8);
hold on ; plot(X(1,I_m),X(2,I_m),'mp','MarkerSize', 12, 'LineWidth', 2);
legend('Data','Final Centroids (Euclidean Norm)')



figure ()
for j = 1:k
    scatter3(X_l{j}(1,:), X_l{j}(2,:), X_l{j}(3,:), [], repmat([0 0 0], size(X_l{j}, 2), 1),'filled');
    hold on;
end


scatter3(X_l{1}(1,:),X_l{1}(2,:),X_l{1}(3,:),'cyan','filled') 
scatter3(X_l{2}(1,:),X_l{2}(2,:),X_l{2}(3,:),'red','filled') 
scatter3(X_l{3}(1,:),X_l{3}(2,:),X_l{3}(3,:),'green','filled')
title('Final clustering K Medoids (Euclidean Norm)')





figure();

% Plot each cluster
for j = 1:k
    scatter3(X_l{j}(1,:), X_l{j}(2,:), X_l{j}(3,:), [], repmat([0 0 0], size(X_l{j}, 2), 1), 'filled');
    hold on;
end

% Plot medoids
scatter3(X(1, I_m), X(2, I_m), X(3, I_m), 100, 'rx', 'LineWidth', 5);

% Set colors for clusters
colors = {'cyan', 'blue', 'green'};
for j = 1:k
    scatter3(X_l{j}(1,:), X_l{j}(2,:), X_l{j}(3,:), [], colors{j}, 'filled');
    hold on;
end

title('Final clustering K Medoids (Euclidean Norm)');
legend('Cluster 1 (Cyan)', 'Cluster 2 (Blue)', 'Cluster 3 (Green)', 'Medoids');


figure ()
cm = confusionchart(I,I_assign);




