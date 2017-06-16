%%  K-means algorithm
%Adapted and modified from km_fun.m by Alireza

clear all
[A] = textread('2D_points_for_Kmeans.txt'); %Read image
F= A; % Input
K = 3; % Number of Clusters
%% Selection of initial centers based on value of K (Only for K=2 or K=3)
if K==1
    CENTS=A(1,:);
else if K==2

     %Furthest Initial centers    
%    CENTS(1,:)=A(1,:);
%    CENTS(2,:)=A(17,:);

    %Closest Initial centers
    CENTS(1,:)=A(3,:);
    CENTS(2,:)=A(10,:);
    
    else if K==3
        
    %Furthest Initial centers
%     CENTS(1,:)=A(1,:);
%     CENTS(2,:)=A(17,:);
%     CENTS(3,:)=A(15,:);

    %Closest Initial centers
    CENTS(1,:)=A(3,:);
    CENTS(2,:)=A(10,:);
    CENTS(3,:)=A(15,:);
    
        else
            error('Please pick K=2 or K=3')
        end
    end
end

DAL   = zeros(size(F,1),K+2);  % Distances and Labels
car=0; % Iteration counter
err=10; % Arbitrary initialization of error.

 while abs(err)>0.001; % Error tolerance for convergence
     aver=DAL; %Saves value of distances
   for i = 1:size(F,1)
      for j = 1:K  
        DAL(i,j) = norm(F(i,:) - CENTS(j,:));      
      end
      [Distance, CN] = min(DAL(i,1:K));                % 1:K are Distance from Cluster Centers 1:K 
      DAL(i,K+1) = CN;                                 % K+1 is Cluster Label
      DAL(i,K+2) = Distance;                           % K+2 is Minimum Distance
   end
   for i = 1:K
      AA = (DAL(:,K+1) == i);                           % Cluster K Points
      CENTS(i,:) = mean(F(AA,:));                       % New Cluster Centers
      if sum(isnan(CENTS(:))) ~= 0                     % If CENTS(i,:) Is Nan Then Replace It With Random Point
         NC = find(isnan(CENTS(:,1)) == 1);            % Find Nan Centers
         for Ind = 1:size(NC,1)
         CENTS(NC(Ind),:) = F(randi(size(F,1)),:);
         end
      end
   end
   
car=car+1; %Increase iterations by one
dam=DAL-aver; % Find difference with the previous iteration
err=mean(mean(dam)); %Determine error value
 end

% Plot   
CV    = '+r+b+c+m+k+yorobocomokoysrsbscsmsksy';       % Color Vector
hold on
 for i = 1 : K
PT = F(DAL(:, K+1) == i, :);                % Find points of each cluster    
plot(PT(:, 1),PT(:, 2),CV(2*i-1 : 2*i), 'LineWidth', 2);                   % Plot points with determined color and shape
plot(CENTS(:, 1), CENTS(:, 2), '*k', 'LineWidth', 7);  % Plot cluster centers
 end
hold off
grid on
title('Data set')

DAL(1,:)
CENTS
car