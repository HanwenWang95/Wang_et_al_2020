% SimBiology Diagnostic Plot Generator for Hill parameters
%
% Plots SimBiology Data 
%
% Inputs: simData - SimBiology output data
%
%         
% Created: Mar 18, 2019 (Mohammad Jafarnejad)
% Last Modified: Mar 18, 2019 (MJ) 

function diagnostic_plot_H(simData)

f = figure;
% % Set the window in a specific size
% set(f0100,'Position', [50 50 1300 800]);
% Maximized window
set(f,'units','normalized','outerposition',[0 0 1 1])

%% Tumor growth and antigens

%     [~,temp,~] = selectbyname(simData, 'H_PD1_C1');
j = 1;
for i = 1:length(simData.DataNames)
    if (simData.DataNames{i}(1)=='H')
        subplot(3,5,j); hold on; box on;
        [~,temp,~] = selectbyname(simData, simData.DataNames{i});
        plot(simData.time, simData.Data(:,i))
        Hname = strrep(simData.DataNames{i},'_','\_');
        xlabel('Time (days)'); ylabel(['$',Hname,'$']); 
        j = j+1;
    end
end
