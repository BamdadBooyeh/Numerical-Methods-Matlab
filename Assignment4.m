load Yale_64x64.mat

faceW=64;
faceH=64;

X =fea;
count=0;

index_faces = randperm(10,5);
index_expression = [8 2 5 10 4 11];

numPerLine= length(index_expression);
ShowLine= length(index_faces);
Y = zeros(faceH*ShowLine,faceW*numPerLine);
F_lin = zeros ( faceH*faceW,ShowLine*numPerLine);

for i = 0: ShowLine-1
    for j = 0: numPerLine-1
        count=count+1;
        Y(i*faceH+1:(i+1)*faceH,j*faceW+1:(j+1)*faceW)=reshape(fea(index_faces(i+1)*11+index_expression(j+1),:),[faceH,faceW]);
        F_lin(:,count)= fea(index_faces(i+1)*11+index_expression(j+1),:);
    end
end

figure(1);
imagesc(Y);colormap(gray);

figure();
r=64;
[U, D, V] = svds(Y,r);
Sigma=diag(D);
k_values = [4, 8, 15];
semilogy(Sigma,'o');
grid on;
xlabel('Index');
ylabel('Singular Value');
title('Logarithmic Plot of Singular Values');


for k = k_values
     count= count+1;
     [U,D,V]=svds(Y,k);
     X_approx = U*D*V';
     diff=X_approx-Y;
figure()
subplot (1,2,1)
imagesc(X_approx)
colormap(gray)
axis off
title(['approxiamtion with k =',num2str(k,'%d')]);
subplot(1,2,2)
imagesc(diff)
colormap(gray)
grid on
title(['Different with k =',num2str(k,'%d')])
end

[U1,D1,V1]=svd(F_lin);

figure;
w=0;
for i = 1:5 
feature=reshape(U1(:,i),[64,64]);
figure ()
w=w+1;
subplot(1,5,w)
imagesc(feature)
colormap("gray")
title('feature vector',num2str(i,'%d'));
end
 



