x = linspace(0,10);
y1 = sin(x);
y2 = sin(2*x);
y3 = sin(4*x);
y4 = sin(8*x);

figure1 = figure('Position', [1, 1, 1730, 590]);
% Create axes
axes1 = axes('Parent',figure1,...
    'Position',[0.018539976825029 0.583837209302326 0.446119114084062 0.341162790697675]);
hold(axes1,'on');
% subplot(2,2,1)
plot(x,y1,'Parent',axes1);

title('Subplot 1: sin(x)')
box(axes1,'on');

% Create axes
axes2 = axes('Parent',figure1,...
    'Position',[0.498261877172654 0.583837209302326 0.486095017381228 0.341162790697675]);
hold(axes2,'on');
% subplot(2,2,2)
plot(x,y2, 'Parent',axes2)
title('Subplot 2: sin(2x)')
box(axes2,'on');

% Create axes
axes3 = axes('Parent',figure1,...
    'Position',[0.0196987253765933 0.11 0.444960365532497 0.341162790697675]);
hold(axes3,'on');
% subplot(2,2,3)
plot(x,y3, 'Parent',axes3)
title('Subplot 3: sin(4x)')
box(axes3,'on');

% Create axes
axes4 = axes('Parent',figure1,...
    'Position',[0.502896871378911 0.11 0.479142526071842 0.341162790697675]);
hold(axes4,'on');
% subplot(2,2,4)
plot(x,y4,'Parent',axes4)
title('Subplot 4: sin(8x)')
box(axes4,'on');
saveas(gcf,'2X2','epsc')
