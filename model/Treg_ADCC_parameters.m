% Function to generate checkpoint module parameters from physical parameters
%
% Inputs: params_in  -- object containing the default parameters 
%
% Output: params_out -- object containing parameters to be used for a
%                       Treg-CTLA4 module
%
% Created: Mar 04, 2019 (Mohammad Jafarnejad)
% Last Modified: Mar 04, 2019 (MJ)

function params_out = Treg_ADCC_parameters(params_in)

% CTLA4 rates
% kon Values
params_out.kon_CTLA4_ipi   = params_in.kon_CTLA4_ipi ;
params_out.kon_CTLA4_ipi.Notes   = ['kon for CTLA4-ipilimumab ' params_in.kd_CTLA4_ipi.Notes];
% koff Values
params_out.koff_CTLA4_ipi   = params_in.kon_CTLA4_ipi * params_in.kd_CTLA4_ipi;
params_out.koff_CTLA4_ipi.Notes   = ['calculated based on the measured kd and kon ' params_in.kd_CTLA4_ipi.Notes];
% Bivalent antibody - antibody cross-arm binding efficiency 
params_out.Chi_CTLA4_ipi = params_in.Chi_CTLA4_ipi/(params_in.d_syn*params_in.N_avg);
params_out.Chi_CTLA4_ipi.Notes = [' that also includes the conversion of kon from 3D to 2D' params_in.Chi_CTLA4_ipi.Notes];

% Checkpoint Expression
params_out.Treg_CTLA4_tot = params_in.Treg_CTLA4_tot;

% Surface Area of Tregs
params_out.A_Tcell = 4*pi*(params_in.D_Tcell/2)^2;
params_out.A_Tcell.Notes = ['calculated based on the average T cell diameter ' params_in.D_Tcell.Notes];

% Hill Function Parameters
params_out.Treg_CTLA4_50 = params_in.Treg_CTLA4_50;
params_out.n_Treg_CTLA4  = params_in.n_Treg_CTLA4;

% Treg ADCC rates
params_out.k_CTLA4_ADCC  = params_in.k_CTLA4_ADCC;
params_out.k_CTLA4_ADCC.Notes   = ['Anti-CTLA4 ADCC (antibody-dependent cellular cytotoxicity) rate of Treg ' params_in.k_CTLA4_ADCC.Notes];
