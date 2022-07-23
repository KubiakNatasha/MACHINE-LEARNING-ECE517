%% Natasha Kubiak
% ECE 517


clear all; close all; clc

%GP example
meanfunc = [];                             % empty: don't use a mean function
covfunc = {@covSum,{@covLIN,@covConst}};   % Linear covariance function
likfunc = @likGauss;                       % Gaussian likelihood
hyp = struct('mean', [],'cov', 0, 'lik', -1);

N=50;
x=rand(N,1);
sigma = 0.5;
y=sigma*x+sigma+0.1*randn(size(x));

hyp2 = minimize(hyp, @gp, -100, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
xs=(0:0.1:1)';
[mu s2] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y, xs);

ys = 0.5*xs+0.5;
s_plus1 = ys + sqrt(s2);
s_plus2 = ys + 2*sqrt(s2);
s_minus1 = ys - sqrt(s2);
s_minus2 = ys - 2*sqrt(s2);

scatter(x,y,'blue','o');
hold on
plot(xs,ys,'bo','LineWidth',2);
plot(xs,s_plus1,'black--',xs,ys,'--blue',xs,s_minus1,'black--','LineWidth',2);
plot(xs,s_plus2,'black--',xs,s_minus2,'black--');
title('E-SVR');
subtitle
legend('','', '1\sigma Band','' ,'', '2\sigma Band','Location','southeast');


