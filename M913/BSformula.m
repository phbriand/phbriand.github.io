function X=BSformula(x,sigma,rho,T,K,mc)
%
% Donne la prime du call européen 
%
a=exp(rho*T);
z=randn(1,mc);
St=x*exp(sigma*sqrt(T)*z-sigma^2*T/2);
payoff=a*St-K; payoff=max(0,payoff);
X=mean(payoff)/a;
end