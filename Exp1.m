c=[1,1;2,1.5;2,1;3,1.5];
N=10;
X=[];
sigma=0.2;
for i=1:4
X=[X;sigma*randn(N,2)+repmat(c(i,:),N,1)];
end
Y=[ones(1,2*N) -ones(1,2*N)];
plot(X(1:end/2,1),X(1:end/2,2),’+’)
hold all
plot(X(end/2+1:end,1),X(end/2+1:end,2),’o’)
hold off