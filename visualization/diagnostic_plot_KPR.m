% SimBiology Diagnostic Plot Generator
%
% Plots SimBiology Data 
%
% Inputs: simData - SimBiology output data
%         model   - SimBiology model object
%
%         
% Created: May 08, 2019 (Mohammad Jafarnejad)
% Last Modified: May 08, 2019 (MJ) 

function diagnostic_plot_KPR(simData,model)

numClones = howManyClones(simData);
numMHC    = howManyMHC(simData);

f = figure;
% % Set the window in a specific size
% set(f,'Position', [50 50 1300 800]);
% Maximized window
set(f,'units','normalized','outerposition',[0 0 1 1])

%% Tumor growth and antigens
subplot(3,5,1); hold on; box on;
for i =0:numClones
simbio_plot(simData,[ 'P',num2str(i)],'CompartmentName','V_LN','LegendEntry',['P',num2str(i)]);
end
xlabel('Time (days)'); ylabel('Protein Concentration (M)'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);

%% Antigen presentation
subplot(3,5,2); hold on; box on;
for i =0:numClones
simbio_plot(simData,['P',num2str(i)],'CompartmentName','V_e','LegendEntry',['$P_',num2str(i) '$']);
end
xlabel('Time (days)'); ylabel(''); title('P in endo (M)'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);

subplot(3,5,3); hold on; box on;
for i =0:numClones
simbio_plot(simData,['p',num2str(i)],'CompartmentName','V_e','LegendEntry',['$p_',num2str(i) '$']);
end
xlabel('Time (days)'); ylabel(''); title('p in endo (M)'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);

subplot(3,5,4); hold on; box on;
A_APC = sbioselect(model,'name','A_APC');
A_e = sbioselect(model,'name','A_e');
for j =1:numMHC
for i =0:numClones
simbio_plot(simData,['M',num2str(j),'p',num2str(i)],'CompartmentName','A_e','LegendEntry',['$M_',num2str(j),'-P_',num2str(i) '$']);
end
simbio_plot(simData,['M',num2str(j)],'CompartmentName','A_e','LegendEntry',['$M',num2str(j),'$']);
end
xlabel('Time (days)'); ylabel(''); title('Mp on endo ($\#/\mu m^2$)'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);

subplot(3,5,5); hold on; box on;
for j =1:numMHC
for i =0:numClones
simbio_plot(simData,['M',num2str(j),'p',num2str(i)],'CompartmentName','A_s','LegendEntry',['$M_',num2str(j),'-P_',num2str(i) '$']);
end
simbio_plot(simData,['M',num2str(j)],'CompartmentName','A_s','LegendEntry',['$M',num2str(j),'$']);
end
xlabel('Time (days)'); ylabel(''); title('Mp on surf ($\#/\mu m^2$)'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);

%% p0
subplot(3,5,6); hold on; box on;
simbio_plot(simData,'H_P0');
xlabel('Time (days)'); ylabel('H\_P0');

subplot(3,5,7); hold on; box on;
simbio_plot(simData,'pTCR_p0_MHC_tot');
xlabel('Time (days)'); ylabel('pTCR\_p0\_MHC\_tot ($\#/\mu m^2$)'); set(gca,'Yscale','log')

subplot(3,5,8); hold on; box on;
p = sbioselect(model,'name','TCR_p0_tot');
plot(simData.time,ones(size(simData.time)).* p.value)
xlabel('Time (days)'); ylabel('TCR\_p0\_tot ($\#/\mu m^2$)'); set(gca,'Yscale','log')

subplot(3,5,9); hold on; box on;
p = sbioselect(model,'name','p0_50');
plot(simData.time,ones(size(simData.time)).* p.value)
xlabel('Time (days)'); ylabel('p0\_50 ($\#/\mu m^2$)'); set(gca,'Yscale','log')

subplot(3,5,10); hold on; box on;
p1 = sbioselect(model,'name','k_M1p0_TCR_on');
p2 = sbioselect(model,'name','k_M1p0_TCR_off');
plot(simData.time,ones(size(simData.time)).* p2.value./p1.value)
simbio_plot(simData,'M1p0','CompartmentName','A_s','LegendEntry','M1p0');
p = sbioselect(model,'name','TCR_p0_tot');
plot(simData.time,ones(size(simData.time)).* p.value)
legend('$K\_d$','$M1p0$','$TCR\_{tot}$','location','Southeast')
xlabel('Time (days)'); ylabel('TCR components ($\#/\mu m^2$)'); set(gca,'Yscale','log')


%% p1

subplot(3,5,11); hold on; box on;
simbio_plot(simData,'H_P1');
xlabel('Time (days)'); ylabel('H\_P1');

subplot(3,5,12); hold on; box on;
simbio_plot(simData,'pTCR_p1_MHC_tot');
xlabel('Time (days)'); ylabel('pTCR\_p1\_MHC\_tot ($\#/\mu m^2$)'); set(gca,'Yscale','log')

subplot(3,5,13); hold on; box on;
p = sbioselect(model,'name','TCR_p1_tot');
plot(simData.time,ones(size(simData.time)).* p.value)
xlabel('Time (days)'); ylabel('TCR\_p1\_tot ($\#/\mu m^2$)'); set(gca,'Yscale','log')

subplot(3,5,14); hold on; box on;
p = sbioselect(model,'name','p1_50');
plot(simData.time,ones(size(simData.time)).* p.value)
xlabel('Time (days)'); ylabel('p1\_50 ($\#/\mu m^2$)'); set(gca,'Yscale','log')

subplot(3,5,15); hold on; box on;
p1 = sbioselect(model,'name','k_M1p1_TCR_on');
p2 = sbioselect(model,'name','k_M1p1_TCR_off');
plot(simData.time,ones(size(simData.time)).* p2.value./p1.value)
simbio_plot(simData,'M1p1','CompartmentName','A_s','LegendEntry','M1p1');
p = sbioselect(model,'name','TCR_p1_tot');
plot(simData.time,ones(size(simData.time)).* p.value)
legend('$K\_d$','$M1p1$','$TCR\_{tot}$','location','Southeast')
xlabel('Time (days)'); ylabel('TCR components ($\#/\mu m^2$)'); set(gca,'Yscale','log')
