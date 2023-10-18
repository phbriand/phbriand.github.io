%
% Payoff de l'option
%
function pof=payoff(s,k)
% 
% pour le call
% 	
	pof=abs(s-k)+s-k;
	pof = pof/2;
end
