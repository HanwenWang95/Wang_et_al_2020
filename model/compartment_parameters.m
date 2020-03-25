% Function to generate cancer module parameters from default physical parameters
%
% Inputs: params_in  -- object containing the default parameters
%                       - V_C--central compartment volume
%                       - V_P--peripheral compartment volume
%                       - V_Tmin--cancer-free tumour compartment volume
%                       - D_LN--lymph node diameter
%                       - nLNs--number of LNs
%                       - D_cell--volume of cancer cell
%                       - vol_Tcell--volume of T cell
%                       - k_cell_clear--dead cell clearance rate
%
% Output: params_out -- object containing parameters
%                       - V_C--central compartment volume
%                       - V_P--peripheral compartment volume
%                       - V_Tmin--cancer-free tumour compartment volume
%                       - V_LN--lymph node compartment volume
%                       - vol_cell--volume of cancer cell
%                       - vol_Tcell--volume of T cell
%                       - k_cell_clear--dead cell clearance rate
%
% Created: Oct 30, 2018 (Richard Sové)
% Last Modified: Feb 25, 2019 (RJS)

function params_out = compartment_parameters(params_in)

% Compartment Volumes
% Central
params_out.V_C = params_in.V_C;
% Peripheral
params_out.V_P = params_in.V_P;
% Tumour
params_out.V_Tmin = params_in.V_Tmin;
% LN
params_out.V_LN = params_in.nLNs*4/3*pi*(params_in.D_LN/2)^3;
params_out.V_LN.Notes = ['calculated based on number of LNs ' params_in.nLNs.Notes ' and average LN diameter ' params_in.D_LN.Notes];

% Cell Volumes
% Cancer Cell Volume
params_out.vol_cell = 4/3*pi*(params_in.D_cell/2)^3/one_cell;
params_out.vol_cell.Notes = ['calculated based on cancer cell diameter ' params_in.D_cell.Notes];
% T Cell Volume 
params_out.vol_Tcell = 4/3*pi*(params_in.D_Tcell/2)^3/one_cell;
params_out.vol_Tcell.Notes = ['calculated based on the average T cell diameter ' params_in.D_Tcell.Notes];

% Cell Clearance
params_out.k_cell_clear = params_in.k_cell_clear;