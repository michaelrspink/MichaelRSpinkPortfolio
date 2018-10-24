 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%                                           %%
 %% File: QRGraph.m                           %%
 %%                                           %%
 %% Author: Michael R. Spink                  %%
 %% Author: Manuel Lopez                      %%
 %%                                           %%
 %% This file graphs values of rho and xi     %%
 %% as defined in my thesis until an upper    %%
 %% bound is hit                              %%
 %%                                           %%
 %%  input upperbound highest prime to hit    %%
 %%                                           %%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
 function []=QRGraph(upperbound)
 
ps=[];
rhos=[];
xis=[];
p=17;
while p<upperbound
    if isprime(p)
        [rho,xi]=QuadrantQR(p,0);
        rhos=[rhos rho];
        ps=[ps p];
        xis=[xis xi];
    end
    p=p+4;
end
figure;
plot(ps,rhos,'b')
X=['Plot of rho for 4n+1 primes from p=17 to n=', num2str(upperbound)];
xlabel('primes')
ylabel('rho')
title(X)
figure;
X=['Plot of xi for 4n+1 primes from p=17 to n=', num2str(upperbound)];
title(X)
plot(ps,xis,'r')
xlabel('primes')
ylabel('xi')
figure;
scatter(rhos,xis,'g')
X=['Comparing xi and rho for 4n+1 primes from p=17 to n=' , num2str(upperbound)];
title(X)
ylabel('xi')
xlabel('rho')

