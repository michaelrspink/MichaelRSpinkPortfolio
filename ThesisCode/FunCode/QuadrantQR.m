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
 %%  input trigger, if you want a graph       %%
 %%         of all of the QR's mod p          %%
 %%                                           %%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [rho,xi]=QuadrantQR(p,trigger)
clc
close all
syms x y
n=(p-1)/4;
Q1Count=0; %determine counts
Q2Count=0;
Q3Count=0;
Q4Count=0;
QR1s=[]; %list of qr's
QR2s=[];
QR1half=[];
QR2half=[];
i=1;
while i<=2*n
   status=Algo(p,i); %compute if QR
   if status ~=0
       if i<(n+1) %determine Q1 or Q2
           Q1Count=Q1Count+1; %increment
           Q4Count=Q4Count+1;
           QR1half=[QR1half i]; %add
           QR1s=[QR1s i p-i];
       else
           Q2Count=Q2Count+1; %increment
           Q3Count=Q3Count+1;
           QR2half=[QR2half i]; %add
           QR2s=[QR2s i,p-i];

       end
   end
   i=i+1;
end
if trigger==1
    %do the graphing
    Y1=zeros(length(QR1s),1);
    Y2=zeros(length(QR2s),1);
    Y1half=zeros(length(QR1half),1);
    Y2half=zeros(length(QR2half),1);
    figure;
    scatter(QR1half,Y1half,'b')
    hold on
    scatter(QR2half,Y2half,'r')
    hold on 
    line([n n], [-0.01 0.01])
    hold on
    line([0,2*n], [0,0])
    hold off
    figure;
    scatter(QR1s,Y1,'b')
    hold on
    scatter(QR2s,Y2,'r')
    line([n n], [-0.01 0.01])
    hold on
    line([2*n 2*n], [-0.01 0.01])
    hold on
    line([3*n 3*n], [-0.01 0.01])
    hold on
    line([0,4*n], [0,0])
    hold off
    %disp(QR1half)
end
X=['RUNNING: QUADRANTQR(',num2str(p),')'];
disp(X)
X=['Q1 COUNT: ',num2str(Q1Count),' Q2 COUNT: ',num2str(Q2Count),' Q3 COUNT: ',num2str(Q3Count),' Q4 COUNT: ',num2str(Q4Count)];
disp(X)
rho=Q2Count/Q1Count;
xi=Q1Count-Q2Count;
