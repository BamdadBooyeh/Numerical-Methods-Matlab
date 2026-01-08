
 load("IrisDataAnnotated .mat")

% ( 1 )
rng(1); %set seed control
k = 3; %number of clusters
t = 1; %index for while cycle
maxiteration = 100000; %max number of iterations

  

% 3 random centroids
a = randi([1 50],1);%Uniformly distributed pseudorandom integers
b = randi([51 100],1);
c = randi([100 150],1);
centroids = [a b c];
dim=size(X,1);
[n,m]=size(X);
 p=m;

 

D = calculate_distance_matrix(X, centroids);

 figure()
plot(X(1,:), X(2,:), 'bo', 'MarkerSize', 8);
hold on;
plot(X(1, centroids), X(2, centroids), 'mp', 'MarkerSize', 12, 'LineWidth', 2);
xlabel("x")
ylabel("y")
legend('Data', 'Random Centroids')

for ell = 1:k
    I_ell = find(I_assign == ell); % Indices of data points assigned to the current centroid
    
    % Extract the data points assigned to the current centroid
    X_ell = X(:, I_ell);
    
    % Calculate the distance matrix within the cluster
    D_ell = calculate_distance_matrix(X_ell, X_ell);
    
    % Calculate the total distance within the cluster
    s = sum(D_ell);
    
    % Find the index of the data point with the minimum total distance
    [~, j] = min(s);
    
    % Update the medoid to the selected data point
    centroids(:, ell) = X_ell(:, j);
end

  function D = calculate_distance_matrix(X, centroids)
    n = size(X, 2); % Number of data points
    k = size(centroids, 2); % Number of centroids
    D = zeros(n, k); % Initialize distance matrix
    
    for i = 1:n
        for j = 1:k
            D(i, j) = norm(X(:, i) - centroids(:, j));
        end
    end
    end

