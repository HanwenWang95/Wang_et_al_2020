% Function to generate antigen module parameters from physical parameters
%
% Inputs: params_in  -- object containing the physical parameters
%                       - N_avg--Avogadro's number
%                       - V_LN--volume of LN compartment
%                       - N_MHC--number of type of MHC molecules
%                       - N_MHC_T--total amount of MHC
%                       - kin--rate of MHC internalization
%                       - kout--rate of MHC exernalization
%                       - N_endo--number of endosomal vesicles per cell
%                       - V_endo--volume of endosomal vesicle
%                       - A_endo--surface area of endosomal vesicle
%                       - A_s--APC surface area
%                       - k_up--rate of antigen uptake by APCs
%                       - k_xP_deg--rate of extracellular antigen degradation
%                       - k_P_deg--rate of endosomal antigen degradation
%                       - k_p_deg--rate of endosomal epitope degradation
%                       - k_on--rate of antigen_MHC binding
%                       - N_p_50--number of epitope molecules for half-maximal T cell activation
%
% Output: params_out -- object containing parameters
%                       - N_MHC--number of type of MHC molecules
%                       - MHC_T--total amount of MHC per area
%                       - kin--rate of MHC internalization
%                       - kout--rate of MHC exernalization
%                       - V_e--endosomal volume
%                       - A_e--endosomal surface area
%                       - A_s--APC surface area
%                       - k_up--rate of antigen uptake by APCs
%                       - k_xP_deg--rate of extracellular antigen degradation
%                       - k_P_deg--rate of endosomal antigen degradation
%                       - k_p_deg--rate of endosomal epitope degradation
%                       - k_on--rate of antigen_MHC binding
%                       - p_50--epitope concentration for half-maximal T cell activation
%
% Created: Nov 25, 2018 (Richard Sové)
% Last Modified: Dec 04, 2018 (RJS)

function params_out = antigen_parameters(params_in)

% Number of MHC Molecule Types
params_out.N_MHC = params_in.N_MHC;

% Total Amount of MHC per Area
params_out.MHC_T = params_in.n_MHC_T/(params_in.A_endo*params_in.N_endo + params_in.A_s);
params_out.MHC_T.Notes = ['calculated based on the total amount of MHC ' params_in.n_MHC_T.Notes ...
                    ' and the total surface area'];

% Rate of MHC Internalization
params_out.kin = params_in.kin;

% Rate of MHC Externalization
params_out.kout = params_in.kout;

% Endosomal Volume
params_out.V_e = params_in.V_endo*params_in.N_endo;
params_out.V_e.Notes = ['calculated based on the volume of a single endosome ' params_in.V_endo.Notes ...
                        ' and the number of endosomes per cell ' params_in.N_endo.Notes];

% Endosomal Surface Area
params_out.A_e = params_in.A_endo*params_in.N_endo;
params_out.A_e.Notes = ['calculated based on the surface area of a single endosome ' params_in.A_endo.Notes ...
                        ' and the number of endosomes per cell ' params_in.N_endo.Notes];

% APC Surface Area
params_out.A_s = params_in.A_s;

% Rate of Antigen Uptake
params_out.k_up = params_in.k_up;

% Rate of Extracellular Antigen Degradation
params_out.k_xP_deg = params_in.k_xP_deg;

% Rate of Antigen Degradation
params_out.k_P_deg = params_in.k_P_deg;

% Rate of Epitope Degradation
params_out.k_p_deg = params_in.k_p_deg;

% Rate of Antigen Association
params_out.k_on = params_in.k_on;

% Synapse size
params_out.A_syn   = params_in.A_syn;

% Surface Area of Cells
params_out.A_Tcell = 4*pi*(params_in.D_Tcell/2)^2;
params_out.A_Tcell.Notes = ['calculated based on the average T cell diameter ' params_in.D_Tcell.Notes];
% Surface Area of Cancer Cells
params_out.A_cell = 4*pi*(params_in.D_cell/2)^2;
params_out.A_cell.Notes = ['calculated based on the average Cancer cell diameter ' params_in.D_cell.Notes];
% Surface Area of APC Cells
params_out.A_APC = params_in.A_s;

% Rate of modification of TCRs
params_out.k_TCR_p = params_in.k_TCR_p;

% Unbinding rate of ag/MHC to TCR
params_out.k_TCR_off = params_in.k_TCR_off;

% Binding rate of ag/MHC to TCR
params_out.k_TCR_on = params_in.k_TCR_on;
                    
% Rate of modification of TCR that leads to non-signaling
params_out.phi_TCR = params_in.phi_TCR;

% Number of intermediate steps
params_out.N_TCR = params_in.N_TCR;

% Number of TCR molecules on naive T cells
% params_out.TCR_tot = params_in.TCR_tot;
params_out.TCR_tot = params_in.TCR_tot/params_out.A_Tcell;
params_out.TCR_tot.Notes = ['calculated based on the number of molecules for TCR '...
                         params_in.TCR_tot.Notes ' and T cell surface area']; 

% MHC-Epitope-TCR Concentration for Half-Maximal T Cell Activation
params_out.p_50 = params_in.N_p_50/params_in.A_syn;
params_out.p_50.Notes = ['calculated based on the number of molecules for half-maximal T cell activation '...
                         params_in.N_p_50.Notes ' and synapse surface area']; 