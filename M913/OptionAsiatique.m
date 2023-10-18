%
%   De CRR à BS pour les options asiatiques
%
clear all; close all; 
%
x=100; mu=-.05; sigma=.4; rho=.1; T=10; K=50; mc=100000;
%
% sous la proba risque neutre mu est remplace par rho
%
Nbs=100; % T/Nbs est le pas de discretisation du BM geom
X=0;
for i=1:mc
    S=browniengeom(x,rho,sigma,T,Nbs);
    Sz=[x S];
    X=X+max(mean(Sz)-K,0);
end
X=X/mc;
disp(['Prime de l option asiatique dans BS : ' num2str(X)]);
%
N=500; 
r=rho*T/N;
mud=mu*T/N;
sigmad=sigma*sqrt(T)/sqrt(N);
u=1+mud+sigmad; d=1+mud-sigmad; 
p=(1+r-d)/(u-d);
T=rand(mc,N);
l=(T<p); T(l)=u; T(~l)=d;
S= x*cumprod(T,2);
S=[x*ones(mc,1) S];
Y=max(mean(S,2)-K,0); 
Y=mean(Y);
disp(['Prime de l option asiatique dans CRR : ' num2str(Y)]);
%
