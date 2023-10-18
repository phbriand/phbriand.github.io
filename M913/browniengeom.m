function S=browniengeom(x,mu,sigma,T,N)
%
% simule une trajectoire du MB geometrique sur [0,T]
% pour i=1,.., N, S(i)=BM geom au temps i T/N
%
%
h=T/N; l=(1:N); t=h*l;
%
B=brownien(T,N);
S= sigma*B + (mu-sigma^2/2)*t;
S=x*exp(S);
end 
