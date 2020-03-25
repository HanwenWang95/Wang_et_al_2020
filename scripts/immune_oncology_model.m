%% Immune Oncology Model
%
% Script for setting up and running the immune oncology model in simbiology
%
% Created: Mar 8, 2018 (Hanwen Wang)
% Last Modified: Oct 3, 2019 (HW)
clear all
close all

%% Makes sure "cell" unit is defined in both Simbiology and Symbolic libraries
% Add 'cell' unit to SimBiology and Symbolic Toolboxes
% SimBiology

if (isempty(sbioshowunits('cell')))
    cell_unit = sbiounit('cell','molecule');
    sbioaddtolibrary(cell_unit);
end
% Symbolic Unit
u = symunit;
try u.cell;
catch
    newUnit('cell',u.molecule);
end
    
if (isempty(sbioshowunits('mU')))
    mU_unit = sbiounit('mU','molarity');
    sbioaddtolibrary(mU_unit);
end
% Symbolic Unit
u = symunit;
try u.mU;
catch
    newUnit('mU',u.molarity);
end

%% Setup Parameters
% Setup Parameters
params         = default_parameters_TNBC;
params_comp    = compartment_parameters(params);
params_C1      = cancer_parameters(params);
params_Teff    = Tcell_parameters(params,false);
params_Treg    = Tcell_parameters(params,true);
params_APC     = APC_parameters(params);
params_P       = antigen_parameters(params);
params_checkpoint_T_C   = checkpoint_parameters(params,'T','C1');
params_checkpoint_T_APC = checkpoint_parameters(params,'T','APC');
params_ADCC = Treg_ADCC_parameters(params);
params_nivo = pk_parameters('nivolumab');
params_durv = pk_parameters('durvalumab');
params_ipi  = pk_parameters('ipilimumab');
params_ENT  = pk_parameters('entinostat');
% TNBC
params_MDSC  = MDSC_parameters(params);

antigenCP = create_antigen({'C1'},10e-9,'antigenID',0);
antigen   = create_antigen({'C1'},10e-9,'antigenID',1);

%% Create the SimBiology Model
% Model Settings
model_name = 'Immune Oncology Model';
start_time = 0.0; % [days]
time_step = 1; % [days] 0.01 days ~ 15 mins
end_time = 400; % [days]
absolute_tolerance = 1e-12;
relative_tolerance = 1e-6;
solver = 'ode15s';
% solver = 'sundial';
% Model Object
time = start_time:time_step:end_time;
model = simbio_init(model_name,time,solver,absolute_tolerance,relative_tolerance,params_comp);

%% Add Modules to the Model
% Add Modules
model = cancer_module(model,'C1',params_C1);
model = Tcell_module(model,'0',params_Treg);
model = Tcell_module(model,'1',params_Teff,{'C1'});
model = APC_module(model,params_APC);
model = antigen_module(model,'0',params_P,antigenCP);
model = antigen_module(model,'1',params_P,antigen);
model = checkpoint_module(model,params_checkpoint_T_C,  'T','C1' ,params_nivo,params_durv,params_ipi);
model = checkpoint_module(model,params_checkpoint_T_APC,'T','APC',params_nivo,params_durv,params_ipi);
model = Treg_ADCC_module(model,params_ADCC);

% TNBC
model = MDSC_module(model,params_MDSC);
model = pk_module(model,'ENT',params_ENT,'o');

% modelTest = copyobj(model);
% modelTest = rates_diagnostic(modelTest);

%% Setup Dosing
% Dosing
dose_schedule = [];
% dose_schedule = schedule_dosing({'entinostat'},'entinostat_dose',5);
% dose_schedule = schedule_dosing({'nivolumab'},'nivolumab_schedule',[14,14,60]);
% dose_schedule = schedule_dosing({'nivolumab','entinostat'},'entinostat_dose',5,'nivolumab_schedule',[14,14,60]);
% dose_schedule = schedule_dosing({'nivolumab','ipilimumab','entinostat'},'entinostat_dose',3,'ipilimumab_schedule',[14,42,3],'nivolumab_schedule',[14,14,60]);

% dose_schedule.Active = false;

%% Initialize and Run the Model
% Initial Conditions
tic
[model,success,simDataInit] = initial_conditions(model);
% [model,success] = initial_conditions(model);
toc

% Generate a list of parameters and species for debug
modelComp = listModelComp(model);

% Run Simulation
if (success)
    tic
    simData = sbiosimulate(model,[],[],dose_schedule);
    toc
else
    simData = simDataInit;
    disp('Tumour did not reach specified initial tumour diameter with current parameters');
end
%% Plots
% Plot diagnostics
% if (success)
%     diagnostic_plot(simData,model);
%     diagnostic_plot_H(simData);
%     simbio_plotpk(simData,'ipi')
%    diagnostic_plot_KPR(simData,model);
    %% Checkpoints and drugs
%     figure; hold on; box on;
%       simbio_plot(simData,'ENT_ngml','CompartmentName','V_C','LegendEntry','entinostat');
%     	xlabel('Time (days)'); ylabel('Concentration (ng/mL)');legend;
%     figure
%     [~,temp,~] = selectbyname(simData, 'H_PD1_C1');
%     plot(simData.time, temp)
%
% figure; hold on; box on;
% simbio_plot(simData,'nivo','CompartmentName','V_C','LegendEntry','nivolumab' );
% simbio_plot(simData,'durv','CompartmentName','V_C','LegendEntry','durvalumab');
% simbio_plot(simData,'ipi','CompartmentName','V_C','LegendEntry','ipilimumab');
% xlabel('Time (days)'); ylabel('Concentration (M)');legend;legend('Location','eastOutside')
%
% figure; hold on; box on;
% simbio_plot(simData,'PD1_PDL1','CompartmentName','syn_T1_C1' ,'LegendEntry','[PD1-PDL1]' );
% simbio_plot(simData,'PD1_PDL2','CompartmentName','syn_T1_C1' ,'LegendEntry','[PD1-PDL2]' );
% simbio_plot(simData,'PD1_nivo','CompartmentName','syn_T1_C1' ,'LegendEntry','[PD1-Nivo]' );
% simbio_plot(simData,'PDL1_durv','CompartmentName','syn_T1_C1','LegendEntry','[PDL1-Durv]');
% xlabel('Time (days)'); ylabel('Molecules in synapse'); legend;legend('Location','eastOutside')
%
% figure; hold on; box on;
% simbio_plot(simData,'CD28_CD80','CompartmentName','syn_T1_C1' ,'LegendEntry','[CD28-CD80]' );
% simbio_plot(simData,'CD28_CD86','CompartmentName','syn_T1_C1' ,'LegendEntry','[CD28-CD86]' );
% simbio_plot(simData,'CTLA4_CD80','CompartmentName','syn_T1_C1' ,'LegendEntry','[CTLA4-CD80]' );
% simbio_plot(simData,'CTLA4_CD86','CompartmentName','syn_T1_C1' ,'LegendEntry','[CTLA4-CD86]' );
% simbio_plot(simData,'CD80_TPDL1','CompartmentName','syn_T1_C1' ,'LegendEntry','[CD80-PDL1]' );
% simbio_plot(simData,'CTLA4_ipi','CompartmentName','syn_T1_C1' ,'LegendEntry','[CTLA4-Ipi]' );
% xlabel('Time (days)'); ylabel('Molecules in synapse'); legend;legend('Location','eastOutside')

% end
