 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%                                           %%
 %% File: TestSuite.m                         %%
 %% Internal Filename: TestSuitev2.m          %%
 %%                                           %%
 %% Author: Michael R. Spink                  %%
 %% Author: Manuel Lopez                      %%
 %%                                           %%
 %% This file tests brute force and our       %%
 %%   algorithm to compare iteration counts   %%
 %%   and the time it takes these             %%
 %%   files to run                            %%
 %%                                           %%
 %%  input p, a 4n+1 prime to test            %%
 %%  input number, the number of              %%
 %%                trials to run              %%
 %%  input QROnlyTrigger, kind of test to run %%
 %%                      0- NR's only         %%
 %%                      1- QR's only         %%
 %%                      else- random mixture %%
 %%                                           %%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] =TestSuitev2(p,number,QROnlyTrigger)
clc
X=['RUNNING: TestSuitev2(',num2str(p),',',num2str(number),','...
    ,num2str(QROnlyTrigger),')'];
disp(X) %display what user inputted. 
disp('--------------------------------')
wrong=0; %number of wrong answers
answers=[]; %array of answers to be compared against
wrongseeds=[]; %wrong answers
trials=0; %number of trials. 
ar=randperm(p-1,number); %choose number random integers on [1,p-1]
disp('BRUTE FORCE') %run brute force
for i=1:numel(ar)
    C=ar(i);
    if QROnlyTrigger==0 %ensure NR
       while SquareAndMultiply(C,(p-1)/2,p)==1
           C=mod(C+1,p);
       end
    end %ensure QR
    if QROnlyTrigger==1
        C=mod(C^2,p);
    end
    elm=BruteForcev2(p,C);
    if elm==0
        W=[num2str(C),' is an NR (mod ',num2str(p),').'];
        disp(W)
    else
        W=[num2str(elm),'^2=',num2str(C),'(mod ',num2str(p),').'];
        disp(W)
    end
    answers=[answers, elm];
end
disp('-----------------------------------')
disp('ALGORITHM RESULTS')
for i=1:numel(ar)
    C=ar(i);
    if QROnlyTrigger==0
       while SquareAndMultiply(C,(p-1)/2,p)==1
           C=C+1;
       end
    end
    if QROnlyTrigger==1
        C=mod(C^2,p);
    elseif QROnlyTrigger==0 
        if answers(i)~=0
            continue
        end
    end
    elm=Algo(p,C);
    if elm==0
        W=[num2str(C),' is an NR (mod ',num2str(p),').'];
        disp(W)
    else
        W=[num2str(elm),'^2=',num2str(C),'(mod ',num2str(p),').'];
        disp(W)
    end
    if elm~= answers(i) && p-elm ~=answers(i)
        wrong=wrong+1;
        wrongseeds=[wrongseeds, ar(i),p-ar(i)];
    end
    trials=trials+1;
end
%Report results 
disp('')
disp('--------------------------------')
disp('')
if QROnlyTrigger==1
   X=['QR ONLY TEST MOD ', num2str(p)];
   disp(X)
elseif QROnlyTrigger==0
   X=['NR ONLY TEST MOD ', num2str(p)];
   disp(X)
else
    X=['RANDOM TEST MOD ', num2str(p), ', QR/NR AREs MIXED'];
    disp(X)
end
W=['NUMBER OF TRIALS: ', num2str(trials)];
disp(W)
Z=['NUMBER OF WRONG ANSWERS: ',num2str(wrong), '. THEY ARE: '];
disp(Z)
disp(wrongseeds)
disp('SEE MATLAB''S RUN AND TIME FUNCTION FOR RUNTIME STATS')
%%%% EOF
