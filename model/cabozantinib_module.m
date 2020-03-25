% Cabozantinib Module
%
% Models Cabozantinib     [note: use module once]
%
% Requirements: cancer_module and Tcell_module 
%
% Inputs: model     -- SimBiology model object with four compartments 
%         params    -- object containing model parameter Values, Units, and Notes:
%                      - cabo_50_g
%                      - cabo_50_v
%         pk_params -- object containing pk parameters for cabozantinib
%        
% Outputs: model -- SimBiology model object with new cabo module
%
% Created: Feb 12, 2019 (Richard Sové)
% Last Modified: Feb 26, 2019 (RJS)

function model = cabozantinib_module(model,cancers,Tcells,params,pk_params)

% Get Tumour Compartment
comp_T = model.Compartment(3);

% Pharmacokinetics
model = pk_module(model,'cabo',pk_params);

% Add Cabo Hill Functions
p = addparameter(model,'cabo_50_g',params.cabo_50_g.Value,'ValueUnits',params.cabo_50_g.Units);
    set(p,'Notes',['Cabozantinib concentration for half-maximal cancer cell growth reduction ' params.cabo_50_g.Notes]);
p = addparameter(model,'cabo_50_v',params.cabo_50_v.Value,'ValueUnits',params.cabo_50_v.Units);
    set(p,'Notes',['Cabozantinib concentration for half-maximal vessel co-option ' params.cabo_50_v.Notes]);
p = addparameter(model,'H_cabo_g',0,'ValueUnits','dimensionless','ConstantValue',false);
    set(p,'Notes','Hill function for cabozantinib cancer cell growth reduction');
p = addparameter(model,'H_cabo_v',0,'ValueUnits','dimensionless','ConstantValue',false);
    set(p,'Notes','Hill function for cabozantinib vessel co-option');
addrule('H_cabo_g = cabo/(cabo+cabo_50_g)','repeatedAssignment');
addrule('H_cabo_v = cabo/(cabo+cabo_50_v)','repeatedAssignment');

% Vascular Co-option
% Add Species
p = addparameter(comp_T,'gamma_n',0,'InitialAmountUnits','dimensionless');
    set(p,'Notes','fraction of normal blood vessels in tumour');
p = addparameter(comp_T,'gamma_a',params.gamma_a.Value,'InitialAmountUnits','dimensionless');
    set(p,'Notes','fraction of abnormal blood vessels in tumour');
% Add Equations
k_C_growth = '';
for i = 1:length(cancers)
    k_C_growth = sprintf('%s+k_%s_growth',k_C_growth,cancers{i});
end
k_C_growth = ['(' k_C_growth ')']; 
addrule([k_C_growth '*((1-H_cabo_v)*(1-H_cabo_g)*gamma_a0 - (1-H_g)*gamma_a)'],'RateRules');
addrule([k_C_growth '*(H_cabo_v*(1-H_cabo_g) - (1-H_g)*gamma_n)'],'RateRules');

% Slow Cancer Growth Rate
for i = 1:length(cancers)
    R = addreaction(model,['V_T.' cancers{i} ' -> null']);
        set(R,'ReactionRate',['H_cabo_g*k_' cancers{i} '_growth*V_T.' cancers{i} '*(1-C_Total/C_max)']);
end

% Modify T Cell Infiltration
for i = 1:length(Tcells)
    R = addreaction(model,['V_T.' Tcells{i} ' -> V_C.' Tcells{i}]); % Remove old transport rate
        set(R,'ReactionRate',['q_' Tcells{i} '_T_in*V_T*V_C.' Tcells{i}]);
    R = addreaction(model,['V_C.' Tcells{i} ' -> V_T.' Tcells{i}]); % Add new transport rate
        set(R,'ReactionRate',['k_' Tcells{i} '_mig*(rho_adh_n*gamma_n+rho_adh_a*gamma_a)*V_T*V_C.' Tcells{i}]);
end