% Function to generate cancer module parameters from default physical parameters
%
% Inputs: params_in  -- object containing the default parameters
%                       - V_C--volume of the central compartment
%                       - V_P--volume of the peripheral compartment
%                       - gamma_P--volume fraction of blood vessels in the peripheral compartment
%                       - gamma_T--volume fraction of blood vessels in the tumour compartment
%                       - D_LN--lymph node diameter
%                       - nLNs--number of lymph nodes
%                       - n_clones_CD4|n_clones_CD8--number of T cell clones
%                       - nT_div_CD4|nT_div_CD8--naive T cell diversity
%                       - q_in--rate of naive T cells into the LN
%                       - rho_nTCD4|rho_nTCD8--density of naive T cells
%                       - q_out--rate of naive T cells out of the LN
%                       - k_nTCD4|k_nTCD8--rate of naive T cell activation
%                       - k_pro_CD4|k_pro_CD8--rate of activated T cell proliferation
%                       - k_Treg_death|k_Teff_death--rate of mature T cell death
%                       - q_Treg_P_out|q_Teff_P_out--rate of T cell transport P->C
%                       - k_Treg_mig|k_Teff_mig--rate of T cell migration
%                       - rho_adh--adhesion site density
%                       - q_Treg_LN_out|q_Teff_LN_out--rate of T cell transport LN->C
%                       - k_Tcell--rate of cancer-T cell killing
%                       - k_Treg--reate of T cell death by Tregs
%                       - k_IL2_deg--rate of IL2 degradtion
%                       - k_IL2_cons--rate of IL2 consumption
%                       - k_IL2_sec--rate of IL2 secretion
%                       - IL2_50--IL2 concentration for half-maximal T cell activation
%                       - IL2_50_Treg--IL2 concentration for half-maximal Treg activation
%                       - N0--baseline number of activated T cell generations (no IL2)
%                       - N_IL2--maximum number of generations added due to IL2
%
% Output: params_out -- object containing parameters
%                       - n_clones--number of T cell clones
%                       - Q_in--rate of naive T cells into the LN
%                       - q_out--rate of naive T cells out of the LN
%                       - k_act--rate of naive T cell activation
%                       - k_pro--rate of activated T cell proliferation
%                       - k_death--rate of mature T cell death
%                       - q_P_in--rate of T cell transport C->P
%                       - q_P_out--rate of T cell transport P->C
%                       - q_T_in--rate of T cell transport C->T
%                       - q_LN_out--rate of T cell transport LN->C
%                       - k_Tcell--rate of cancer-T cell killing
%                       - k_Treg--reate of T cell death by Tregs
%                       - k_IL2_deg--rate of IL2 degradtion
%                       - k_IL2_cons--rate of IL2 consumption
%                       - k_IL2_sec--rate of IL2 secretion
%                       - IL2_50--IL2 concentration for half-maximal T cell activation
%                       - IL2_50_Treg--IL2 concentration for half-maximal Treg activation
%                       - N0--baseline number of activated T cell generations (no IL2)
%                       - N_IL2--maximum number of generations added due to IL2
%         isTreg     -- boolean indicating if model parameters should be calculated for Tregs
%
% Created: Oct 30, 2018 (Richard Sov�)
% Last Modified: Oct 3, 2019 (HW)

function params_out = Tcell_parameters(params_in,isTreg)

% Get T cell Type Specific Parameters
if (isTreg) % Treg
    % Number of T Cell Clones
    params_out.n_clones = params_in.n_clones_CD4;
    % T Cell Diversity
    nT_div = params_in.nT_div_CD4;
    % Naive T Cell Density
    rho_nT = params_in.rho_nTCD4;
    % T Cell Activation Rate
    k_act0 = params_in.k_nTCD4;
    % T Cell Proliferation Rate
    k_pro = params_in.k_pro_CD4;
    % T Cell Decay Rate
    k_death = params_in.k_Treg_death;
    % Transport P->C
    q_P_out = params_in.q_Treg_P_out;
    % Transport LN->C
    q_LN_out = params_in.q_Treg_LN_out;
    % Transmigration Rate
    k_mig = params_in.k_Treg_mig;
else % Teff
    % Number of T Cell Clones
    params_out.n_clones = params_in.n_clones_CD8;
    % T Cell Diversity
    nT_div = params_in.nT_div_CD8;
    % Naive T cell Density
    rho_nT = params_in.rho_nTCD8;
    % T Cell Activation Rate
    k_act0 = params_in.k_nTCD8;
    % T Cell Proliferation Rate
    k_pro = params_in.k_pro_CD8;
    % T cell Decay Rate
    k_death = params_in.k_Teff_death;
    % Transport P->C
    q_P_out = params_in.q_Teff_P_out;
    % Transport LN->C
    q_LN_out = params_in.q_Teff_LN_out;
    % Transmigration Rate
    k_mig = params_in.k_Teff_mig;
end

% Calculate Lymph Node Volume
V_LN = params_in.nLNs*4/3*pi*(params_in.D_LN/2)^3;

% Treg Flag
params_out.isTreg = isTreg;

% Naive T Cell Transport Rate C->LN
params_out.Q_in = params_in.q_in*rho_nT*params_in.V_C*V_LN/nT_div;
params_out.Q_in.Notes = ['calculated based on naive T cell entry rate ' params_in.q_in.Notes ', T cell density in the blood ' rho_nT.Notes ' and T cell diversity ' nT_div.Notes];
% Naive T Cell Transport Rate LN->C
params_out.q_out = params_in.q_out;
% Naive T Cell Activation
params_out.k_act = k_act0;
params_out.k_act.Notes = ['calculated based on the rate of T cell activation ' k_act0.Notes ];
% Naive T Cell Proliferation
params_out.k_pro = k_pro;
% T cell Death
params_out.k_death = k_death;
% T cell Transport C->P
params_out.q_P_in = k_mig*params_in.rho_adh*params_in.gamma_P*params_in.V_P;
params_out.q_P_in.Notes = ['calculated based on T cell transmigration rate ' k_mig.Notes ' and T cell adhesion density ' params_in.rho_adh.Notes];
% T cell Transport P->C
params_out.q_P_out = q_P_out;
% T cell Transport C->T
params_out.q_T_in = k_mig*params_in.rho_adh*params_in.gamma_T;
params_out.q_T_in.Notes = ['calculated based on T cell transmigration rate ' k_mig.Notes ' and T cell adhesion density ' params_in.rho_adh.Notes];
% T cell Transport LN->C
params_out.q_LN_out = q_LN_out;

% Cancer cell death by T cells
params_out.k_C_Tcell = params_in.k_C_Tcell;

% T cell exhaustion rate by cancer cells
params_out.k_Tcell = params_in.k_Tcell;

% T cell death rate by Tregs
params_out.k_Treg = params_in.k_Treg;

% IL2 Parameters
% IL2 Degradation Rate
params_out.k_IL2_deg = params_in.k_IL2_deg;
% IL2 Consumption Rate
params_out.k_IL2_cons = params_in.k_IL2_cons;
% IL2 Secretion Rate
params_out.k_IL2_sec = params_in.k_IL2_sec;
% IL2 Concentration for Half-Maximal T Cell Proliferation
params_out.IL2_50 = params_in.IL2_50;
% IL2 Concentration for Half-Maximal Treg Proliferation
params_out.IL2_50_Treg = params_in.IL2_50_Treg;
% Baseline Number of Activated T Cell Generations by TCR Signaling
params_out.N0 = params_in.N0;
% Baseline Number of Activated T Cell Generations by Co-stimulatory Signaling
params_out.N_costim = params_in.N_costim;
% Additional Number of Activated T Cell Generations Due to IL2
params_out.N_IL2 = params_in.N_IL2;
