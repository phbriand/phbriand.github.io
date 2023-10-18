	% Modele financier a temps discret
	% 
	% Entre deux periodes : 
	% 	hausse : l'action est multipliee par u avec proba p
	% 	baisse : l'action est multipliee par d avec proba 1-p
	% 	l'actif sans risque est multiplie par 1+r ; Ro=1
	% 
	% Il faut respecter la condition 0 < d < 1+r < u

    clear all; close all;
    %
    % paramètres
    %
	x=100; u=1.02; d=0.985; r=0.01; N=20; p=.5; MC=100000; K=50;
    %
    % Calcul de la prime
    %
    X=CRRprime(x,u,d,r,K,N,MC); 
	disp(['Prime de l option dans CRR : ' num2str(X)]);
    %
    % appel de la fonction principale
    %
    [S,C,V]=CRRfull(x,u,d,r,K,N,p,MC);
    %
    % tracés
    %
    l=0:N; 
    plot(l,S,'black');
    figure;
    plot(l,C,'red',l,V,'blue');