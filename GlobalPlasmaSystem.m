function F = GlobalPlasmaSystem(x,Act,B,expNo)
global massIon %ion mass
global kb %boltzmann constant
global q %electron charge
global T %temperature of system (treat constant)
global V %volume
global K %this is equal to k7 in Efremov study
global k9
global A
global L
global sigma
global R
global expParameters
%Constants
%PrevX = MakeDimensional(x,i);

Te = expParameters(expNo,7);

k7_nond = 5e-8;
k1 = 3e-10/k7_nond;
k2 = 2.1e-12/k7_nond;
k3 = 1.5e-10/k7_nond;
k4 = 3e-9/k7_nond;
k5 = 1e-10/k7_nond;
k6 = 2e-11/k7_nond;
k8 = k2;
k = CalculateRates(Act,B,Te);
% assignin('base', 'k', k*k7_nond);
% k1 = k(1);
% k2 = k(2);
% k3 = k(3);
% k4 = k(4);
% k5 = k(5);
% k6 = k(6);
% k8 = k(7);

%Define experimental parameters (with units)
P = expParameters(expNo,1); %Pa
flowRate = expParameters(expNo,2)/(100^3)/60; %m^3/min converted from sccm
tau = V/flowRate; %residence time (s)
delta = expParameters(expNo,5);
n0 = P/(kb*T);%initial neutral density
Picp = expParameters(expNo,3);
Prf = expParameters(expNo,4);
W = Picp + Prf;
W/(massIon/q*(K*n0*.08)^2*n0*A)
%Make parameters dimensionless 
k9 = k9/(K*n0);
tau = tau*(K*n0);
%Functions
F=[
2*(k4 + k3)*x(4) * x(1) - (k9+1/tau)*x(2); %1, (2*k4+k3)*ne*nCl2-(k9+1/tau)nCl
x(1)-(1-delta) + 0.5*x(2); %2, nCl2-(1-delta) + 0.5*nCl 
x(3)- delta;%3,%nAr- n0*delta
(k2+k3)*x(1)*x(4)-(x(7)+x(8)+x(6))*x(5)-k8*x(5)*x(4); %4, (k3+k3)*nCl2*ne-(nCl_pos+nAr_pos+nCl2_pos)*nCl_neg-k8*nCl_neg*ne 
k1*x(1)*x(4)-(x(14)/x(13) + x(5))*x(6); % 5, k1*nCl2*ne-(v/dc + nCl-)*nCl2+
(k5*x(2)+k2*x(1))*x(4)-(x(14)/x(13) + x(5))*(x(7));%6 (k5*nCl+k2*nCl2)*ne-(v/dc+nCl_neg)*nCl_pos
k6*x(3)*x(4)-(x(14)/x(13)+ x(5))*x(8); %7 x(7, k6*nAr*ne-(v/dc  + k7*nCl_neg)*nAr_pos 
x(5)+x(4)-x(6)-x(7)-x(8); %8 nCl_neg+ne-nCl2_pos+nCl_pos+nAr_pos
x(14) - sqrt(x(9))*sqrt(1+(x(11))/(1+(x(11)*x(12))));%9, v- sqrt((1+BetaS)/(1+BetaS*gamma_T))*sqrt(T)
x(10)-x(5)/x(4); %10 beta-nCl_neg/ne
x(10) - x(11)*exp((1+x(11))*(x(12)-1)/(2*(1+x(11)*x(12))));%11, Beta - BetaS*exp((1+BetaS)*(gamma_T-1)/(2*(1+BetaS*gamma_T)))
2*(k1*x(1)+k5*x(2)+k6*x(3))+(k2-k3)*x(1)-(1+x(10))*(2*(x(14)+x(10)*x(4)))+k8*x(4)*x(10);%12;%17, 2*(k1*nCl2+k5*nCl+k6*nAr)+(k3-k3)*nCl2-(1+Beta)*(2*v/dc+k7*Beta*ne)+k8*ne*Beta
x(13)-1; %13 dc-1
W/(massIon/q*(K*n0*x(13))^2*n0*A)-x(14)*7*x(9)*(x(6)+x(7)+x(8));%14 W-v*7Te(nCl2_pos+nCl_pos+nAr_pos)
x(15)-x(16)/(L*sigma*n0)*sqrt(x(9)/x(12)/2)*(1+x(12)+2*x(12)*x(10))/(1+x(10)*x(12))
x(16)-1;
x(17)-0.86/sqrt(3+L*sigma*n0/(x(16)*2)+(.86*x(14)/(pi*x(12)*x(15)))^2);
x(18)-0.8/sqrt(4+R*sigma*n0/x(16)+(.8*R*x(14)/(2.405*L*0.43*x(12)*x(15)))^2)];

 
% % 

end