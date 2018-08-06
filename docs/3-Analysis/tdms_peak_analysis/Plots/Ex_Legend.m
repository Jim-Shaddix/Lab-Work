
figure()
hold on

x_data = {1:10,11:20,21:30,31:40};
y_data = {10*ones(1,10), 20*ones(1,10), 30*ones(1,10),40*ones(1,10)};

for i = 1:length(x_data)
   plot(x_data{i},y_data{i},'r-','DisplayName','Some-Data') 
end

legend()