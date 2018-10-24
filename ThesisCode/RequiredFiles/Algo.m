
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%                                           %%
 %% File: Algo.m                              %%
 %% Internal Filename: algov11.m              %%
 %%                                           %%
 %% Author: Michael R. Spink                  %%
 %% Author: Manuel Lopez                      %%
 %%                                           %%
 %% This file runs the algorithm we developed %%
 %% WITH careful square selection             %%
 %%                                           %%
 %%  input p, a prime to work with (Z_p)      %%
 %%  input c, a value in Z_p for the program  %%
 %%           to find its square root,        %%
 %%           if it exists                    %% 
 %%                                           %%
 %%  output root, one of two square roots,    %%
 %%              0 if NR                      %%
 %%                                           %%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
 function root =Algo(p,C) 

 %%%%%%%%%%%%%%%%% INITIALIZE VALUES %%%%%%%%%%%%%%%%
 n=(p-1)/4; % compute n, p=4n+1
 curr=C; %set current value
 %%%%%%%%%%%%%%% PREPROCESSING %%%%%%%%%%%%%%%%%%%%%
 %write p-1=Q*2^s
 Q=p-1; 
 s=0; 
 while mod(Q,2)==0
    Q=Q/2;
    s=s+1;
 end
 tempcurrq=SquareAndMultiply(curr,(Q-1)/2,p); %compute ans if in path 1/2
 currq=mod(tempcurrq^2*curr,p);%% curr Curr^Q
 twopow=1; % power of two currenrtly at
 
 %% COMPUTE IF LIFE IN THE FAST LANE
 if currq==1 % curr^odd=1  // PATH ONE
     [root,~,~]=ExtendedGCD(tempcurrq,p); % compute root
     root=mod(root,p);
     return
 elseif currq==p-1 %curr^odd =-1 // PATH TWO
     if mod(p,4)==3
         root=0;
         return
     end
     [root,~,~]=ExtendedGCD(tempcurrq,p); 
     root=mod(root*SquareRootOfMinusOne(p),p);
     return
 else %life is hard
     if mod(p,8)==5
        root=0;
        return
     end
     rootminusone=currq; %sqrt(-1) is two iterations back
     previous=currq;
     while(twopow<s) 
         currq=mod(currq^2,p); %repeated squaring
         if currq==1 %if QR
             break; 
         end
         rootminusone=previous; %update values if QR
         previous=currq; 
         twopow=twopow+1;
     end
     if currq ==p-1 % IF NR, PRINT RESULTS
        root=0;
        return
     end      
 end
 %% END PREPROCESSING %%%%%%%%%%%%%
 
 %%%%%%%% REPEATED MULTIPLICATION %%%%%%%%%%%%%%%%%%%%%%%%%%
     %% INITALIZE VALUES FOR MULTIPLICATION
 chi=C; %value that we are currently at
 kappa=1; %compute number of sign switches
 psi=1; %compute multiple 
 %create previous visited list
 prev = containers.Map('KeyType','int32','ValueType','int32'); 
 prev(chi)=1; %% visit curr
 hashnum=2; %to try to speed up lookup
 while true  % MAIN ALGO LOOP 
    if floor(sqrt(chi))==sqrt(chi) %check if integer square
        break; %WE'RE DONE HERE
    end
    temp=p-chi;
    if floor(sqrt(temp))==sqrt(temp) %check if negative is integer square
       chi=p-chi; %FLIP
       kappa=kappa*-1; %UPDATE
       break; %WE'RE DONE HERE
    end
    if chi>2*n % FLIP IF IN Q3,Q4
        chi=p-chi; 
        kappa=kappa*-1; 
    end
    %% DETERMINE VALUE TO MULTIPLY BY
    pmult=1; %what target are we aiming for?
    while(true)  
        sq=(round(sqrt((pmult*p)/chi)))^2; %compute possible square
        temp=mod(sq*chi,p); %compute temp
          %check if we've been here before
        if temp>3*n|| temp<=n
            if isKey(prev,temp)==0 && isKey(prev,p-temp)==0
               break
            end
        end
        % other wise update to next target and increment
        pmult=pmult+1;
    end
    chi=temp;% determine next value
    if(chi>2*n) %flip if need be
       chi=p-chi;
       kappa=kappa*-1;
    end
    psi=mod(psi*sqrt(sq),p);  %update
    prev(chi)=hashnum; %update previously visited values
    hashnum=hashnum+1;
 end
 if kappa==1
     rootminusone=1;
 end
 [inv,~,~]=ExtendedGCD(psi,p); %compute multiplicative inv
 inv=mod(inv,p); %invert
 root=mod(inv*kappa*sqrt(chi)*rootminusone,p);  %compute root
 return
 
 %%% EOF
 