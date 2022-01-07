function [w_bcyz,eta] = primalSDP(p_abcxyz,Aax,dA)
% dA = [dAi dAo]
% Aax in Ai Ao, Aax(:,:,x,a)
% p_abcxyz(a,b,c,x,y,z)

% w_bcyz in Ai Ao, w_bcyz(:,:,b,c,y,z)

dAi = dA(1);
dAo = dA(2);

OA = size(p_abcxyz,1);
OB = size(p_abcxyz,2);
OC = size(p_abcxyz,3);
IA = size(p_abcxyz,4);
IB = size(p_abcxyz,5);
IC = size(p_abcxyz,6);


yalmip('clear');


w_bcyz_ABC = sdpvar(dAi*dAo,dAi*dAo,IB,IC,OB,OC,'hermitian','complex');
w_bcyz_BAC = sdpvar(dAi*dAo,dAi*dAo,IB,IC,OB,OC,'hermitian','complex');
sdpvar eta

F = [];

for y=1:IB
    for z=1:IC
        F = F + [sum(sum(w_bcyz_ABC(:,:,y,z,:,:),6),5)==kron(PartialTrace(sum(sum(w_bcyz_ABC(:,:,y,z,:,:),6),5),2,[dAi dAo]),eye(dAo)/dAo)];
        F = F + [sum(sum(w_bcyz_BAC(:,:,y,z,:,:),6),5)==kron(PartialTrace(sum(sum(w_bcyz_BAC(:,:,y,z,:,:),6),5),2,[dAi dAo]),eye(dAo)/dAo)];
        for zz=1:IC
            if z~=zz
                for b=1:OB
                    F = F + [sum(w_bcyz_ABC(:,:,y,z,b,:),6)==sum(w_bcyz_ABC(:,:,y,zz,b,:),6)];
                    F = F + [sum(w_bcyz_BAC(:,:,y,z,b,:),6)==sum(w_bcyz_BAC(:,:,y,zz,b,:),6)];
                end
                for yy=1:IB
                    if y~=yy
                        F = F + [sum(sum(w_bcyz_ABC(:,:,y,z,:,:),6),5)==sum(sum(w_bcyz_ABC(:,:,yy,zz,:,:),6),5)];
                        F = F + [trace(sum(sum(w_bcyz_ABC(:,:,y,z,:,:),6),5))==trace(sum(sum(w_bcyz_ABC(:,:,yy,zz,:,:),6),5))];
                        F = F + [trace(sum(sum(w_bcyz_BAC(:,:,y,z,:,:),6),5))==trace(sum(sum(w_bcyz_BAC(:,:,yy,zz,:,:),6),5))];
                    end
                end
            end
        end
        for b=1:OB
            F = F + [sum(w_bcyz_BAC(:,:,y,z,b,:),6)==kron(PartialTrace(sum(w_bcyz_BAC(:,:,y,z,b,:),6),2,[dAi dAo]),eye(dAo)/dAo)];
            for c=1:OC
                F = F + [w_bcyz_ABC(:,:,y,z,b,c)>=0,w_bcyz_BAC(:,:,y,z,b,c)>=0];
                for x=1:IA
                    for a=1:OA
                        F = F + [eta*p_abcxyz(a,b,c,x,y,z)+(1-eta)/(OA*OB*OC)==trace(Aax(:,:,x,a)*(w_bcyz_ABC(:,:,y,z,b,c)+w_bcyz_BAC(:,:,y,z,b,c)))];
                    end
                end
            end
        end
    end
end

flag = solvesdp(F,-eta,sdpsettings('solver','mosek','verbose',0))


w_bcyz = zeros(dAi,dAo,OB,OC,IB,IC);
for y=1:IB
    for z=1:IC
        for b=1:OB
            for c=1:OC
                w_bcyz(:,:,y,z,b,c) = double(w_bcyz_ABC(:,:,y,z,b,c)+w_bcyz_BAC(:,:,y,z,b,c));
            end
        end
    end
end

eta = double(eta);
