 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%                                           %%
 %% File: QuadrantQR.m                        %%
 %%                                           %%
 %% Author: Michael R. Spink                  %%
 %% Author: Manuel Lopez                      %%
 %%                                           %%
 %% This file computes the number of QR's     %%
 %%   in each quadrant and graphs them        %%
 %%   in an effor to illustrate frontloading  %%
 %%                                           %%
 %%  input p, a prime to work with (Z_p)      %%               
 %%                                           %%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function []=PercentageSQ(p)
clc
close all
syms x y
n=(p-1)/4;
Q1Count=1; %determine counts
Q2Count=0;
Q1SQCount=0;
Q2SQCount=0;
QR1s=[]; %list of qr's
SQ1=[1 p-1];
QR2s=[];
SQ2=[];
QR1half=[1];
SQ1half=[];
QR2half=[];
SQ2half=[];
i=2;
while i<=2*n
   [status]=Algo(p,i); %compute if QR
   if status ~=0
       if i<(n+1) %determine Q1 or Q2
           Q1Count=Q1Count+1; %increment
           if(sqrt(i) ~= floor(sqrt(i)))
              QR1half=[QR1half i]; %add
              QR1s=[QR1s i p-i];
           end
       else
           Q2Count=Q2Count+1; %increment
           if(sqrt(i) ~= floor(sqrt(i)))
              QR2half=[QR2half i]; %add
              QR2s=[QR2s i,p-i];
           end
       end
   end
   i=i+1;
end
i=1;
while(i^2<=p-1)
    disp('SQUARE')
    disp(num2str(i^2))
    if i^2<n+1 
      temp=p-i^2;
      Q1SQCount=Q1SQCount+1;
      SQ1=[SQ1 i^2 temp];
      SQ1half=[SQ1half i^2];
    elseif i^2< 2*n+1 
      temp=p-i^2;
      Q2SQCount=Q2SQCount+1;
      SQ2=[SQ2 i^2 temp];
      SQ2half=[SQ2half i^2]; 
    elseif i^2<3*n+1 
        temp=p-i^2;
      if sqrt(temp)~=floor(sqrt(temp))
        Q2SQCount=Q2SQCount+1;
      end
      SQ2=[SQ2 i^2 p-i^2];
      SQ2half=[SQ2half p-i^2]; 
    elseif i^2>3*n    
        temp=p-i^2;
       if  sqrt(temp)~=floor(sqrt(temp))
            Q1SQCount=Q1SQCount+1;
       end
       SQ1=[SQ1 i^2 temp];
       SQ1half=[SQ1half temp];
    end
    i=i+1;
end
disp(SQ1half)
%do the graphing
Y1=zeros(length(QR1s),1);
Y1SQ=zeros(length(SQ1),1);
Y2=zeros(length(QR2s),1);
Y2SQ=zeros(length(SQ2),1);
Y1half=zeros(length(QR1half),1);
Y1SQhalf=zeros(length(SQ1half),1);
Y2half=zeros(length(QR2half),1);
Y2SQhalf=zeros(length(SQ2half),1);


figure;
scatter(QR1half,Y1half,'b')
hold on
scatter(SQ1half, Y1SQhalf, 'g')
hold on
scatter(QR2half,Y2half,'r')
hold on 
scatter(SQ2half, Y2SQhalf, 'g')
hold on 
line([n n], [-0.01 0.01])
hold on
line([0,2*n], [0,0])
hold off


figure;
scatter(QR1s,Y1,'b')
hold on
scatter(SQ1, Y1SQ, 'g')
hold on
scatter(QR2s,Y2,'r')
hold on 
scatter(SQ2, Y2SQ, 'g')
hold on
line([n n], [-0.01 0.01])
hold on
line([2*n 2*n], [-0.01 0.01])
hold on
line([3*n 3*n], [-0.01 0.01])
hold on
line([0,4*n], [0,0])
hold off

X=['QR Q1 COUNT: ',num2str(Q1Count),' QR Q2 COUNT: ',num2str(Q2Count),...
    ' QR Q3 COUNT: ',num2str(Q2Count),' QR Q4 COUNT: ',num2str(Q1Count)];
Y=['SQ Q1 COUNT: ',num2str(Q1SQCount),' SQ Q2 COUNT: ',num2str(Q2SQCount)...
    ,' SQ Q3 COUNT: ',num2str(Q2SQCount),' SQ Q4 COUNT: ',num2str(Q1SQCount)];
Z=['SQ Q1 PERCENT: ',num2str(Q1SQCount/Q1Count),...
    ' SQ Q2 COUNT: ',num2str(Q2SQCount/Q2Count) ];
disp(X)
disp(Y)
disp(Z)
