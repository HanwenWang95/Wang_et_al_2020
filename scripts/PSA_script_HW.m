% Immune Oncology Model Parameter Sensitivity Analysis
%
% Script for setting up and running parameter sensitivity problem
%
% Created: Aug 18, 2018 (Hanwen Wang)
% Last Modified: Oct 3, 2019 (HW)

%% Create the model if not already present
% start fresh
close all hidden
clear all
clc

% Create the model
immune_oncology_model

% Define dosing
% dose_schedule = [];
% dose_schedule = schedule_dosing({'entinostat'},'entinostat_dose',5); % N/A
% dose_schedule = schedule_dosing({'nivolumab'},'nivolumab_schedule',[14,14,60]);
% dose_schedule = schedule_dosing({'nivolumab','entinostat'},'entinostat_dose',3,'nivolumab_dose',1,'nivolumab_schedule',[14,14,60]);
% dose_schedule = schedule_dosing({'nivolumab','entinostat'},'entinostat_dose',3,'nivolumab_schedule',[14,14,60]);
dose_schedule = schedule_dosing({'nivolumab','entinostat'},'entinostat_dose',5,'nivolumab_schedule',[14,14,60]);
% dose_schedule = schedule_dosing({'nivolumab','ipilimumab','entinostat'},'entinostat_dose',3,'ipilimumab_schedule',[14,42,3],'nivolumab_schedule',[14,14,60]);
% dose_schedule = schedule_dosing({'nivolumab','ipilimumab','entinostat'},'entinostat_dose',5,'ipilimumab_schedule',[14,42,3],'nivolumab_schedule',[14,14,60]);

%% Define and Prepare the Input and Output Parameters
% Generate Parameter Sets
n_PSA = 1500;

params_in  = PSA_param_in_HW;
params_out = PSA_param_out(model);
params_in  = PSA_param_obs(params_in);
params_in  = PSA_setup(model,params_in,n_PSA);

%% Run Batch Simulations
tic
% Single core simulations
[simDataPSA, params_out] = simbio_PSA(model,params_in,params_out,dose_schedule);

% Parallel simulations
% p = parpool(2); % use to setup parpool, matlab automatically assigns with
% the default numbers if not used
% find number of available cores using: feature('numcores')
% [simDataPSA, params_out] = simbio_PSA_parallel(model,params_in,params_out,dose_schedule);
toc

%% Postprocess
% Postprocess Data -> Calculate Clonality, Percentages and ...
simDataPSApost = PSA_post(simDataPSA,params_in,params_out);

% Add pre-treatment observables to the params_in
params_in = PSA_preObs(simDataPSA,simDataPSApost,params_in,params_out);

% Prepare the data for the rest of the analysis
params_out = PSA_prep(simDataPSA,simDataPSApost,params_out);

%% Perform and plot different types of analysis

% Principle Component Analysis
% % PSA_PCA(simDataPSA,params_in)

% t-SNE Analysis
% PSA_tSNE(params_in,params_out,'plausible')
% PSA_tSNE(params_in,params_out,'patient')
% PSA_tSNE(params_in,params_out)

% Partial Rank Correlation Coefficients`
% PSA_PRCC(params_in,params_out,'plausible')
PSA_PRCC(params_in,params_out)

% eFAST

%% Plot Results
% close all
% Plot percent change in size and RECIST
PSA_plot_RECIST(simDataPSA,simDataPSApost,params_out)

% Tumor Size
% PSA_plot_TumSize(simDataPSA,simDataPSApost,params_out)
%%
% Kaplan-Meier Progression-free survival (PFS)
% PSA_plot_KaplanMeier(simDataPSA,simDataPSApost,params_out)

% %% Plot T cells in Central
% figure; hold on;
% for i = 1:length(params_out.iPatient)
%     j = params_out.iPatient(i);
%     simbio_plot(simDataPSA(j).simData,'ipi','CompartmentName','V_C');
% end
% xlabel('Time (days)'); ylabel('Number of T1 Cells in Central'); legend; set(gca, 'YScale', 'log'); %ylim([1 1e12]);

% %% Plot Tumor size in initial not met
% n_PSA = length(params_out.iHealthy);
% index = params_out.iHealthy;
% figure; hold on; box on;
% time = simDataPSA(index(1)).simData.Time/30;
% j = [find(strcmp(simDataPSApost(index(1)).simData.DataNames,'D_T') )];
% for i =1:n_PSA
%     plot(simDataPSA(index(i)).simData.Time/30, ...
%          simDataPSApost(index(i)).simData.Data(:,j) ,'DisplayName',num2str(index(i)), 'LineWidth', 2)
% end
% xlabel('Time (month)','Fontsize',12); ylabel('Tumor size (mm)','Fontsize',12); xlim([0  max(time)]); set(gca,'Fontsize',14);

%%
% Plot percent change in size using waterfall plots for a parameter
PSA_plot_Waterfall(simDataPSApost,model,params_in,params_out,'n_T1_clones')
% PSA_plot_Waterfall(simDataPSApost,model,params_in,params_out,'k_T1')
% PSA_plot_Waterfall(simDataPSApost,model,params_in,params_out,'k_C_T1')
PSA_plot_Waterfall(simDataPSApost,model,params_in,params_out,'k_P1_d1')
% PSA_plot_Waterfall(simDataPSApost,model,params_in,params_out,'k_CTLA4_ADCC')
% PSA_plot_Waterfall(simDataPSApost,model,params_in,params_out,'k_Treg')
%%
% PSA_plot_Waterfall_color(simDataPSApost,model,params_in,params_out,[.2 .4 .7]) % nivo (blue)
% PSA_plot_Waterfall_color(simDataPSApost,model,params_in,params_out,[.2 .6 .4]) % ipi (green)
% PSA_plot_Waterfall_color(simDataPSApost,model,params_in,params_out,[.8 .6 .2]) % nivo + ipi (yellow/orange)
