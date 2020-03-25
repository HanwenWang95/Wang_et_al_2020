% Function to generate cancer module parameters from default physical parameters
%
% Inputs: params_in  -- object containing the default parameters
%                       - k_C_growth--cancer cell growth rate
%                       - D_Tmax--maximum tumour diameter
%                       - rho_cell--cancer cell density
%                       - k_C_death--baseline cancer cell death rate
%
% Output: params_out -- object containing parameters
%                       - k_C_growth--cancer cell growth rate
%                       - Cmax--cancer cell capacity
%                       - k_C_death--baseline cancer cell death rate
%
% Created: Oct 30, 2018 (Richard Sové)
% Last Modified: Mar 08, 2019 (RJS)

function params_out = cancer_parameters(params_in)

% Growth Rate
params_out.k_C_growth = params_in.k_C_growth;
% Capacity
params_out.C_max = 4/3*pi*(params_in.D_Tmax/2)^3*params_in.rho_cell;
params_out.C_max.Notes = ['calculated from tumour maximum diameter ' params_in.D_Tmax.Notes ' and cancer cell density ' params_in.rho_cell.Notes];
% Death 
params_out.k_C_death = params_in.k_C_death;

% Initial Tumour diameter
params_out.initial_tumour_diameter = params_in.initial_tumour_diameter;