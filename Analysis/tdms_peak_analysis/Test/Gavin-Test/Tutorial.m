% Tutorial for Matlab. Created by Gavin Hester.

% The general idea of this tutorial is for you to learn how to load data
% into MatLab, store it in  matrices, manipulate the data, and create
% publication quality plots. The type of data you are using is irrelevant,
% but for your own knowledge you will be loading in a datafile that
% measures the magnetization of a sample versus applied magnetic field.

%What did I say to start every script with? (I'll give you this one for
%free, it is clc (clears command window) and more importantly, clear all
%(clears the workspace variables).
clear
clc

%Put the filepath for the data below.
filepath = 'SampleData.dat';

%Load the data into MatLab and save it to a variable named "data". Hint:
%You may need to look at the data file to skip some header lines and tell
%it what the delimiter is. Be sure to use the documentation for this.
data  = importdata(filepath, ',', 31);

%%
%Your data should now be saved as a structure. All the numbers you need are
%in the "data" field of your structure.Save the values for time, field,
%long moment, and long scan std dev to variables of the name Time, Field,
%Temp, Moment, MomentErr.
da = data.data;
time = da(:,1);
field = da(:,3);
long_moment = data.data(:,5);
long_scan_std = da(:,6);

%%
%Find the average of the temperature and display it to the command window.
temp = da(:,4);
disp(['mean temp: ', num2str(mean(temp))])
%%
%Now we need to convert the units. I won't make you go through the
%derivation, so simply multiply the field values by 10^-4 and multiply the
%moment values by 2.77. We will ignore the error values for now.

new_field = field * 10.^-4;
new_long_moment = long_moment .* 2.77;
%%
%Now you should plot the moment versus field and make it look publication
%quality.
plot(new_field, new_long_moment, 'bo')
xlabel('field')
ylabel('long moment')
box on
title('long moment vs. field')
%%
%Save the file as MvsHPlot.png (oddly enough, using the "print" command)
print('MvsHPlot','-dpng')

%%
%Now I want you to take the numerical derivative of the moment data to observe the
%shape of the derivative. (i.e. do \delta M divided by \delta H. Note, this
%evaluates the derivative at the midpoint of the field values. You could
%earn bonus points by plotting the midpoint of the field values instead.

diff_m = []
diff_f = []
for i=2:length(new_long_moment)
   diff_m = [diff_m, new_long_moment(i) - new_long_moment(i-1)];
   diff_f = [diff_f, new_field(i) - new_field(i-1)];
end
deriv = diff_m ./ diff_f;
%%

%Plot the numerical derivative below.
plot(deriv)

%%


%Before we move to the final section I want to make sure you know about
%break points. Put a break point just below this line so you can observe
%your plots before they close. After you view them once you will have to
%remove the breakpoint.
close all


%Finally, I want you to fit a line to the low field section of the data.
%You will want to remove all the data for fields above 18000 Oe (or 1.8
%T). I have provided a rough template below to help you out (you will need to uncomment it).

parsed_field = new_field(new_field < 18000);

% for ii = 1:size(Fill something in here)
%     if
%         Field_Compressed = 
%         Moment_Compressed =
%     end
% end


%Now that you have the compressed data, please use the polyfit command to
%extract the slope and intercept (i.e. a 1st order polynomial). Display the
%slope and intercept to the command line.

polyfit([1:length(parsed_field)]', parsed_field, 1)



%Great job! You are now done. See below for a "bonus" section.
% if exist(Temp) ~= 0
%     disp('Great job!')
% end



%Your bonus task is to overplot the compressed data with the fit you have
%performed. Hint: You will want to generate a data set with the slope and
%intercept you found.



    



