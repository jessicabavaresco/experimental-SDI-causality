function S = evaluate_S(p_abcxyz,alpha_abcxyz)
% p_abcxyz(a,b,c,x,y,z)
% alpha_abcxyz(a,b,c,x,y,z)

OA  = size(p_abcxyz,1);
OB  = size(p_abcxyz,2);
OC  = size(p_abcxyz,3);
IA  = size(p_abcxyz,4);
IB  = size(p_abcxyz,5);
IC  = size(p_abcxyz,6);

S = 0;
for b=1:OB
    for y=1:IB
        for c=1:OC
            for z=1:IC
                for x=1:IA
                    for a=1:OA
                        S = S + p_abcxyz(a,b,c,x,y,z)*alpha_abcxyz(a,b,c,x,y,z);
                    end
                end
            end
        end
    end
end