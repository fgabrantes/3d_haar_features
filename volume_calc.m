function resul=volume_calc(int_vol, pos, desc)
% resul = volume_calc(int_vol, pos, desc)
% Evaluates integral volume


%Calculo dos pontos
A=pos+desc(2:4,1)'-1;
B=A+[0,         0,         desc(7,1)]-[1,1,0];
C=A+[0,         desc(6,1), 0]        -[1,0,1];
D=A+[0,         desc(6,1), desc(7,1)]-[1,0,0];
E=A+[desc(5,1), 0,         0]        -[0,1,1];
F=A+[desc(5,1), 0,         desc(7,1)]-[0,1,0];
G=A+[desc(5,1), desc(6,1), 0]        -[0,0,1];
H=A+[desc(5,1), desc(6,1), desc(7,1)];

A=A-1;

%Quando A=[x,x,x]
if (A(1)~=0 && A(2)~=0 && A(3)~=0)
    resul=desc(1,1)*(int_vol(H(1), H(2), H(3))-int_vol(D(1), D(2), D(3))...
        -int_vol(F(1), F(2), F(3))-int_vol(G(1), G(2), G(3))+int_vol(B(1), B(2), B(3))...
        +int_vol(C(1), C(2), C(3))+int_vol(E(1), E(2), E(3))-int_vol(A(1), A(2), A(3)));
%Quando A=[1,x,x]
elseif (A(1)==0 && A(2)~=0 && A(3)~=0)    
    resul=(int_vol(H(1), H(2), H(3))-int_vol(F(1), F(2), F(3))...
        -int_vol(G(1), G(2), G(3))+int_vol(E(1), E(2), E(3)))*desc(1,1);
%Quando A=[x,1,x]
elseif (A(1)~=0 && A(2)==0 && A(3)~=0)
    resul=desc(1,1)*(int_vol(H(1), H(2), H(3))-int_vol(G(1), G(2), G(3))...
        -int_vol(D(1), D(2), D(3))+int_vol(C(1), C(2), C(3)));
%Quando A=[x,x,1]
elseif (A(1)~=0 && A(2)~=0 && A(3)==0)
    resul=desc(1,1)*(int_vol(H(1), H(2), H(3))-int_vol(D(1), D(2), D(3))...
        -int_vol(F(1), F(2), F(3))+int_vol(B(1), B(2), B(3)));
%Quando A=[1,x,1]
elseif (A(1)==0 && A(2)~=0 && A(3)==0)
    resul=desc(1,1)*(int_vol(H(1), H(2), H(3))-int_vol(F(1), F(2), F(3)));
%Quando A=[1,1,x]
elseif (A(1)==0 && A(2)==0 && A(3)~=0)
    resul=desc(1,1)*(int_vol(H(1), H(2), H(3))-int_vol(G(1), G(2), G(3)));
%Quando A=[x,1,1]
elseif (A(1)~=0 && A(2)==0 && A(3)==0)
    resul=desc(1,1)*(int_vol(H(1), H(2), H(3))-int_vol(D(1), D(2), D(3)));
%Quando A=[1,1,1]
else
    resul=desc(1,1)*int_vol(H(1), H(2), H(3));
end
    
    