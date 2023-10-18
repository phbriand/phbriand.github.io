%
%   De CRR à BS
%
clear all; close all; 
%
x=100; mu=-.05; sigma=.2; rho=.1; T=10; K=120; mc=100000;
%
X=BSformula(x,sigma,rho,T,K,mc);
disp(['Prime de l option dans BS : ' num2str(X)]);
%
N=10; 
r=rho*T/N;
mud=mu*T/N;
sigmad=sigma*sqrt(T)/sqrt(N);
u=1+mud+sigmad; d=1+mud-sigmad;
Y=CRRprime(x,u,d,r,K,N,mc);
disp(['Prime de l option dans CRR : ' num2str(Y)]);
%


