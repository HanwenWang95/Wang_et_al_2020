% SimBiology Diagnostic Plot Generator for diagnostic rates
% Plots SimBiology Data 
%
% Inputs: simData - SimBiology output data
%
%         
% Created: Mar 19, 2019 (Mohammad Jafarnejad)
% Last Modified: Mar 19, 2019 (MJ) 

function diagnostic_plot_rates(simData)

f = figure; 
% % Set the window in a specific size
% set(f0100,'Position', [50 50 1300 800]);
% Maximized window
set(f,'units','normalized','outerposition',[0 0 1 1])


%% Plot basics
% Tumor volume and diameter
subplot(2,4,1); hold on; box on;
yyaxis left
simbio_plot(simData,'V_T');
xlabel('Time (days)'); ylabel('Tumour Volume (microliter)'); set(gca, 'YScale', 'log'); %ylim([1 1e12]);
yyaxis right
[~,V_T,~] = selectbyname(simData, 'V_T');
D_T = 2/10*(3/(4*pi)*V_T).^(1/3); % in cm after division by 10
plot(simData.time, D_T)
ylabel('Tumour Size (cm)');

% Cancer cells
subplot(2,4,2); hold on; box on;
% simbio_plot(simData,'C1');
simbio_plot(simData,'C1','CompartmentName','V_T' ,'LegendEntry','$C_{1,T}$' );
simbio_plot(simData,'C_x','CompartmentName','V_T' ,'LegendEntry','$C_{x,T}$' );
legend('show');
xlabel('Time (days)'); ylabel('Number of Cancer Cells'); set(gca, 'YScale', 'log'); %ylim([1 1e12]);

% T1 in LN, Central, Tumor, and Peripheral 
subplot(2,4,3); hold on; box on;
simbio_plot(simData,'T1','CompartmentName','V_T' ,'LegendEntry','$T_{1,T}$' );
simbio_plot(simData,'T1','CompartmentName','V_C' ,'LegendEntry','$T_{1,C}$' );
simbio_plot(simData,'T1','CompartmentName','V_LN','LegendEntry','$T_{1,LN}$');
simbio_plot(simData,'T1','CompartmentName','V_P','LegendEntry','$T_{1,P}$');
simbio_plot(simData,'T_exh','CompartmentName','V_T' ,'LegendEntry','$T_{x,T}$' );
xlabel('Time (days)'); ylabel('Number of T1 Cells'); legend; set(gca, 'YScale', 'log');  ylim([1 inf]);

% Treg in LN, Central, Tumor, and Peripheral 
subplot(2,4,4); hold on; box on;
simbio_plot(simData,'T0','CompartmentName','V_T' ,'LegendEntry','$T_{0,T}$' );
simbio_plot(simData,'T0','CompartmentName','V_C' ,'LegendEntry','$T_{0,C}$' );
simbio_plot(simData,'T0','CompartmentName','V_LN','LegendEntry','$T_{0,LN}$');
simbio_plot(simData,'T0','CompartmentName','V_P','LegendEntry','$T_{0,P}$');
xlabel('Time (days)'); ylabel('Number of T0 Cells'); legend; set(gca, 'YScale', 'log');  ylim([1 inf]);

%% Plot everything that starts with specific "rate_C1" or "rate_T1" or "rate_T0"
subplot(2,3,4); hold on; box on;
for i = 1:length(simData.DataNames)
    if ~isempty(strfind(simData.DataNames{i},'rate_C1'))
        [~,temp,~] = selectbyname(simData, simData.DataNames{i});
        rateName = strrep(simData.DataNames{i},'_','\_');
        plot(simData.time, simData.Data(:,i), 'DisplayName',rateName)
        legend('-DynamicLegend'); legend('show');
        xlabel('Time (days)'); ylabel('Rates of C1 growth and death (cell/day)');  ylim([1 inf]);
    end
end
set(gca, 'YScale', 'log');


subplot(2,3,5); hold on; box on;
for i = 1:length(simData.DataNames)
    if ~isempty(strfind(simData.DataNames{i},'rate_T1'))
        [~,temp,~] = selectbyname(simData, simData.DataNames{i});
        rateName = strrep(simData.DataNames{i},'_','\_');
        plot(simData.time, simData.Data(:,i), 'DisplayName',rateName)
        legend('-DynamicLegend'); legend('show');
        xlabel('Time (days)'); ylabel('Rates of T1 entry and death (cell/day)');  ylim([1 inf]);
    end
end
set(gca, 'YScale', 'log');


subplot(2,3,6); hold on; box on;
for i = 1:length(simData.DataNames)
    if ~isempty(strfind(simData.DataNames{i},'rate_T0'))
        [~,temp,~] = selectbyname(simData, simData.DataNames{i});
        rateName = strrep(simData.DataNames{i},'_','\_');
        plot(simData.time, simData.Data(:,i), 'DisplayName',rateName)
        legend('-DynamicLegend'); legend('show');
        xlabel('Time (days)'); ylabel('Rates of T0 entry and death (cell/day)');  ylim([1 inf]);
    end
end
set(gca, 'YScale', 'log');
