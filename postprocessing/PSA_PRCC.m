% Function to run the model with parameter snesitivity analysis cases
%
% Inputs: model        -- simbio data from PSA
%         params       -- object containing LHS values of model parameters
%         varargin     -- flag that indicates if this analysis is done on
%                         plausible patients or all the patients
%
% Outputs: simDataPSA  -- results from the LHS simulations
%
% Created: Jan 21, 2019 (Mohammad Jafarnejad)
% Last Modified: Oct 3, 2019 (HW)

function PSA_PRCC(params_in,params_out,varargin)

% find if all the simulations are used or just the plausible ones
if (nargin == 3)
    if strcmp(varargin{1},'plausible')
        n_PSA = length(params_out.iPatientPlaus);
        index = params_out.iPatientPlaus;
    elseif strcmp(varargin{1},'patient')
        n_PSA = length(params_out.iPatient);
        index = params_out.iPatient;
    else
        n_PSA = length(params_out.iPatient);
        index = params_out.iPatient;
    end
else
    n_PSA = length(params_out.iPatient);
    index = params_out.iPatient;
end

% calculate PRCCs
[rho ,pval] = partialcorr(params_in.all(index,:), params_out.post(index,:) , ones(n_PSA,1) , 'rows','complete','type','Spearman');
% [rho ,pval] = partialcorr([params_in.all(index,:), params_in.allObs(index,:)], params_out.post(index,:) , ones(n_PSA,1) , 'rows','complete','type','Spearman');

% replace NaNs to zero to be able to heatmap
k = find(isnan(rho))';
rho(k) = 0;

%% heatmap correlations coefficients
fontsize = 12;
% colormap = 'redbluecmap';
% colormap = 'redgreencmap';
% colormap = 'hot';
% colormap = 'jet';
load('cmap.mat')

for i = 1:length(params_in.names)
    namesIn{i} = params_in.(params_in.names{i}).ScreenName;
end
% for i = 1:length(params_in.namesObs)
%     namesIn{i+length(params_in.names)} = params_in.(params_in.namesObs{i}).ScreenName;
% end

for i = 1:length(params_out.names)
    namesOut{i} = params_out.(params_out.names{i}).ScreenName;
end

% hMap = HeatMap(heatData,'RowLabels',namesOut,'ColumnLabels',[labelX],'Colormap', colormap,'Symmetric', 0,'DisplayRange',.5)
hMap = HeatMap(rho','RowLabels',[namesOut],'ColumnLabels',[namesIn],'Colormap', cmap,'Symmetric', 1, 'DisplayRange', .2);
% hMap = HeatMap(rho,'RowLabels',[namesIn],'ColumnLabels',[namesOut],'Colormap', cmap,'Symmetric', 1, 'DisplayRange', .5);

hPlot = plot(hMap);
set(gcf,'Position', [100 200 950 750]);
set(hPlot,'YTickLabelRotation',35)
set(hPlot,'XTickLabelRotation',35)
set(hPlot,'FontSize',fontsize+2, 'Position', [.27 .55 .60 .40]);
hBar = colorbar(hPlot); % ('SouthOutside')
set(hBar, 'Position', [.90 .55 .02 .4]);
set(hPlot,'FontSize',fontsize+4);
get(gcf,'Colormap');
% title('PRCC')
%     set(gca,'Fontsize',fontsize+2)
%

%% Heatmap p-values

colormap = 'parula';

% scale very small p values to 1e-3 as minimum
pval = log10(pval);
for i =1:size(pval,1)
    for j =1:size(pval,2)
        if(pval(i,j)<-3)
            pval(i,j) = -3;
        end
    end
end

% hMap = HeatMap(heatData,'RowLabels',namesOut,'ColumnLabels',[labelX],'Colormap', colormap,'Symmetric', 0,'DisplayRange',.5)
hMap = HeatMap(pval','RowLabels',namesOut,'ColumnLabels',namesIn,'Colormap', colormap,'Symmetric', 0);

hPlot = plot(hMap);
set(gcf,'Position', [900 200 950 750]);
set(hPlot,'FontSize',fontsize, 'Position', [.25 .55 .60 .40]);
hBar = colorbar(hPlot); % ('SouthOutside')
set(hBar, 'Position', [.90 .55 .02 .35]);
set(hPlot,'FontSize',fontsize+4);
c = get(gcf,'Colormap');
set(gcf,'Colormap',flipud(c));
% title('log_1_0(p-value)')
% caxis([-3 0])

%% Close unnecessary figure duplicates

set(groot,'ShowHiddenHandles','on')
close 'HeatMap 1'
close 'HeatMap 2'
set(groot,'ShowHiddenHandles','off')
