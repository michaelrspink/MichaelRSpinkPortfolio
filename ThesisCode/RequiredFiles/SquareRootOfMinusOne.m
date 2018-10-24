
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                           %%
%% File: SquareRootOfMinusOne.m              %%
%%                                           %%
%% Author: Michael R. Spink                  %%
%%                                           %%
%% This file computes the square root of     %%
%% -1 modulo a given 4n+1 prime              %%
%%                                           %%
%% INPUTS:                                   %%
%%   @input p                                %%
%%           a is any 4n+1 prime             %%
%%                                           %%
%%   Returns:                                %%
%%     @return rootminusone                  %%
%%             a=  sqrt(-1) (mod p)          %%
%%                                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function rootminusone=SquareRootOfMinusOne(p)
x=1;
y=1;
z=(p-1)/4;
while(true) 
    if z+x<y
        tempx= x+2*z;
        tempy= y-z-x;
        tempz= z;
    else
        tempx= 2*y-x;
        tempy= z+x-y;
        tempz= y;
    end
    x=tempx;
    y=tempy;
    z=tempz;
    if y==z
        b=2*y;
        a=x;
        break    
    end
end
 [binv,~,~]=ExtendedGCD(mod(b,p),p);
rootminusone=mod(a*mod(binv,p),p);
return

%EOF
