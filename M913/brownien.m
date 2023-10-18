function B=brownien(T,N)
%
% simule une trajectoire du MB sur [0,T]
% pour i=1,.., N, B(i)=BM au temps i T/N
%
%
h=T/N;
%
%   Accroissements Browniens
%
z=randn(1,N); B=sqrt(h)*cumsum(z);
end 


