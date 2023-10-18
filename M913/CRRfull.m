	% Modele financier a temps discret
	% 
	% Entre deux periodes : 
	% 	hausse : l'action est multipliee par u avec proba p
	% 	baisse : l'action est multipliee par d avec proba 1-p
	% 	l'actif sans risque est multiplie par 1+r ; Ro=1
	% 
	% Il faut respecter la condition 0 < d < 1+r < u
    %

function [S,C,V]=CRRfull(x,u,d,r,K,N,p,MC)
    %
    C=zeros(1,N+1);
    psi=zeros(1,N);
    %
    % simulation de l'action : S(i) est le prix de l'action à l'instant i-1
    %
	S=action(x,u,d,p,N);
    %
    % calcul de la trajectoire du prix de l'option et de la stratégie de
    % couverture
    %
    C(N+1)=payoff(S(N+1),K);
    %
    for i=1:N
        %
        % C(i) est le prix de l'option à l'instnant i-1
        % psi(i) strategie de couverture à l'instant i
        %
        C(N+1-i) = prixoption(S(N+1-i),u,d,r,K,N,N-i,MC);
        %
        psi(N+1-i)= ( prixoption(S(N+1-i)*u,u,d,r,K,N,N-i,MC) - prixoption(S(N+1-i)*d,u,d,r,K,N,N-i,MC) ) / (S(N+1-i)*(u-d));
    end 
    %
    % calcul du portefeuille de couverture
    %
    l=0:N;
    St = (1+r).^(-l).*S;
    DSt =  St(2:N+1)-St(1:N);
    Vt= cumsum(psi.*DSt); Vt=[0 Vt]; Vt=C(1)+Vt;
    V=(1+r).^l.*Vt;
    %
    % tracé du prix de l'option et du portefeuille de couverture
    %
    
    %
    %figure; plot(l,C-V);
    %plot(l,S,'black');
	%figure; plot(l(2:length(l)),psi,'green');
	%
	% Modele de Black-Scholes
	%
	% T=1; mu=1.3; sigma=0.2; r=0.1; N=500;
	% [S,C,V,psi]=bs(T,So,mu,sigma,r,K,N,MC);
	% clf; hold; plot(l,C); plot(l,V,'red'); plot(l,S,'black');
end

	

function S=action(x,u,d,p,N)
% 
% simule une trajectoire de l'action S sur N periodes
% 
		Y=rand(1,N);
		l=(Y<p); Y(l)=u; Y(~l)=d;
		S= x*cumprod(Y);
		S=[x,S];
end

function pof=payoff(s,k)
% 
% pour le call
% 	
	pof=abs(s-k)+s-k;
	pof = pof/2;
end
				
function X=prime(So,u,d,r,K,N,MC)
% 
% calcule la prime de l'option donne par payoff
% 
	p=(1+r-d)/(u-d);
	Y=rand(MC,N);
	l=(Y<p); Y(l)=u; Y(~l)=d;
	S= So*prod(Y,2);
	S=payoff(S,K);
	X=mean(S)/(1+r)^N;
end

function C=prixoption(x,u,d,r,K,N,n,MC)
%
% calcule le prix de l'option à l'instant n si Sn=x
%
    p=(1+r-d)/(u-d);
	Y=rand(MC,N-n);
	l=(Y<p); Y(l)=u; Y(~l)=d;
	S= x*prod(Y,2);
	S=payoff(S,K);
	C=mean(S)/(1+r)^(N-n);
end
	
function c=odt(S,u,d,r,K,N,MC)
% 
% simule la valeur de l'option donne par la fonction payoff
% relative a la trajectoire des prix S.
%	
	p=(1+r-d)/(u-d);
	Y=rand(MC,N);
	l=(Y<p); Y(l)=u; Y(~l)=d;
	Y=cumprod(Y,2);
	l=[N:-1:1]; R=S(l); 
	R= Y*diag(R); 
	R=payoff(R,K);
	c=mean(R,1); l=[1:N]; l=(1+r).^l; c=c./l; 
	c=[payoff(S(N+1),K),c];	l=[N+1:-1:1]; c=c(l); 
end
	

function [S,C,V,psi]=crrcomplet(So,u,d,r,p,K,N,MC)
% 
% simule une trajectoire des prix a partir de So et p
% simule la valeur de l'option donne par la fonction payoff K
% simule la strategie de couverture
% compare le portefeuille a la valeur de l'option
%	
	S=action(So,u,d,p,N);
	l=[1:N+1]; R=(1+r).^(l-1); St=S./R;
	C=odt(S,u,d,r,K,N,MC);
	l=[1:N]; Sp= S(l)*u; Sm=S(l)*d;
	Sp=[100,Sp]; Sm=[0,Sm]; 
	psi = (odt(Sp,u,d,r,K,N,MC)-odt(Sm,u,d,r,K,N,MC))./(Sp-Sm);
	l=[2:N+1]; psi=psi(l);
	deltaSt=St(l)-St(l-1);
	deltaVt=psi.*deltaSt;
	Vt=cumsum(deltaVt);  Vt=C(1)+[0,Vt];  V=Vt.*R;
end
	

function [C,Ct,psi,psit,V]=valid(So,h,b,r,p,K,N,MC)
% 
% ceci est un test avec l'option (SN-K).^2
% 
[S,C,V,psi]=crrcomplet(So,u,d,r,p,K,N,MC);
% 
p=(1+r-d)/(u-d);
%
X=prime(So,u,d,r,K,N,MC);
Xt=So*So*(u^2*p+d^2*(1-p))^N -2*K*So*(1+r)^N + K^2;
Xt=Xt/(1+r)^N;
disp([X,Xt]);
%
l=[N:-1:0];
Ct=S.*S.*(u^2*p+d^2*(1-p)).^l -2*K*S.*(1+r).^l + K^2;
Ct=Ct./(1+r).^l;
l=[1:N]; Sp= S(l)*u; Sm=S(l)*d; Sp=[100,Sp]; Sm=[0,Sm];
l=[N:-1:0];
Cm=Sm.*Sm.*(u^2*p+d^2*(1-p)).^l -2*K*Sm.*(1+r).^l + K.^2;
Cp=Sp.*Sp.*(u^2*p+d^2*(1-p)).^l -2*K*Sp.*(1+r).^l + K.^2;
psit=(Cp-Cm)./(Sp-Sm); psit=psit./(1+r).^l;
l=[2:N+1]; psit=psit(l);
end



function [S,C,V,psi]=bs(T,So,mu,sigma,r,K,N,MC)
p=.5;
rd=r*T/N;
mud=mu*T/N;
sigmad=sigma*sqrt(T)/sqrt(N);
u=1+mud+sigmad; d=1-mud-sigmad;
[S,C,V,psi]=crrcomplet(So,u,d,rd,p,K,N,MC);
end





		
