%% Assigmnet 7.2
%% Natasha Kubiak

%GP example
meanfunc = [];                             % empty: don't use a mean function
covfunc = {@covSum,{@covLIN,@covConst}};   % Linear covariance function
likfunc = @likGauss;                       % Gaussian likelihood
hyp = struct('mean', [],'cov', 0, 'lik', -1);
N = 100 ;
x=rand(N,1);
y=0.5*x+0.5+0.1*randn(size(x));
D = 1; % 3 dimesnion
N = 100 ;
sigma = 0.05;

d = data(N , D, sigma);

hyp2 = minimize(hyp, @gp, -100, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
xs=(0:0.1:1)';
[mu s2] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y, xs);






%% FUNCTION
%% DIFF DATA CHANGE SEED

function [Y,y,f] = data(N,m,sigma) 
% m: predictor input length (dimension of the input) 
% N: number of generated samples 
% sigma: noise standard deviation 
m=m+1;      
randn('seed',50); 
x=randn(N,1); 
b = [0.0312, 0.1250, 0.1874, 0.1250, 0.0312] *(10^3);
a = [1.0000, -3.5897, 4.8513, -2.9241, 0.6630];
[b,a]=butter(4,0.05); 
f=filter(b,a,x); 
temp=f+sigma*randn(size(x));
temp=buffer(temp,m,m-1,'nodelay'); 
y=temp(end,:)'; 
Y=[temp(1:end-1,:)']; 

hold on;
%plot([b,a],'-r');
plot(f,'-m');
plot(y,'--black');
plot(Y,'--black');
legend({'noise free output','one "sigma" output'},'Location','southeast')
title('Prediction')
end

% m = length of predictor input
% Y= matrix of data
% y = vector