
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                           %%
%% File: PythagoreanDecompPrime.m            %%
%%                                           %%
%% Author: Michael R. Spink                  %%
%%                                           %%
%% This file decomposes 4n+1 primes into     %%
%%    the sum of two squares, that is        %%
%%          p=a^2+b^2                        %%
%%  see pdf for source                       %%
%%                                           %%
%% INPUTS:                                   %%
%%   @input p                                %%
%%           a is any 4n+1 prime             %%
%%                                           %%
%%   Returns:                                %%
%%     @return a= one part of the decomp     %%
%%             b= one part of the decomp     %%
%%                                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [a,b]=PythagoreanDecompPrime(p)
%initalize
x=1;
y=1;
z=(p-1)/4;

while(true) %recurse
    if z+x<y %CONDITION ONE
        tempx= x+2*z;
        tempy= y-z-x;
        tempz= z;
    else %CONDITION TWO
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
%     disp(x)
%     disp(y)
%     disp(z)
%     disp('---------')
end
a=mod(a,p);
b=mod(b,p);
%EOF