clear 
clc

a = 5;

x1 = 1 : 10;
y1 = randn(1, 10);
x2 = randn(10);
y2 = randn(10);
figure;
h1 = subplot(2, 1, 1);
plot(x1, y1);
h2 = subplot(2, 1, 2);
plot(x2, y2,x1,y1)

set(h1, 'ButtonDownFcn', {'PlotNewFigure', x1, y1, 123})
set(h2, 'ButtonDownFcn', {'PlotNewFigure', x2, y2, 456})