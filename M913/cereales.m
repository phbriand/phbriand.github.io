% initialisation
mc=10000; mT=0; m=20;
% calcul de la valeur theorique
l=1:m-1; l=1./l; vT=1+m*sum(l);
for i=1:mc
	T=0; col=zeros(1,m); nbv=sum(col);
    while nbv<m
		u=rand(1,1);
		x=floor(m*u)+1;
        col(x)=1;
        nbv=sum(col);
		T=T+1;
    end
	mT=mT+T; 
end
mT=mT/mc;
disp(['Temps moyen pour obtenir la collection : ' num2str(mT)]);
disp(['Valeur theorique : ' num2str(vT)]);
