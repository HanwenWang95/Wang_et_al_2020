% SimBiology Diagnostic Plot Generator
%
% Plots SimBiology Data 
%
% Inputs: simData - SimBiology output data
%         model   - SimBiology model object
%         
% Created: Jan 30, 2019 (Mohammad Jafarnejad)
% Last Modified: Jan 30, 2019 (MJ) 

function diagnostic_plot(simData, model)

numClones = howManyClones(simData);
numMHC    = howManyMHC(simData);

f = figure;
% % Set the window in a specific size
% set(f0100,'Position', [50 50 1300 800]);
% Maximized window
set(f,'units','normalized','outerposition',[0 0 1 1])

%% Tumor growth and antigens
subplot(3,5,1); hold on; box on;
simbio_plot(simData,'C1');
xlabel('Time (days)'); ylabel('Number of Cancer Cells'); set(gca, 'YScale', 'log'); %ylim([1 1e12]);

subplot(3,5,2); hold on; box on;
yyaxis left
simbio_plot(simData,'V_T');
xlabel('Time (days)'); ylabel('Tumour Volume'); set(gca, 'YScale', 'log'); %ylim([1 1e12]);
yyaxis right
[~,V_T,~] = selectbyname(simData, 'V_T');
D_T = 2/10*(3/(4*pi)*V_T).^(1/3); % in cm after division by 10
plot(simData.time, D_T)
ylabel('Tumour Size (cm)');

subplot(3,5,3); hold on; box on;
for i =0:numClones
simbio_plot(simData,[ 'P',num2str(i)],'CompartmentName','V_LN','LegendEntry',['P',num2str(i)]);
end
xlabel('Time (days)'); ylabel('Protein Concentration (M)'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);

%% Antigen presentation
subplot(3,10,7); hold on; box on;
for i =0:numClones
simbio_plot(simData,['P',num2str(i)],'CompartmentName','V_e','LegendEntry',['$P_',num2str(i) '$']);
end
xlabel('Time (days)'); ylabel(''); title('P in endo (M)'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);

subplot(3,10,8); hold on; box on;
for i =0:numClones
simbio_plot(simData,['p',num2str(i)],'CompartmentName','V_e','LegendEntry',['$p_',num2str(i) '$']);
end
xlabel('Time (days)'); ylabel(''); title('p in endo (M)'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);

subplot(3,10,9); hold on; box on;
A_APC = sbioselect(model,'name','A_APC');
A_e = sbioselect(model,'name','A_e');
for j =1:numMHC
for i =0:numClones
simbio_plot(simData,['M',num2str(j),'p',num2str(i)],'CompartmentName','A_e','LegendEntry',['$M_',num2str(j),'-P_',num2str(i) '$'],'surfaceArea',num2str(A_e.Capacity));
end
simbio_plot(simData,['M',num2str(j)],'CompartmentName','A_e','LegendEntry',['$M',num2str(j),'$'],'surfaceArea',num2str(A_e.Capacity));
end
xlabel('Time (days)'); ylabel(''); title('Mp on endo (\#)'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);

subplot(3,10,10); hold on; box on;
for j =1:numMHC
for i =0:numClones
simbio_plot(simData,['M',num2str(j),'p',num2str(i)],'CompartmentName','A_s','LegendEntry',['$M_',num2str(j),'-P_',num2str(i) '$'],'surfaceArea',num2str(A_APC.value));
end
simbio_plot(simData,['M',num2str(j)],'CompartmentName','A_s','LegendEntry',['$M',num2str(j),'$'],'surfaceArea',num2str(A_APC.value));
end
xlabel('Time (days)'); ylabel(''); title('Mp on surf (\#)'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);

%% Teff in LN, Central, Tumor, and Peripheral
subplot(3,5,6); hold on; box on;
for i =1:numClones
simbio_plot(simData,['T',num2str(i)],'CompartmentName','V_LN','LegendEntry',['$T_{',num2str(i),',eff,LN}$']);
end
xlabel('Time (days)'); ylabel('Number of Cells'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);

subplot(3,5,7); hold on; box on;
for i =1:numClones
simbio_plot(simData,['T',num2str(i)],'CompartmentName','V_C','LegendEntry',['$T_{',num2str(i),',eff,C}$']);
end
xlabel('Time (days)'); ylabel('Number of Cells'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);

subplot(3,5,8); hold on; box on;
for i =1:numClones
simbio_plot(simData,['T',num2str(i)],'CompartmentName','V_T','LegendEntry',['$T_{',num2str(i),',eff,T}$']);
end
xlabel('Time (days)'); ylabel('Number of Cells'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);

subplot(3,5,9); hold on; box on;
for i =1:numClones
simbio_plot(simData,['T',num2str(i)],'CompartmentName','V_P','LegendEntry',['$T_{',num2str(i),',eff,P}$']);
end
xlabel('Time (days)'); ylabel('Number of Cells'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);

%% Treg in LN, Central, Tumor, and Peripheral 
subplot(3,5,10); hold on; box on;
simbio_plot(simData,'T0','CompartmentName','V_T' ,'LegendEntry','$T_{reg,T}$' );
simbio_plot(simData,'T0','CompartmentName','V_C' ,'LegendEntry','$T_{reg,C}$' );
simbio_plot(simData,'T0','CompartmentName','V_LN','LegendEntry','$T_{reg,LN}$');
simbio_plot(simData,'T0','CompartmentName','V_P','LegendEntry','$T_{reg,P}$');
xlabel('Time (days)'); ylabel('Number of Cells'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);

%% IL2 and Number of generations
subplot(3,10,21); hold on; box on;
simbio_plot(simData,'IL2','CompartmentName','V_LN' ,'LegendEntry','$IL2 in LN$' );
xlabel('Time (days)'); ylabel('IL2 Concentration'); set(gca, 'YScale', 'log'); 
subplot(3,10,22); hold on; box on;
simbio_plot(simData,'N_aT');
xlabel('Time (days)'); ylabel('');title('Number of gen'); 

%% Antigen Presenting Cells
subplot(3,5,12); hold on; box on;
simbio_plot(simData,'APC' ,'CompartmentName','V_T' ,'LegendEntry','$APC_{T}$'  );
simbio_plot(simData,'mAPC','CompartmentName','V_T' ,'LegendEntry','$mAPC_{T}$' );
simbio_plot(simData,'APC' ,'CompartmentName','V_LN','LegendEntry','$APC_{LN}$' );
simbio_plot(simData,'mAPC','CompartmentName','V_LN','LegendEntry','$mAPC_{LN}$');
xlabel('Time (days)'); ylabel(''); title('Number of Cells'); legend; set(gca, 'YScale', 'log');

%% Checkpoints and drugs
subplot(3,5,13); hold on; box on;
simbio_plot(simData,'nivo','CompartmentName','V_C','LegendEntry','nivolumab' );
simbio_plot(simData,'durv','CompartmentName','V_C','LegendEntry','durvalumab');
simbio_plot(simData,'ipi','CompartmentName','V_C','LegendEntry','ipilimumab');
xlabel('Time (days)'); ylabel('Concentration (M)');legend;


A_syn = sbioselect(model,'name','A_syn');
subplot(3,5,14); hold on; box on;
simbio_plot(simData,'PD1_PDL1','CompartmentName','syn_T_C1' ,'LegendEntry','[PD1-PDL1]' ,'surfaceArea',num2str(A_syn.Value));
simbio_plot(simData,'PD1_PDL2','CompartmentName','syn_T_C1' ,'LegendEntry','[PD1-PDL2]' ,'surfaceArea',num2str(A_syn.Value));
simbio_plot(simData,'PD1_nivo','CompartmentName','syn_T_C1' ,'LegendEntry','[PD1-Nivo]' ,'surfaceArea',num2str(A_syn.Value));
simbio_plot(simData,'PDL1_durv','CompartmentName','syn_T_C1','LegendEntry','[PDL1-Durv]','surfaceArea',num2str(A_syn.Value));
xlabel('Time (days)'); ylabel('Molecules in synapse'); legend; set(gca, 'YScale', 'log');

subplot(3,5,15); hold on; box on;
simbio_plot(simData,'CD28_CD80','CompartmentName','syn_T_C1' ,'LegendEntry','[CD28-CD80]' ,'surfaceArea',num2str(A_syn.Value));
simbio_plot(simData,'CD28_CD86','CompartmentName','syn_T_C1' ,'LegendEntry','[CD28-CD86]' ,'surfaceArea',num2str(A_syn.Value));
simbio_plot(simData,'CD80_CTLA4','CompartmentName','syn_T_C1' ,'LegendEntry','[CTLA4-CD80]' ,'surfaceArea',num2str(A_syn.Value));
simbio_plot(simData,'CD86_CTLA4','CompartmentName','syn_T_C1' ,'LegendEntry','[CTLA4-CD86]' ,'surfaceArea',num2str(A_syn.Value));
simbio_plot(simData,'TPDL1_CD80','CompartmentName','syn_T_C1' ,'LegendEntry','[CD80-PDL1]' ,'surfaceArea',num2str(A_syn.Value));
simbio_plot(simData,'CTLA4_ipi','CompartmentName','syn_T_C1' ,'LegendEntry','[CTLA4-Ipi]' ,'surfaceArea',num2str(A_syn.Value));
xlabel('Time (days)'); ylabel('Molecules in synapse'); legend; set(gca, 'YScale', 'log');
