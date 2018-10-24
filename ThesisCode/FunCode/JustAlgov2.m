
 function [root,iterations] =JustAlgov2(p,C) 

 %%%%%%%%%%%%%%%%% INITIALIZE VALUES %%%%%%%%%%%%%%%%
 n=(p-1)/4; % compute n, p=4n+1
 curr=C; %set current value
 sign=1; %compute number of switches
 multiple=1; %compute multiple 
 %create previous visited list
 prev = containers.Map('KeyType','int32','ValueType','int32'); 
 prev(curr)=1; %% visit curr
 hashnum=2;
 iterations=0;
 while true  % MAIN ALGO LOOP
     %X=['CURR: ', num2str(curr),' SIGN: ', num2str(sign),' MULTIPLE: ',...
     %  num2str(multiple)];
    %disp(X)   
    if floor(sqrt(curr))==sqrt(curr) %check if integer square
        break; %WE'RE DONE HERE
    end
    temp=p-curr;
    if floor(sqrt(temp))==sqrt(temp) %check if negative is integer square
       curr=p-curr; %FLIP
       sign=sign*-1; %UPDATE
       break; %WE'RE DONE HERE
    end
    if curr>2*n % FLIP IF IN Q3,Q4
        curr=p-curr; 
        sign=sign*-1; 
    end
    %% DETERMINE VALUE TO MULTIPLY BY
    pmult=1; %what target are we aiming for?
    while(true)  
        iterations=iterations+1;
        sq=(round(sqrt((pmult*p)/curr)))^2;
        temp=mod(sq*curr,p); %compute temp
          %check if we've been here before
        if temp>3*n|| temp<=n
            if isKey(prev,temp)==0 && isKey(prev,p-temp)==0
               break
            end
        end
        % other wise update to next target and increment
        pmult=pmult+1;
    end
    curr=temp;% determine next value
    if(curr>2*n) %flip if need be
       curr=p-curr;
       sign=sign*-1;
    end
    multiple=mod(multiple*sqrt(sq),p);  %update
    prev(curr)=hashnum; %update previously visited values
    hashnum=hashnum+1;
    %X=['MULTIPLY BY ',num2str(sq)];
    %disp(X)
    iterations=iterations+1;
 end
 if sign==1
     rootminusone=1;
 else
     rootminusone=SquareRootOfMinusOne(p);
 end
 [inv,~,~]=ExtendedGCD(multiple,p); %compute multiplicative inv
 inv=mod(inv,p);
 root=mod(inv*sign*sqrt(curr)*rootminusone,p);  %compute root
 %X=['TOTAL ITERATIONS  ',num2str(iterations)];
 %disp(X)
 return