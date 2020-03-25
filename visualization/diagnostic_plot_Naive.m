% SimBiology Diagnostic Plot Generator
%
% Plots SimBiology Data 
%
% Inputs: simData - SimBiology output data
%         model   - SimBiology model object
%         
% Created: Jan 30, 2019 (Mohammad Jafarnejad)
% Last Modified: Jan 30, 2019 (MJ) 

function diagnostic_plot_Naive(simData, model)

numClones = howManyClones(simData);
numMHC    = howManyMHC(simData);

f = figure;
% % Set the window in a specific size
% set(f0100,'Position', [50 50 1300 800]);
% Maximized window
set(f,'units','normalized','outerposition',[0 0 1 1])

%% Naive T cells in LN, Central, and Peripheral

subplot(2,4,1); hold on; box on;
for i =1:numClones
simbio_plot(simData,['nT',num2str(i)],'CompartmentName','V_C','LegendEntry',['$nT_{',num2str(i),',C}$']);
end
xlabel('Time (days)'); ylabel('Number of Cells'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);

subplot(2,4,2); hold on; box on;
for i =1:numClones
simbio_plot(simData,['nT',num2str(i)],'CompartmentName','V_LN','LegendEntry',['$nT_{',num2str(i),',LN}$']);
end
xlabel('Time (days)'); ylabel('Number of Cells'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);

subplot(2,4,3); hold on; box on;
for i =1:numClones
simbio_plot(simData,['nT',num2str(i)],'CompartmentName','V_P','LegendEntry',['$nT_{',num2str(i),',P}$']);
end
xlabel('Time (days)'); ylabel('Number of Cells'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);



subplot(2,4,4); hold on; box on;
for i =1:numClones
simbio_plot(simData,['T',num2str(i)],'CompartmentName','V_LN','LegendEntry',['$T_{',num2str(i),',eff,LN}$']);
end
xlabel('Time (days)'); ylabel('Number of Cells'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);

for i =1:numClones
simbio_plot(simData,['T',num2str(i)],'CompartmentName','V_C','LegendEntry',['$T_{',num2str(i),',eff,C}$']);
end
xlabel('Time (days)'); ylabel('Number of Cells'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);

for i =1:numClones
simbio_plot(simData,['T',num2str(i)],'CompartmentName','V_T','LegendEntry',['$T_{',num2str(i),',eff,T}$']);
end
xlabel('Time (days)'); ylabel('Number of Cells'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);

for i =1:numClones
simbio_plot(simData,['T',num2str(i)],'CompartmentName','V_P','LegendEntry',['$T_{',num2str(i),',eff,P}$']);
end
xlabel('Time (days)'); ylabel('Number of Cells'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);

%% Treg in LN, Central, Tumor, and Peripheral 
subplot(2,4,5); hold on; box on;
simbio_plot(simData,'nT0','CompartmentName','V_C' ,'LegendEntry','$T_{reg,C}$' );
xlabel('Time (days)'); ylabel('Number of Cells'); legend; set(gca, 'YScale', 'log');
subplot(2,4,6); hold on; box on;
simbio_plot(simData,'nT0','CompartmentName','V_LN','LegendEntry','$T_{reg,LN}$');
xlabel('Time (days)'); ylabel('Number of Cells'); legend; set(gca, 'YScale', 'log');
subplot(2,4,7); hold on; box on;
simbio_plot(simData,'nT0','CompartmentName','V_P','LegendEntry','$T_{reg,P}$');
xlabel('Time (days)'); ylabel('Number of Cells'); legend; set(gca, 'YScale', 'log');
subplot(2,4,8); hold on; box on;
simbio_plot(simData,'T0','CompartmentName','V_T' ,'LegendEntry','$T_{reg,T}$' );
simbio_plot(simData,'T0','CompartmentName','V_C' ,'LegendEntry','$T_{reg,C}$' );
simbio_plot(simData,'T0','CompartmentName','V_LN','LegendEntry','$T_{reg,LN}$');
simbio_plot(simData,'T0','CompartmentName','V_P','LegendEntry','$T_{reg,P}$');
xlabel('Time (days)'); ylabel('Number of Cells'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);
