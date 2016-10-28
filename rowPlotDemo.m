% demo for rowPlot
x = linspace(0,10);
y1 = sin(x);
y2 = sin(2*x);
y3 = sin(4*x);
y4 = sin(8*x);

Y = {y1, y2, y3, y4};

rowPlot(x,Y);