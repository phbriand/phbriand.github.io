mc=10000; mT=0; mS=0; mR=0; r=-1;
for i=1:mc
	x=0; T=0; S=0;
	while x<6
		u=rand(1,1);
		x=floor(6*u)+1;
		T=T+1;
		S=S+x;
	end
	% disp(T);
	mT=mT+T; mS=mS+S; mR=mR+(T>6+r);
end
mT=mT/mc; mS=mS/mc; mR=mR/mc;
disp(['Temps moyen du premier six : ' num2str(mT)]);
disp(['Somme moyenne des des : ' num2str(mS)]);
disp(['P(T>E(T)+r) pour r=' num2str(r) ' : ' num2str(mR)]);


