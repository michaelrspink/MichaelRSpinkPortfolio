
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                           %%
%% File: extendedGCD.m                       %%
%%                                           %%
%% Author: Michael R. Spink                  %%
%%                                           %%
%% This file computes the gcd of two         %%
%%  positive integers using a matrix method  %%
%%  to reduce workload on myself and         %%
%%  potentially runtime if I have            %%
%%  implemented this well in the time that   %%
%%   I have. Written for CS462               %%
%%                                           %%
%% INPUTS:                                   %%
%%   @input a                                %%
%%           a is any positive integer       %%
%%   @input b                                %%
%%           b is any positive integer       %%
%%                                           %%
%%   Preconditions:                          %%
%%         ideally you want a>b, though      %%
%%          this should be fine otherwise    %%
%%          I have not tested this though    %%
%%                                           %%
%%   Returns:                                %%
%%     @return d                             %%
%%             d=gcd(a,b)>0 by assumption    %%
%%     @return s                             %%
%%          s=integer associated with a      %%
%%     @return t                             %%
%%          t=integer associated with b      %%
%%       NOTE: d=sa+tb                       %%
%%                                           %%
%%                                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function[s,t,d] = ExtendedGCD(a,b)
A=zeros(2,3);  %% INITIALIZE MATRIX
%% SET INITIAL VALUES OF MATRIX
A(1,1)=a;
A(2,1)=b;
A(1,2)=1;
A(2,3)=1;
%%
while(A(2,1)~=0 &&A(1,1)~=0)  %% MAIN LOOP; while recursion can occur;
    %%% sanity check to reduce runtime
    if(A(2,1)==A(1,1)) 
         %%% SET APPROPRIATE VALUES
        d=A(2,1);
        s=A(2,2);
        t=A(2,3);
        return; %% RETURN TO BASE
    end
    if(A(2,1)<A(1,1)) %% CHECK WHICH VALUE IN MATRIX IS BIGGER
          q=floor(A(1,1)/A(2,1)); %% COMPUTE q in division algo; a=bq+r
          A(1,1)=mod(A(1,1),A(2,1)); %% ``CHEAT'' to compute r; 
                                     %%; this is in pseudocode given
          A(1,2)=A(1,2)-q*A(2,2);  %% update s
          A(1,3)=A(1,3)-q*A(2,3);  %% update t
    elseif(A(2,1)==0&&A(1,1)==0) %% second sanity check to reduce runtime
        %%% but really, more like error checking
        
        %% SET VALUES
        d=A(2,1);
        s=A(2,2);
        t=A(2,3);
        return; %% RETURN TO BASE
    else             %%% (A(2,1)>A(1,1)
        q=floor(A(2,1)/A(1,1)); % compute q in division algo 
        A(2,1)=mod(A(2,1),A(1,1)); %% ``cheat to find r. Is in code given
        A(2,2)=A(2,2)-q*A(1,2);  %% update s
        A(2,3)=A(2,3)-q*A(1,3); %% update t
    end
end

if(A(1,1)==0) %% determine which row to use; use row 2 here
    %% SET VALUES
    d=A(2,1);
    s=A(2,2);
    t=A(2,3);
else  %% use row 1r
    %% SET VALUES
    d=A(1,1);
    s=A(1,2);

    t=A(1,3);
   
end

%%%%% FOR TESTING PURPOSES

 %%% EOF

