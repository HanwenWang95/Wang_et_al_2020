% Function to run t-SNE for the population
%
% Inputs: params_in    -- object containing model inputs required for t-SNE 
%         params_out   -- object containing model outputs with RCEIST and
%                         Response status
%         varargin     -- flag that indicates if this analysis is done on
%                         plausible patients or all the patients
%        
% Outputs: Plots
%
% Created: Feb 25, 2019 (Mohammad Jafarnejad)
% Last Modified: Mar 15, 2019 (MJ)

function PSA_tSNE(params_in,params_out,varargin)

% find if all the simulations are used or just the plausible ones
if (nargin == 3)
    if strcmp(varargin{1},'plausible')
        n_PSA = length(params_out.iPatientPlaus);
        index = params_out.iPatientPlaus;
    elseif strcmp(varargin{1},'patient')
        n_PSA = length(params_out.iPatient);
        index = params_out.iPatient;
    else
        n_PSA = length(params_out.patient);
        index = 1:n_PSA;
    end
else
    n_PSA = length(params_out.patient);
    index = 1:n_PSA;
end

perplexity = [5 30 100 250];
perplexity = min(perplexity,(n_PSA*0.8));

hfig = figure;
% % Set the window in a specific size
% set(f0100,'Position', [50 50 1300 800]);
% Maximized window
set(hfig,'units','normalized','outerposition',[0 0 1 1])

try
    tsneData = [params_in.all(index,:), params_in.allObs(index,:)];
catch
    tsneData = params_in.all(index,:);
end

for i = 1:length(perplexity)
    subplot(2,4,i);
    [Y, loss] = tsne(tsneData,'Standardize' ,true,'Perplexity',perplexity(i));
    gscatter(Y(:,1),Y(:,2), params_out.RECIST(index))
    title(['Perplexity: ', num2str(perplexity(i),'%d'), ' (loss = ', num2str(loss),')']);
end


subplot(2,3,4);
[Y, loss] = tsne(tsneData,'Standardize' ,true,'Perplexity',floor(n_PSA/3));
gscatter(Y(:,1),Y(:,2), params_out.RECIST(index))
title(['RECIST - Perplexity: ', num2str(floor(n_PSA/3),'%d'), ' (loss = ', num2str(loss),')']);

subplot(2,3,5);
idx = kmeans(tsneData,10);
gscatter(Y(:,1),Y(:,2), idx)
title(['k-means clustering (k = 10)']);

subplot(2,3,6);
Z = linkage(tsneData,'ward');
c = cluster(Z,'maxclust',10);
gscatter(Y(:,1),Y(:,2), c)
title(['Hierarchical clustering (c = 10)']);

%% Clustergram of patient subtypes

set(0,'ShowHiddenHandles','on')
for i = 1:length(params_in.names)
    namesIn{i} = params_in.(params_in.names{i}).ScreenName;
end
try
    for i = 1:length(params_in.namesObs)
        namesIn{length(params_in.names)+i} = params_in.(params_in.namesObs{i}).ScreenName;
    end 
catch
end

% Whe nwe have the final data, we need to think more carefully about the
% standardization step and turn off clustergram's interfnal standardize
data = log2(tsneData);
cg = clustergram(data,     'RowLabels', params_out.RECIST(index),...
                             'ColumnLabels', namesIn,...
                             'RowPdist', 'correlation',...
                             'ColumnPdist', 'correlation',...
                             'Dendrogram', 1,...
                             'Standardize', 1,...
                             'ColumnLabelsRotate', 90,...
                             'ImputeFun', @knnimpute)

% Turns on the colorbar
cbButton = findall(gcf,'tag','HMInsertColorbar');
ccb = get(cbButton,'ClickedCallback');
set(cbButton,'State','on');
ccb{1}(cbButton,[],ccb{2});

% plots the clustergram into a figure
hfigCG = figure;
set(hfigCG,'units','normalized','outerposition',[0 0 1 1])
cgplot = plot(cg, hfigCG);
set(cgplot,'Fontsize',14);
% set(cgplot,'position',[.3 .2 .5 .6]);
    
% closes the first clustergram figure
set(groot,'ShowHiddenHandles','on')
close 'Clustergram 1'

%% Interesting Reads on 
% t-SNE
% https://distill.pub/2016/misread-tsne/
% http://deeplearning.csail.mit.edu/slide_cvpr2018/laurens_cvpr18tutorial.pdf
% https://www.biorxiv.org/content/biorxiv/early/2018/10/25/453449.full.pdf
% https://arxiv.org/pdf/1706.02582.pdf

% Clustergram options
% https://www.mathworks.com/help/bioinfo/examples/working-with-the-clustergram-function.html
