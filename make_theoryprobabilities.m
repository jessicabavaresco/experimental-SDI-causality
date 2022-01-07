function p_abcxyz = make_theoryprobabilities(SWITCH,Aax,Bby,Mcz)
% SWITCH in Ai Ao Bi Bo Ct Cc

% Aax in Ai Ao, Aax(:,:,x,a)
% Bby in Bi Bo, Bby(:,:,y,b)
% Mcz in Ct Cc, Mcz(:,:,z,c)

% p_abcxyz(a,b,c,x,y,z)

OA  = size(Aax,4);
OB  = size(Bby,4);
OC  = size(Mcz,4);
IA  = size(Aax,3);
IB  = size(Bby,3);
IC  = size(Mcz,3);

p_abcxyz = zeros(OA,OB,OC,IA,IB,IC);

for x=1:IA
    for y=1:IB
        for z=1:IC
            for a=1:OA
                for b=1:OB
                    for c=1:OC
                        p_abcxyz(a,b,c,x,y,z) = trace(Tensor(Aax(:,:,x,a),Bby(:,:,y,b),Mcz(:,:,z,c))*SWITCH);
                    end
                end
            end
        end
    end
end