load Yale_64x64.mat
faceW=64;
faceH=64;
index_f = randperm(14,6);
index_expression = [2 3  5 10 11];

numPerLine= length(index_expression);
ShowLine= length(index_f);

count=0;
F_lin = zeros ( faceH*faceW,ShowLine*numPerLine);
for i = 0: ShowLine-1
    for j = 0: numPerLine-1
        count=count+1;
        Y(i*faceH+1:(i+1)*faceH,j*faceW+1:(j+1)*faceW)=reshape(fea(index_f(i+1)*11+index_expression(j+1),:),[faceH,faceW]);
        F_lin(:,count)= fea(index_f(i+1)*11+index_expression(j+1),:);
    end
end
[U,D,V]=svd(F_lin);
selected_row=randperm(6,1);
index_expression = [2 3  5 10 11];



X=zeros(64*64,5);
for i = 1:5
    
    X(:,i)=F_lin(:,((selected_row-1)*5)+i);
    X_plot= reshape(X(:,i),[64,64]);
    figure(10)
    subplot(4,5,i+15)
    
    imagesc(X_plot)
    colormap (gray)
    axis equal
    axis off
    box off
    title('original')
end

X_approx= zeros(64,64*5);
count=0;
for i= [4 8 15]
    P_C= U(:,1:i)'*X;
    approx=U(:,1:i)*P_C;
    error= X - approx;
    for j = 1:5
        approx_plot=reshape(approx(:,j),[64,64]);
        figure(10)
        subplot(4,5,j+count*5)
        imagesc(approx_plot)
        colormap (gray)
        axis equal
        axis off
        box off
        title(['k=',num2str(i,'%d')]);

        error_plot=reshape(error(:,j),[64,64]);
        figure(11)
        subplot(3,5,j+count*5)
        imagesc(error_plot)
        colormap (gray)
        axis equal
        axis off
        box off
        title(['Error for ','k=',num2str(i,'%d')]);

    end
    count=count+1;
end
