 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%                                           %%
 %% File: LeastNR.m                           %%
 %%                                           %%
 %% Author: Michael R. Spink                  %%
 %% Author: Manuel Lopez                      %%
 %%                                           %%
 %% This file computes the least NR for a     %%
 %%  given prime p                            %%
 %%                                           %%
 %%  input p, a prime to work with (Z_p)      %%               
 %%                                           %%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function least=LeastNR(p)

least=2; 
while least<p
   if SquareAndMultiply(least,(p-1)/2,p)==p-1
        return
   end
   least=least+1;
end

    
    