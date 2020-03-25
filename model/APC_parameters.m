% Function to generate APC module parameters from default physical parameters
%
% Inputs: params_in  -- object containing the physical parameters
%                       - k_APC_mat--rate of APC maturation
%                       - k_APC_mig--rate of APC migration
%                       - k_APC_dth--rate of APC death
%                       - k_mAPC_dth--rate of mAPC death
%                       - APC0_T--baseline APC density in tumour
%                       - APC0_LN--baseline APC density in LN
%                       - k_c--cytokine time constant 
%                       - c0--baseline cytokine concentration
%                       - c50--cytokine concentration for half-maximal APC maturation
%
% Output: params_out -- object containing parameters
%                       - k_APC_mat--rate of APC maturation
%                       - k_APC_mig--rate of APC migration
%                       - k_APC_dth--rate of APC death
%                       - k_mAPC_dth--rate of mAPC death
%                       - APC0_T--baseline APC density in tumour
%                       - APC0_LN--baseline APC density in LN
%                       - k_c--cytokine time constant 
%                       - c0--baseline cytokine concentration
%                       - c50--cytokine concentration for half-maximal APC maturation
%
% Created: Nov 13, 2018 (Richard Sové)
% Last Modified: Nov 13, 2018 (RJS)

function params_out = APC_parameters(params_in)

% Rate of APC Maturation
params_out.k_APC_mat = params_in.k_APC_mat;
% Rate of APC Migration
params_out.k_APC_mig = params_in.k_APC_mig;
% Rate of APC Death
params_out.k_APC_death = params_in.k_APC_death;
% Rate of mAPC Death
params_out.k_mAPC_death = params_in.k_mAPC_death;
% APC Density in Tumour
params_out.APC0_T = params_in.APC0_T;
% APC Density in LN
params_out.APC0_LN = params_in.APC0_LN;
% Cytokine Time Constant 
params_out.k_c = params_in.k_c;
% Baseline Cytokine Concentration
params_out.c0 = params_in.c0;
% Cytokine Concentration for Half-Maximal APC Maturation
params_out.c50 = params_in.c50;
% Concentration of Cytokines Released by Cancer Cell Death
params_out.DAMPs = params_in.DAMPs;
% Maximum Number of T Cells an APC can Interact with
params_out.n_sites_APC = params_in.n_sites_APC;