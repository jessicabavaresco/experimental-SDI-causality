function [SWITCH,Aax,Bby,Mcz] = make_theoryoperators

% dAi = 2
% dAo = 2
% dBi = 2
% dBo = 2
% dCt = 2
% dCc = 2

ket0     = [1;0];
ket1     = [0;1];
ketplus  = (1/sqrt(2))*(ket0+ket1);
ketminus = (1/sqrt(2))*(ket0-ket1);

phi = sqrt(2)*MaxEntangled(2);

target = ket0;

% SWITCH in Ai Ao Bi Bo Ct Cc
SWITCH = (1/sqrt(2))*Tensor(target,phi,phi,ket0) + (1/sqrt(2))*PermuteSystems(Tensor(target,phi,phi,ket1),[2 1 3],[4 4 4]);
SWITCH = SWITCH*SWITCH';

% Aax in Ai Ao
% Aax(:,:,x,a)
Aax(:,:,1,1) = kron(ket0*ket0',ket0*ket0');
Aax(:,:,1,2) = kron(ket1*ket1',ket1*ket1');
Aax(:,:,2,1) = kron(ketplus*ketplus',ketplus*ketplus');
Aax(:,:,2,2) = kron(ketminus*ketminus',ketminus*ketminus');

% Bby in Bi Bo
% Bby(:,:,y,b)
Bby = Aax;

% Mcz in Ct Cc
% Mcz(:,:,z,c)
Mcz(:,:,1,1) = kron(ket0*ket0', ketplus*ketplus');
Mcz(:,:,1,2) = kron(ket1*ket1', ketplus*ketplus');
Mcz(:,:,1,3) = kron(ket0*ket0', ketminus*ketminus');
Mcz(:,:,1,4) = kron(ket1*ket1', ketminus*ketminus');

Mcz(:,:,2,1) = kron(ketplus*ketplus',   ketplus*ketplus');
Mcz(:,:,2,2) = kron(ketminus*ketminus', ketplus*ketplus');
Mcz(:,:,2,3) = kron(ketplus*ketplus',   ketminus*ketminus');
Mcz(:,:,2,4) = kron(ketminus*ketminus', ketminus*ketminus');


