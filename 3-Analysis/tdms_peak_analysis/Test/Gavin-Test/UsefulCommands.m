% A list of useful MatLab commands. Created by Gavin Hester.

% As should be obvious, the % sign creates a comment.
%% Creates a section. This is useful for segmenting your code and can allow you to run single sections at once.

%% The below section is just teaching some basics about the format of MatLab.

help command %This will print the help information for a command in the command window
    %If you write your own function/command, the beginning comments in the
    %file will be output.

doc command %This creates a new window with the help information for a command.

clc % clears the command window.
clear all % clears all the variables in the workspace (advised to put this 
    %at the beginning of each script)
clear variable %You can also use clear in the middle of a script to clear a variable.
close all %Closes all open windows. Can also be used to close single windows.

number = 1 %MatLab does not require you to differentiate between different 
    %types of numbers (i.e. matrix vs integer vs float)

number = 0.001; %Adding a semicolon at the end of a line will suppress the 
    %output. If we ran the previous command it would print the output to the terminal
    
char_array = 'Hello World!'; %Character arrays are denoted by single apostrophes.

string = "Hello World!"; %Strings are denoted by double apostrophes.

matrix = [1, 2, 3; 1, 2, 3]; %MatLab does have the concept of arrays,  but
    %everything is treated as a matrix, no matter the dimensions. 
    %Commas separate columns in a row and semicolons create new rows.
    
matrix(1,1) %This will output the number 1. Matlab starts counting at 1.

matrix(1,:) %The colon here lets you display all elements in that dimension.

matrix2 = [3, 2, 1; 3, 2, 1];

matrix2\matrix %This actually solves an equation of the form:
    %matrix2*x = matrix. You can similarly do matrix2/matrix
    %I won't go into more detail on these, but they are based off the
    %commands mldivide and mrdivide if you want to do more research.
    
matrix2./matrix; %The . here tells MatLab to perform the operation element 
    %by element.
    
matrix_transpose = matrix'; %This is a fast way to transposes a matrix. 

matrix_inv = inv(matrix); %This command inverses square matrices.

matrix_hconj = ctranspose(matrix); %This gives the hermitian conjugate.

size(matrix,1) %This will give the number of rows. (replacing the 1 with 2 
    %gives you the other dimension.

%% This section will go over the basic "computer science"-like methods.

for ii = 1:10 %Note, I use ii here because i is definted as sqrt(-1)
    disp(ii) %This will display what is in the parenthesis in the command window.
end

%Simlarly one can do:

for ii = 1:size(matrix,1)
    disp(matrix(ii,1));
end

%Here is an example of embedded for loops as well as an if statement. The
%standard logic is available for if statements. The most common are ==
%(meaning equal to), ~= (meaning not equal to)
for ii = 1:size(matrix,1)
    for jj = 1:size(matrix,2)
        if matrix(ii,jj) == 1
            disp('It works!')
        end
    end
end

% Similarly one can use a while loop, but I generally avoid these as they
% can lead to runaway code.

%% The below section has commands for reading/writing data.

filepath = './myfilepath.dat';  %The ./ here tells Matlab to look in the 
    %current folder for the file.
    
data = importdata(filepath); %This command is the holy grail of data loading.
    %It can load .mat files, ASCII files, images, as well as audio files.
    %Note there are a bunch of options on this command that you should
    %explore (and that will be required to properly load in the data.
    
csvread(filepath) %This will read data in from a basic CSV file. I find 
    %this particularly useful if I cannot get importdata to work properly, 
    %but Excel will still format the data for me.
    
save('datafile.mat', data) %This would save the data to a .mat file. It can also be used to 
    %write other ASCII files.
    
csvwrite('filename.csv', data) %This will save data to a csv, if you 
    %like that sorta thing.

%% Plotting commands

% This is probably best taught by example. Here is how I would plot a set
% of data (and make it look nice).

figure; %Creates a blank figure window.
hold on %Tells MatLab to overplot data if multiple plot commmands are given.
p = plot(x,y); %Plots a line of x vs y. Has numerous customization options available.
    %Here I assign the plot to a variable so that I can later manipulate
    %it. However, one can also give the customizations as name-value pair
    %arguments.
p.LineWidth = 2; %Sets the width of the line.
p.Color = 'red'; %Color of the line.

%I think the below three are self explanatory.
xlabel('x data')
ylabel('y data')
title('Example Plotting')

box on %Creates axes on the right and top of the plot.
axis([min(x) max(x) min(y) max(y)]) %Sets axis limits.

%This is where things get hairy. gca is a command in Matlab that returns
%the current axes. Here we use that concept and the set function to make
%the plots look a little prettier and define their size.
set(gca, 'fontsize', 24)
set(gca, 'LineWidth', 1.5)
set(gca, 'TickLength', [0.02, 0.2])

%Here gcf returns the current figure handle
set(gcf,'Position',[200 100 1200 900]) %I find this useful for outputting 
    %figures all with the same aspect ratio, as Matlab determines the 
    %aspect ratio by the size of the window. I admit there is probably a
    %more elegant and general way to do this.

%Here is an example of how to use scatter plotting.

scatter(x,y,'Filled', 80)
%This is showing you that name-value pairs are not necessarily required
    %as MatLab is pretty good at knowing what you want it to do.
    
pcolor(x,y,I) %This creates a "pseudocolor" plot with I being the intensity. 
    % I could write pages on how to use this, but it is better to leave it
    % for you to explore.
    
subplot(2,1,1) %I'm not going to go into this as the help article is pretty good.
    %But here is the syntax for starting a subplot.
    
save -dpng filename.png -r1500 %This saves the current plot as a high 
    %resolution png (the best non-vector image format for scientific plots).
    
%% Finally, here are some miscellaneous commands I (and others) use.

x = linspace(1,10,10); %Creates an array of numbers from 1 to 10 with 10 steps.

%If I want to sort two matrices in the same way, I can do this:
a = [5, 2, 1, 6];
b = [1, 2, 2, 3];

[a_sorted, I] = sort(a);
b_sort = b(I);


[p, S] = polyfit(x,y,1); %This will fit a 1st order polynomial to my data 
    %and output the coefficients on each term of the polynomial.
    
%Until now I have ignored one of the more useful (but complicated) concepts
%in MatLab, structures. Structures are a convenient way to store data in
%different variables. Say I have three vectors that correspond to something
%special (like lattice vectors).

a = [1, 0, 0];
b = [0, 1, 0];
c = [0, 0, 1];

vectors = struct('avec', a, 'bvec', b, 'cvec', c);

%I can now call any of these vectors by using the syntax:
vectors.avec

%Since we have vectors now:

cross(vectors.avec, vectors.bvec) %cross product.
dot(vectors.avec, vectors.bvec) %dot product.








