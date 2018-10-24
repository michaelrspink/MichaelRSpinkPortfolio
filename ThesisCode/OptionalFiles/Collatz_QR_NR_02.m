
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%                                           %%
 %% File: Collatz_QR_NR_02.m                  %%
 %%                                           %%
 %% Author: Manuel Lopez                      %%
 %% Author: Michael R. Spink                  %%
 %%                                           %%
 %% This file tries to determine if a value   %%
 %%   is a QR or NR mod p. Better than Euler? %%
 %%                                           %%
 %%  input p, a prime to work with (Z_p)      %%
 %%  input C, a value in Z_p for the program  %%
 %%           to find its square root,        %%
 %%           if it exists                    %% 
 %%                                           %%
 %%  output tst, 1 if C is a QR,              %%
 %%              p-1 if NR                    %%
 %%                                           %%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
function tst =Collatz_QR_NR_02(p,C)
if C > p/2 && C < p %% IF IN Q3, Q4
  C = p-C; %FLIP
end
d = C; 
tst = p-1;
if mod(p,8)==1 % if 1 mod 8
  for i=1:(p-1)/4
     if floor(d/2)==d/2
        d = d/2;
     else
        d = (p-d)/2;
     end
     if d == C
       tst = p-1;
       break;
     elseif floor(sqrt(d))==sqrt(d)
       tst = 1;
       break;
     end
  end
elseif mod(p,8)==5
    if floor(C/2)==C/2
       e = C/2;
    else
       e = (p-C)/2;
    end
    if floor(sqrt(e))==sqrt(e)
       tst = p-1;
    end
    for i=1:(p-1)/4
       if floor(e/2)==e/2
          d = e/2;
       else
          d = (p-e)/2;
       end
       if floor(sqrt(d))==sqrt(d)
          tst = 1;
          break;
       end
       if floor(d/2)==d/2
          e = d/2;
       else
          e = (p-d)/2;
       end
       if floor(sqrt(e))==sqrt(e)
          tst = p-1;
          break;
       end
    end
end
