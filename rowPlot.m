% rowPlot : plots 4 four figures in a row which share the same legend
%
%
% Usage : rowPlot(X, Ys, Name,Value)
%
% Input :
%           X   --   a vector
%           Ys  --   a matrix
%           Name, Value   --  optional parameters
%
%           currently supported Name, Value pair
%                   FigureWidth     1730(default)|positive value
%                   FigureHeight    590(default)|positive value
%                   FigureMargin    0.005(default)|same as [0.005 0.005 0.005 0.005]
%                                   [left top right bottom] vector with length of
%                                   4, each element is within [0,1)
%                   XLabelFontSize  18(default)|same as [18 18 18 18]
%                   YLabelFontSize  similar as XLalelFontSize
%                   TitleFontSize   similar as XLabelFontSize
%                   AxesFontSize    similar as XLabelFontSize but default
%                                   is 16
%                   LegendFontSize  18(default)
%
%                   xlim            parameters for xlim in a cell if different
%                                   for different axes, otherwise the same as xlim
%                                   {[0,1],[0,2],[0,3],[0,4]}
%                   ylim            similar to xlim
%                   xlabel          parameters for xlabel in a cell, the
%                                   first cell entry should be a cell if
%                                   different axes use different xlabels,
%                                   otherwise just a string, the following
%                                   parameters as Name Value pairs, if
%                                   different axes have different values,
%                                   please use a cell (for non-scalar) or a
%                                   vector (for a scalar value).
%                  ylabel           string
%                  title            similar to xlabel
%                  legend           parameter for legend in a cell
%
%                  properties_common     common properties
%                  properties_diff     different properties
%                  properties_legend properties for legend
%
%                  figureName      string
%
%
%
%

% V1.0
% Long Gong
% gonglong.gatech@gmail.com
% Oct. 27, 2016
%


function rowPlot(X, Ys, varargin)

if iscell(X)
    for i = 1:length(X)
        if size(X{i},2) ~= 1
            X{i} = X{i}';
            Ys{i} = Ys{i}';
        end
    end
else
    if size(X,2) ~= 1
        X = X';
        for i = 1:length(Ys)
            Ys{i} = Ys{i}';
        end
    end
end


if mod(length(varargin),2) ~= 0
    error('Error in %s',mfilename('class'))
end

% default setting
W = 1730; % figure width
H = 590; % figure height

M = [0.005 0.005 0.005 0.005]; % figure margin [left top right bottom]

MM = 0.04; % spacing between figures

% width and height for each figure
w = 0.202;
h = 0.78;

% width for ylabel
yLabelw = 0.05;
% height for title
titleh = 0.05;
% height for xlabel
xLabelh = yLabelw;


titleFont = 18;
labelFont = 18;
axesFont = 16;
legendFont = 18;
xlabelFont = labelFont;
ylabelFont = labelFont;

figureName = '4X1';
PROP_P = {};

myPlot = @plot;
% parser optional parameters
for i = 1:2:length(varargin)
    switch lower(varargin{i})
        case {'figurewidth'}
            W = varargin{i + 1};
        case {'figureheight'}
            H = varargin{i + 1};
        case {'figuremargin'}
            M = varargin{i + 1};
            if isscalar(M)
                M = ones(4,1) * M;
            end
        case {'xlabelfontsize'}
            xlabelFont = varargin{i + 1};
        case {'ylabelfontsize'}
            ylabelFont = varargin{i + 1};
        case {'xlim'}
            xlim_ = varargin{i + 1};
        case {'ylim'}
            ylim_ = varargin{i + 1};
        case {'xlabel'}
            xlabel_ = varargin{i + 1};
        case {'ylabel'}
            ylabel_ = varargin{i + 1};
        case {'title'}
            title_ = varargin{i + 1};
        case {'legend'}
            legend_ = varargin{i + 1};
        case {'commonproperties'}
            PROP_C = varargin{i + 1};
        case {'diffproperties'}
            PROP_D = varargin{i + 1};
        case {'figurename'}
            figureName = varargin{i + 1};
        case {'plotproperties'}
            PROP_P = varargin{i + 1};
        case {'plottype'}
            switch varargin{i + 1}
                case {'plot'}
                    myPlot = @plot;
                case {'semilog'}
                    myPlot = @semilog;
                case {'loglog'}
                    myPlot = @loglog;
            end
    end
end

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


ax = cell(1,4);
for i = 1:4
    ax{i} = axes('Parent',figure1,...
        'Position',[ax_xpos(i) axy w h], 'FontSize', axesFont);
    hold(ax{i},'on');
    % subplot(2,2,1)
    K = size(Ys{i},2);
    for k = 1:K
        lspec = cell(1,length(PROP_P));
        for j = 1:2:length(PROP_P)
            lspec{j} = PROP_P{j};
            if length(PROP_P{j + 1}) == 1
                lspec{j + 1} = PROP_P{j + 1};
            else
                try
                    lspec{j + 1} = PROP_P{j + 1}{k};
                catch
                    lspec{j + 1} = PROP_P{j+1}(k);
                end
            end
        end
        
        if iscell(X)
            myPlot(X{i},Ys{i}(:,k),'Parent',ax{i}, lspec{:});
        else
            myPlot(X,Ys{i}(:,k),'Parent',ax{i}, lspec{:});
        end
    end
    if exist('ylabel_','var') ~= 0
        if i == 1
            ylabel(ylabel_,'FontSize', ylabelFont)
        end
    end
    if exist('xlabel_', 'var') ~= 0
        xlabel(xlabel_, 'FontSize', xlabelFont)
    end
    
    if exist('xlim_', 'var') ~= 0
        if iscell(xlim_)
            xlim(ax{i},xlim_{i})
        else
            xlim(ax{i},xlim_)
        end
    end
    
    if exist('ylim_', 'var') ~= 0
        if iscell(ylim_)
            ylim(ax{i}, ylim_{i})
        else
            ylim(ax{i}, ylim_)
        end
    end
    
    if exist('title_', 'var') ~= 0
        if iscell(title_)
            title(title_{i},'FontSize', titleFont);
        else
            title(title_,'FontSize', titleFont);
        end
    end
    box(ax{i},'on');
    
    if exist('PROP_C', 'var') ~= 0
        for k = 1:2:length(PROP_C)
            set(ax{i},PROP_C{k}, PROP_C{k + 1});
        end
    end
    
    if exist('PROP_D', 'var') ~= 0
        for k = 1:2:length(PROP_D)
            try
                set(ax{i},PROP_D{k}, PROP_D{k + 1}{i});
            catch
                set(ax{i}, PROP_D{k}, PROP_D{k + 1}(i));
            end
        end
    end
    
end

% set legend
if exist('legend_', 'var') ~= 0
    if iscell(legend_{1})
        lh = legend(ax{1}, legend_{1}, 'Orientation','horizontal');
    else
        lh = legend(ax{1}, legend_, 'Orientation','horizontal');
    end
    lp = get(lh, 'Position');
    legx = (1 - lp(3)) / 2;
    set(lh, 'box', 'off', 'Position', [legx legy lp(3:4)], 'FontSize', legendFont);
    if iscell(legend_{1})
        try
            for k = 2:2:length(legend_)
                set(lh, legend_{k}, legend_{k + 1});
            end
        catch
        end
    end
end
saveas(gcf,figureName,'epsc')
end