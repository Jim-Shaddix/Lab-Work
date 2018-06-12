
% website to try:
% https://www.mathworks.com/matlabcentral/answers/310286-subplot-how-can-i-set-the-size-of-my-diagram-in-my-subplot-size-definition-of-each-placeholder

% x-value to plot
x = 0:0.01:100;
%%


pos1 = [0.1 0.3 0.3 0.3];
subplot('Position',pos1)
y = magic(4);
plot(y)
title('First Subplot')

% left    -> high goes right
% bottom  -> high goes up
% width   -> high goes wide
% height  -> high goes wide
%[left bottom width height] (between 0 -- 1)
pos2 = [0.5 0.15 0.8 0.7]; 

subplot('Position',pos2)
bar(y)
title('Second Subplot')


%% 2

% set figure info
fig = figure;
fig.Units = 'centimeters';
fig.Position(3:4) = [35  25];

%pos1 = [0.13 0.11 0.775 0.815]; % [left bottom width height]
subplot(2,3,1,'Position');  
plot(x,cos(x))

subplot(2,3,2);  
plot(x,sin(2*x))

subplot(2,3,3);  
plot(x,tan(x))

subplot(2,3,4);  
plot(x,sec(2*x))

subplot(2,3,5);  
plot(x,csc(x))

subplot(2,3,6);  
plot(x,cot(2*x))

%% 40

% set figure info
fig = figure;
fig.Units = 'centimeters';
fig.Position(3:4) = [40  30];

count = 30;
rows = ceil(count/4);

for i = 1:count

    %[left bottom width height]
    %pos2 = [0.5 0.15 0.4 0.7];  
    subplot(rows,4,i);  
    
    % plot data
    plot(x.^(2/count*i))
    
    % plot metadata
    title(['Subplot: ',int2str(i)])
    
    %pos1 = get(sp_hand1, 'Position'); % gives the position of current sub-plot
    %new_pos1 = pos1 +[0 0 0 0.05];
    %set(sp_hand1, 'Position',new_pos1) % set new position of current sub - plot

end