function f = MakeDimensional(x1,expNo)
global plasmaUnknowns
global kb
global q
global massIon
global K
global T
global R
global L
global sigma
global expParameters
%Experimental Parameters
P = expParameters(expNo,1); %Pa
n0 = P/(kb*T);
x2=zeros(plasmaUnknowns,1);

for i=1:8
    x2(i) = x1(i)*n0;
end
x2(10) = x1(10);
x2(11) = x1(11);
x2(12) = x1(12);
x2(13) = x1(13)*0.5*R*L/(R*x1(17)+L*x1(18));
T_dim = massIon/q*(K*n0*x2(13))^2;
assignin('base', 'T_dim', T_dim);
x2(9) = x1(9)*T_dim;
x2(14) = x1(14)*(K*n0*x2(13));
x2(15) = x1(15)*L*K*n0*x2(13);
x2(16) = x1(16)/(sigma*n0);
x2(17) = x1(17);
x2(18) = x1(18);
f = x2;