%
% Illustration de la formule d'Ito avec le MB geom et la fonction sin(x)
%
clear all; close all;
x=1; T=10; mu=.2; sigma=0.2; N=1000;
l=0:N; t=T*l/N;
E=exp(mu*t);
S=browniengeom(x,mu,sigma,T,N);
S=[x S];
plot(t,E,'blue',t,S,'red');
%
% Formule d'Ito
%
DeltaS=S(2:N+1)-S(1:N);
D=cos(S(1:N)); DD=-sin(S(1:N));
F=D.*DeltaS+DD.*S(1:N).^2*sigma^2*T/N/2;
F=cumsum(F);
F=sin(x)+[0 F];
figure;
plot(t,sin(S),t,F,'+r');
