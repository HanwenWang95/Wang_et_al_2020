% Function to generate checkpoint module parameters from physical parameters
%
% Inputs: params_in  -- object containing the default parameters 
%         Tname      -- name of the T cell forming the checkpoint synapse 
%         Cname      -- name of the cancer or APC cell forming the 
%                       checkpoint synapse 
%
% Output: params_out -- object containing parameters to be used for a
%                       checkpoint module
%
% Created: Feb 14, 2019 (Mohammad Jafarnejad)
% Last Modified: Feb 17, 2019 (MJ)

function params_out = checkpoint_parameters(params_in,Tname,Cname)

% PD1/PDL1/PDL2 rates
% kon Values
params_out.kon_PD1_PDL1  = params_in.kon_PD1_PDL1  / params_in.d_syn;
params_out.kon_PD1_PDL2  = params_in.kon_PD1_PDL2  / params_in.d_syn;
params_out.kon_PD1_nivo  = params_in.kon_PD1_nivo  ;
params_out.kon_PDL1_durv = params_in.kon_PDL1_durv ;
params_out.kon_PD1_PDL1.Notes  = ['kon for PD1-PDL1 ' params_in.kd_PD1_PDL1.Notes];
params_out.kon_PD1_PDL2.Notes  = ['kon for PD1-PDL2 ' params_in.kd_PD1_PDL2.Notes];
params_out.kon_PD1_nivo.Notes  = ['kon for PD1-nivolumab ' params_in.kd_PD1_nivo.Notes];
params_out.kon_PDL1_durv.Notes = ['kon for PDL1-durvalumab ' params_in.kd_PDL1_durv.Notes];
% koff Values
params_out.koff_PD1_PDL1  = params_in.kon_PD1_PDL1  * params_in.kd_PD1_PDL1; 
params_out.koff_PD1_PDL2  = params_in.kon_PD1_PDL2  * params_in.kd_PD1_PDL2;
params_out.koff_PD1_nivo  = params_in.kon_PD1_nivo  * params_in.kd_PD1_nivo;
params_out.koff_PDL1_durv = params_in.kon_PDL1_durv * params_in.kd_PDL1_durv;
params_out.koff_PD1_PDL1.Notes  = ['calculated based on the measured kd and kon ' params_in.kd_PD1_PDL1.Notes];
params_out.koff_PD1_PDL2.Notes  = ['calculated based on the measured kd and kon ' params_in.kd_PD1_PDL2.Notes];
params_out.koff_PD1_nivo.Notes  = ['calculated based on the measured kd and kon ' params_in.kd_PD1_nivo.Notes];
params_out.koff_PDL1_durv.Notes = ['calculated based on the measured kd and kon ' params_in.kd_PDL1_durv.Notes];

% CD28/CTLA4/CD80/CD86 rates
% kon Values
params_out.kon_CD28_CD80   = params_in.kon_CD28_CD80   / params_in.d_syn;
params_out.kon_CD28_CD86   = params_in.kon_CD28_CD86   / params_in.d_syn;
params_out.kon_CTLA4_CD80  = params_in.kon_CTLA4_CD80  / params_in.d_syn;
params_out.kon_CTLA4_CD86  = params_in.kon_CTLA4_CD86  / params_in.d_syn;
params_out.kon_CD80_PDL1   = params_in.kon_CD80_PDL1   / params_in.d_syn;
params_out.kon_CTLA4_ipi   = params_in.kon_CTLA4_ipi ;
params_out.kon_CD28_CD80.Notes   = ['kon for CD28-CD80 ' params_in.kd_CD28_CD80.Notes];
params_out.kon_CD28_CD86.Notes   = ['kon for CD28-CD86 ' params_in.kd_CD28_CD86.Notes];
params_out.kon_CTLA4_CD80.Notes  = ['kon for CTLA4-CD80 ' params_in.kd_CTLA4_CD80.Notes];
params_out.kon_CTLA4_CD86.Notes  = ['kon for CTLA4-CD86 ' params_in.kd_CTLA4_CD86.Notes];
params_out.kon_CD80_PDL1.Notes   = ['kon for CD80-PDL1 ' params_in.kd_CD80_PDL1.Notes];
params_out.kon_CTLA4_ipi.Notes   = ['kon for CTLA4-ipilimumab ' params_in.kd_CTLA4_ipi.Notes];
% koff Values
params_out.koff_CD28_CD80   = params_in.kon_CD28_CD80   * params_in.kd_CD28_CD80; 
params_out.koff_CD28_CD86   = params_in.kon_CD28_CD86   * params_in.kd_CD28_CD86;
params_out.koff_CTLA4_CD80  = params_in.kon_CTLA4_CD80  * params_in.kd_CTLA4_CD80; 
params_out.koff_CTLA4_CD86  = params_in.kon_CTLA4_CD86  * params_in.kd_CTLA4_CD86;
params_out.koff_CD80_PDL1   = params_in.kon_CD80_PDL1   * params_in.kd_CD80_PDL1;
params_out.koff_CTLA4_ipi   = params_in.kon_CTLA4_ipi * params_in.kd_CTLA4_ipi;
params_out.koff_CD28_CD80.Notes   = ['calculated based on the measured kd and kon ' params_in.kd_CD28_CD80.Notes];
params_out.koff_CD28_CD86.Notes   = ['calculated based on the measured kd and kon ' params_in.kd_CD28_CD86.Notes];
params_out.koff_CTLA4_CD80.Notes  = ['calculated based on the measured kd and kon ' params_in.kd_CTLA4_CD80.Notes];
params_out.koff_CTLA4_CD86.Notes  = ['calculated based on the measured kd and kon ' params_in.kd_CTLA4_CD86.Notes];
params_out.koff_CD80_PDL1.Notes   = ['calculated based on the measured kd and kon ' params_in.kd_CD80_PDL1.Notes];
params_out.koff_CTLA4_ipi.Notes   = ['calculated based on the measured kd and kon ' params_in.kd_CTLA4_ipi.Notes];

% Bivalent antibody - antibody cross-arm binding efficiency 
params_out.Chi_PD1_nivo = params_in.Chi_PD1_nivo/(params_in.d_syn*params_in.N_avg);
params_out.Chi_PD1_nivo.Notes = [' that also includes the conversion of kon from 3D to 2D' params_in.Chi_PD1_nivo.Notes];
params_out.Chi_PDL1_durv = params_in.Chi_PDL1_durv/(params_in.d_syn*params_in.N_avg);
params_out.Chi_PDL1_durv.Notes = [' that also includes the conversion of kon from 3D to 2D' params_in.Chi_PDL1_durv.Notes];
params_out.Chi_CTLA4_ipi = params_in.Chi_CTLA4_ipi/(params_in.d_syn*params_in.N_avg);
params_out.Chi_CTLA4_ipi.Notes = [' that also includes the conversion of kon from 3D to 2D' params_in.Chi_CTLA4_ipi.Notes];

% Synapse size
params_out.A_syn   = params_in.A_syn;
params_out.d_syn   = params_in.d_syn;

% Surface Area of Cells
params_out.A_Tcell = 4*pi*(params_in.D_Tcell/2)^2;
params_out.A_Tcell.Notes = ['calculated based on the average T cell diameter ' params_in.D_Tcell.Notes];
% Surface Area of Cancer Cells
params_out.A_cell = 4*pi*(params_in.D_cell/2)^2;
params_out.A_cell.Notes = ['calculated based on the average Cancer cell diameter ' params_in.D_cell.Notes];
% Surface Area of APC Cells
params_out.A_APC = params_in.A_s;

% Checkpoint Expression
params_out.([Tname,'_PD1'])    = params_in.T8_PD1;
params_out.([Tname,'_CD28'])   = params_in.T8_CD28;
params_out.([Tname,'_CTLA4'])  = params_in.T8_CTLA4;
params_out.([Tname,'_PDL1'])    = params_in.T8_PDL1;
% Select the expression of the right cell type based on cancer or APC
if Cname(1)=='C'  
    params_out.([Cname,'_PDL1']) = params_in.C_PDL1;
    params_out.([Cname,'_PDL2']) = params_in.C_PDL2;
    params_out.([Cname,'_CD80']) = params_in.C_CD80;
    params_out.([Cname,'_CD86']) = params_in.C_CD86;
elseif Cname(1)=='A'
    params_out.([Cname,'_PDL1']) = params_in.APC_PDL1;
    params_out.([Cname,'_PDL2']) = params_in.APC_PDL2;
    params_out.([Cname,'_CD80']) = params_in.APC_CD80;
    params_out.([Cname,'_CD86']) = params_in.APC_CD86;
end


% Hill Function Parameters
params_out.PD1_50 = params_in.PD1_50;
params_out.n_PD1  = params_in.n_PD1;

params_out.CD28_CD8X_50 = params_in.CD28_CD8X_50;
params_out.n_CD28_CD8X  = params_in.n_CD28_CD8X;
