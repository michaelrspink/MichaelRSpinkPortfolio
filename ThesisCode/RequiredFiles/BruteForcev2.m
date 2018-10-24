 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%                                           %%
 %% File: BruteForce.m                        %%
 %% Internal Filename: BruteForcev2.m         %%
 %%                                           %%
 %% Author: Michael R. Spink                  %%
 %% Author: Manuel Lopez                      %%
 %%                                           %%
 %% This file brute forces the square root    %%
 %% problem for given values                  %%
 %%                                           %%
 %%  input p, a prime to work with (Z_p)      %%
 %%  input c, a value in Z_p for the program  %%
 %%           to find its square root,        %%
 %%           if it exists                    %%
 %%                                           %%
 %%  output root, one of two square roots,    %%
 %%             0 if NR                       %%
 %%                                           %%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 function root = BruteForcev2(p,c)
 %Was going to exclude c=1, root=1, but it's faster this way somehow
 A=randperm((p-1)/2,(p-1)/2); %randomize elements in Z_p                         
 for root=A %pick element
        temp=root; %create temporary 
        temp=mod(temp^2,p); %square and mod
        if temp==c %check if winner
            return
        end   
 end
 root=0; %is NR, report as such
 return

 %%%% EOF
