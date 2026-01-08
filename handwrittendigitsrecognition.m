
load('HandwrittenDigits.mat');  
num_dig=input('How Many Numbers You Want To Evaluate?');
selected_digits = input('What Numbers You Want to Evaluate?(Enter a Vector Same Lenght of what you chose eg.[1,2,3]:');
sample_num = input('How Many Samples You Want?');
U_results = cell(num_dig,1);
err_norm_all = zeros(num_dig, numel([5, 10, 15, 20, 25])); 
p=size(X,2);
xbar=1/p*sum(X,2);
X=X-xbar*ones(1,p);
%X = X-mean(X,2);

for idx = 1:num_dig
    digit = selected_digits(idx);
    IK = find(I == digit);
    IK2 = IK(1:sample_num);
    XK = X(:, IK2);
    [U, D, V] = svd(XK);
    U_results{idx} = U;
end 

for k = [5, 10, 15, 20, 25]  
    figure
    for idx = 1:num_dig
        digit = selected_digits(idx);
        IK = find(I == digit);
        IK2 = IK(1:sample_num);
        U = U_results{idx};
        Z = U(:, 1:k)' * X(:, IK2);  
        PP = U(:, 1:k) * Z;
        YY = X(:, IK2) - PP;  
        subplot(num_dig, 2, 2*idx - 1);
        imagesc(reshape(PP(:, 1), 16, 16)');
        title(['Approximation ', num2str(digit), ' with k = ', num2str(k)]);
        subplot(num_dig, 2, 2*idx);
        imagesc(reshape(YY(:, 1), 16, 16)');
        title(['Error for Digit ', num2str(digit), ' with k = ', num2str(k)]);
        err_norm_all(idx, k) = norm(YY, 2); 
    end
end

figure;
for k = [5, 10, 15, 20, 25] 
 for idx = 1:num_dig
    subplot(num_dig, 1, idx);
    semilogy(err_norm_all(idx,:), 'o'); 
    title(['Norm of Error for Digit ', num2str(selected_digits(idx))]);
    xlabel('k');
    ylabel('Norm of Error');
 end
end




load('HandwrittenDigits.mat');  

selected_digits =[0,1,5,7];
U_results = cell(4,1);

for idx = 1:4
    digit = selected_digits(idx);
    IK = find(I == digit);
    IK2 = IK(1:5);
    XK = X(:, IK2);
    [U, D, V] = svd(XK);
    U_results{idx} = U;
end

for k = [5, 10, 15, 20, 25]  
   figure
    for idx = 1:4
        digit = selected_digits(idx);
        IK = find(I == digit);
        IK2 = IK(1:5);
        U = U_results{idx};
        Z = U(:, 1:k)' * X;
        PP = U(:, 1:k) * Z;
        YY = X - PP;
        subplot(4, 2, 2*idx - 1);
        imagesc(reshape(X(:, IK2(1)), 16, 16)');
        title(['Original Image for Digit ', num2str(digit)]);
        subplot(4, 2, 2*idx);
        imagesc(reshape(YY(:, IK2(1)), 16, 16)');
        title(['Error for Digit ', num2str(digit), ' with k = ', num2str(k)]);
    end
end

