x = linspace(0,10);
y1 = sin(x);
y2 = sin(2*x);
y3 = sin(4*x);
y4 = sin(8*x);


%% Position Settings
% settings
W = 1730;
H = 590;

M = [0.005 0.005 0.005 0.005];
MM = 0.04;

w = 0.2;
h = 0.78;

yLabelw = 0.05;
titleh = 0.05;
xLabelh = yLabelw;

ax1x = yLabelw;
ax2x = ax1x + w + MM;
ax3x = ax2x + w + MM;
ax4x = ax3x + w + MM;

ax_xpos = [ax1x ax2x ax3x ax4x];

axy = 2 * xLabelh + 2*M(4);

legy = h + axy + titleh + M(2);
% axy = legh + titleh;

figure1 = figure('Position', [1 1 W H]);
% Create axes
axes1 = axes('Parent',figure1,...
    'Position',[ax_xpos(1) axy w h], 'FontSize', 16);
hold(axes1,'on');
% subplot(2,2,1)
plot(x,y1,'Parent',axes1);
ylabel('Y Label','FontSize', 18)
xlabel('X Label', 'FontSize', 18)

title('Subplot 1: sin(x)','FontSize', 18)
box(axes1,'on');

% Create axes
axes2 = axes('Parent',figure1,...
    'Position',[ax_xpos(2) axy w h], 'FontSize', 16);
hold(axes2,'on');
% subplot(2,2,2)
plot(x,y2, 'Parent',axes2)
title('Subplot 2: sin(2x)','FontSize', 18)
xlabel('X Label', 'FontSize', 18)
box(axes2,'on');

% Create axes
axes3 = axes('Parent',figure1,...
    'Position',[ax_xpos(3) axy w h], 'FontSize', 16);
hold(axes3,'on');
% subplot(2,2,3)
plot(x,y3, 'Parent',axes3)
title('Subplot 3: sin(4x)', 'FontSize', 18)
xlabel('X Label', 'FontSize', 18)
box(axes3,'on');

% Create axes
axes4 = axes('Parent',figure1,...
    'Position',[ax_xpos(4) axy w h], 'FontSize', 16);
hold(axes4,'on');
% subplot(2,2,4)
ax = plot(x,y4,'Parent',axes4);
title('Subplot 4: sin(8x)','FontSize', 18)
xlabel('X Label', 'FontSize', 18)
box(axes4,'on');

lh = legend([ax], 'Orientation','horizontal');
lp = get(lh, 'Position');
legx = (1 - lp(3)) / 2;
set(lh, 'box', 'off', 'Position', [legx legy lp(3:4)], 'FontSize', 18)
saveas(gcf,'2X2','epsc')