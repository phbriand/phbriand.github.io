%
% a la roulette 37 cases : 0 vert, 17 impairs noirs, 17 pairs rouges
% avec 100 euros, on veut gagner 10 euros, en pariant 1 euro sur pair
%
mc=2500; a=100; b=10; p=18/37; mT=0; pR=0; pG=0;
for i=1:mc
	S=a; T=0;
	while S*(a+b-S) >0
		x=1;
		u=rand(1,1);
		if u>p
			x=-1;
		end
		S=S+x;
		T=T+1;
	end
	mT=mT+T; pR=pR+(S==0); pG=pG+(S==a+b);
end
mT=mT/mc; pR=pR/mc; pG=pG/mc;
r=(1-p)/p; ptp= (r^(a+b)-r^a)/(r^(a+b)-1); ptg=(r^a-1)/(r^(a+b)-1); et= ((a+b)*ptg-a)/(2*p-1);
if p==.5
	ptp = b/(a+b); ptg=a/(a+b); et=a*b;
end
disp(['Proba J. Bond perd: ' num2str(pR) '   ' 'Valeur theorique : ' num2str(ptp)]);
disp(['Proba J. Bond gagne : ' num2str(pG) '   ' 'Valeur theorique : ' num2str(ptg)]);
disp(['Temps moyen de la partie : ' num2str(mT) '   ' 'Valeur theorique : ' num2str(et)]);


