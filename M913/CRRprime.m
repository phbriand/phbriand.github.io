function X=CRRprime(x,u,d,r,K,N,MC)
% 
% calcule la prime de l'option donne par payoff dans le modele CRR
% 
	p=(1+r-d)/(u-d);
	Y=rand(MC,N);
	l=(Y<p); Y(l)=u; Y(~l)=d;
	S= x*prod(Y,2);
	S=payoff(S,K);
	X=mean(S)/(1+r)^N;
end
