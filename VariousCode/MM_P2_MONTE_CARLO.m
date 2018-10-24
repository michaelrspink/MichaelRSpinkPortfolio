
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                           %%
%% File: MM_P2_MONTE_CARLO                   %%
%%                                           %%
%% Author: Michael R. Spink                  %%
%%                                           %%
%% This file runs the monte carlo            %%
%% simulations and creates the visualizations%%                                  
%% allowed to understand them well.          %%
%%                                           %%
%%  param- radius- radius for hunters        %%
%%  param- pigcounter- number of pigs        %%
%%  param- huntercount- number of hunters    %%
%%  param- trigger                           %%
%%    0 = just 3 graphs 1= all prev graphs   %%
%%    2 = just number of pigs left           %%
%%    3= number of pigs killed               %%
%%  return- number of pigs left              %%
%%                                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function pigcountcurr =MM_P2_MONTE_CARLO(radius,pigcount,huntercount, trigger) %% This function can be called with values TBD



%%%%%%%%%%%%%%%%%% CONTROLLABLE PARAMS
%% SET LENGTH
%%trigger=0; %% TEST TRIGGER
xlength=100; %% CHANGE HERE FOR DIFFERENT RESULTS
ylength=100; %% CHANGE HERE FOR DIFFERENT RESULTS
if(trigger==0)
    radius=2;   %%%%2;  %% HOW FAR CAN THE HUNTERS HUNT?
    pigcount=100; %% HOW MANY PIGS
    huntercount=100;  %% HOW MANY HUNTERS
end

%%%%%%%%%% END CONTROLLABLE PARAMS

%%%%%%%%%%%%%%%%%%%%%%%% BEGIN RANDOMIZE
%%%%%%%%%%%%%% BEGIN CREATE RANDOM PIG VALUES

pigcountcurr=pigcount; %% CREATE PIG COUNT

xcoordsp=zeros(1,pigcount);  %% X COORD PIGS
ycoordsp=zeros(1,pigcount);  % Y COORD PIGS
i=1;
while(i<=pigcount)
    xcoordsp(i)=abs(xlength*rand); % X COORD PIG RANDOMIZE
    ycoordsp(i)=abs(ylength*rand); % Y COORD PIG RANDOMIZE
    i=i+1;
end

%%%%%%%%%%%%%%%%%%%%%% END CREATE RANDOM PIG VALUES

%%%%%%%%%%%%%%%%%%%%%% END CREATE RANDOM HUNTER VALUES

xcoordsh=zeros(1,huntercount); %% X COORD HUNTER
ycoordsh=zeros(1,huntercount); %% Y COORD HUNTER
i=1;
while(i<=huntercount)
    xcoordsh(i)=abs(xlength*rand); % X COORD RANDOM
    ycoordsh(i)=abs(ylength*rand); % Y COORD RANDOM
    i=i+1;
end

%%%%%%%%%%%%%%%%%%%%%% END CREATE RANDOM HUNTER VALUES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END RANDOMIZE

%%%%%%%%%%%%%%%%%%%%%%%%%CREATE INITAL PLOTS

%%%inital scatter plot
if(trigger ==1 || trigger==0) 
    if(trigger==0)
        delete(findall(0,'Type','figure')) %% CLEAR ALL OPEN FIGURES
    end

    figure
    scatter(xcoordsp,ycoordsp, 'red')
    hold on 
    scatter(xcoordsh,ycoordsh,'green')
    title('Pigs vs. Hunters before hunting ')
    legend('pigs','hunters')
    xlabel('Miles')
    ylabel('Miles')
    hold off


%%%% scatter plot with radius involved
%%% The first 5 lines confuse me why they need to be there, but they do.
    figure
    scatter(xcoordsp,ycoordsp, 'red')
    hold on 
    scatter(xcoordsh,ycoordsh, 'green')
    hold off


    s=radius;
    h=scatter(xcoordsh,ycoordsh);
    hold on
    currentunits = get(gca,'Units');
    set(gca, 'Units', 'Points');
    axpos = get(gca,'Position');
    set(gca, 'Units', currentunits);
    markerWidth = s/diff(xlim)*axpos(3); % Calculate Marker width in points
    set(h, 'SizeData', markerWidth^2)
    hold on
    scatter(xcoordsp,ycoordsp, 'red')
    hold on 
    scatter(xcoordsh,ycoordsh, 'green')
    title('Pigs vs. Hunters before hunting  ')
    legend('radius','pigs','hunters')
    xlabel('Miles')
    ylabel('Miles')
    hold off
end
%%%%%%%%%%%%%%%% END INITAL PLOTS




%%%%%%%%%%%%%%%%%%%%%%%% THE HUNT BEGINS
for i=1:huntercount
    xhunt=xcoordsh(i);
    yhunt=ycoordsh(i);
    for j=1:pigcount
        xpig=xcoordsp(j);
        ypig=ycoordsp(j);
        if(sqrt((xpig-xhunt)^2+(ypig-yhunt)^2)<radius && xpig~=0 && ypig ~=0)
             %disp('distance')
             %disp(sqrt((xpig-xhunt)^2+(ypig-yhunt)^2))
             pigcountcurr=pigcountcurr-1;
             xcoordsp(j)=0;
             ycoordsp(j)=0;
            % disp('PIG KILLED')
        end
   end 
end
%%%%%%%%%%%%%%% END HUNT

%%%%%%%%%%%% DISPLAY PIG NUMBERS (to console)
%disp('TOTAL HOGS REMAINING');
%disp(pigcountcurr);
%disp('TOTAL HOGS KILLED');
%disp(pigcount-pigcountcurr);
%%%%%%%%% END PIG NUMBERS

%%%%%%%%%%%%%% FINAL GRAPH
if(trigger==1 || trigger==0)
    figure
    scatter(xcoordsp,ycoordsp, 'red')
    hold on 
    scatter(xcoordsh,ycoordsh, 'green' )
    hold off
    title('Pigs vs. hunters after hunting ')
    legend('pigs','hunters')
    xlabel('Miles')
    ylabel('Miles')
end
%%%%%%%%%%%% END FINAL GRAPH
if(trigger==3)
    pigcountcurr=pigcount-pigcountcurr;
    %disp(pigcountcurr)
end

return; %%% RETURN TO SENDER, GIVE THEM PIG COUNT

%%%%EOF
