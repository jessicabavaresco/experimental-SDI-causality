function [S,alpha_abcxyz] = dualSDP(p_abcxyz,Aax,dA)
% dA = [dAi dAo]
% Aax in Ai Ao, Aax(:,:,x,a)
% p_abcxyz(a,b,c,x,y,z)

% alpha_abcxyz(a,b,c,x,y,z)

dAi = dA(1);
dAo = dA(2);

OA = size(p_abcxyz,1);
OB = size(p_abcxyz,2);
OC = size(p_abcxyz,3);
IA = size(p_abcxyz,4);
IB = size(p_abcxyz,5);
IC = size(p_abcxyz,6);


yalmip('clear');


alpha_abcxyz = sdpvar(OA,OB,OC,IA,IB,IC,'full','real');
 
h_A_yz = sdpvar(IB,IC,'full','real');
h_B_yz = sdpvar(IB,IC,'full','real');

K_A_byz = sdpvar(dAi*dAo,dAi*dAo,OB,IB,IC,'hermitian','complex');  
K_B_byz = sdpvar(dAi*dAo,dAi*dAo,OB,IB,IC,'hermitian','complex');  

J_B_byz = sdpvar(dAi*dAo,dAi*dAo,OB,IB,IC,'hermitian','complex');  

R_A_yz = sdpvar(dAi*dAo,dAi*dAo,IB,IC,'hermitian','complex');
G_A_yz = sdpvar(dAi*dAo,dAi*dAo,IB,IC,'hermitian','complex');


F = [sum(sum(h_A_yz,2),1)==0,sum(sum(h_B_yz,2),1)==0,sum(sum(R_A_yz,4),3)==0];

eta = 1;
for b=1:OB
    for y=1:IB
        F = F + [sum(K_A_byz(:,:,b,y,:),5)==0,sum(K_B_byz(:,:,b,y,:),5)==0];
        for c=1:OC
            for z=1:IC
                A = 0;
                for x=1:IA
                    for a=1:OA
                        A = A + Aax(:,:,x,a)*alpha_abcxyz(a,b,c,x,y,z);
                        eta = eta + alpha_abcxyz(a,b,c,x,y,z)*p_abcxyz(a,b,c,x,y,z);
                    end
                end
                F = F + [A-h_A_yz(y,z)*eye(dAi*dAo)-K_A_byz(:,:,b,y,z)-G_A_yz(:,:,y,z)+kron(PartialTrace(G_A_yz(:,:,y,z),2,[dAi dAo]),eye(dAo)/dAo)-R_A_yz(:,:,y,z)>=0];
                F = F + [A-h_B_yz(y,z)*eye(dAi*dAo)-K_B_byz(:,:,b,y,z)-J_B_byz(:,:,b,y,z)+kron(PartialTrace(J_B_byz(:,:,b,y,z),2,[dAi dAo]),eye(dAo)/dAo)>=0];
            end
        end
    end
end

F = F + [eta-(1/(OA*OB*OC))*sum(sum(sum(sum(sum(sum(alpha_abcxyz,6),5),4),3),2),1)==0];

flag = solvesdp(F,eta,sdpsettings('solver','mosek','verbose',0))

S = double(eta)-1;
alpha_abcxyz = double(alpha_abcxyz);
                        
                        
                      
