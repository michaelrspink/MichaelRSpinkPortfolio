
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                           %%
%% File: SquareAndMultiply.m                 %%
%%                                           %%
%% Author: Michael R. Spink                  %%
%%                                           %%
%% This file runs the                        %%
%%  square and multiply algorithm (a^b mod n)%%
%%                                           %%
%%   Originally written for CS461            %%
%%                                           %%
%% INPUTS:                                   %%
%%   @input a                                %%
%%           a is any positive integer       %%
%%   @input b                                %%
%%          b is any positive integer (exp)  %%
%%   @input n                                %%
%%           n is any positive integer (mod) %%
%%                                           %%
%%   Returns:                                %%
%%     @return a                             %%
%%             a=  result of algo            %%
%%                                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function a = SquareAndMultiply(a,b,n)
b=dec2bin(b); %convert to binary
len=length(b);
orig=a;
i=2;
while(i<len+1)
    a=mod((a^2),n);
    currbit=str2double(b(i)); %USE IF NOT ON R2018a or cannot use mex
    %currbit=str2doubleq(b(i)); %See thesis.pdf when it is up at RIT
    if(currbit == 1)
        a=mod((a*orig),n);
    end
    i=i+1;
end 

%%%%%%%%%%%%% EOF
