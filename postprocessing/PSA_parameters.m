% Function to generate object with model parameters to include in parameter
% sensitivity analysis
%
% Output: params -- object containing parameters
%                   -> for each parameter: 
%                       - Adds the name of the parameter to the list
%                       - defines upper and lower bounds for uniform and
%                       loguniform
%                       - defines median and sigma for normal and log
%                       normal
%                       - specifies the Sampling technique choose from:
%                           - uniform
%                           - loguniform
%                           - normal
%                           - lognormal
%         Examples:
%             % k1
%             params.names = [params.names; 'k1'];
%             params.k1.UpperBound = 1;
%             params.k1.LowerBound = 0;
%             params.k1.Sampling   = 'uniform';
% 
%             % k2
%             params.names = [params.names; 'k2'];
%             params.k2.UpperBound = 1;
%             params.k2.LowerBound = 0;
%             params.k2.Sampling   = 'loguniform';
% 
%             % k3
%             params.names = [params.names; 'k3'];
%             params.k3.Median     = 1;
%             params.k3.Sigma      = 1;
%             params.k3.Sampling   = 'normal';
% 
%             % k4
%             params.names = [params.names; 'k4'];
%             params.k4.Median     = 1;
%             params.k4.Sigma      = 1;
%             params.k4.Sampling   = 'lognormal';

% Created: Nov 18, 2018 (Mohammad Jafarnejad)
% Last Modified: Jan 20, 2019 (MJ)

function params = PSA_param_in

params.names = {};

% C1 growth rate
params.names = [params.names; 'k_C1_growth'];
params.k_C1_growth.UpperBound = 0.03;
params.k_C1_growth.LowerBound = 0.01;
params.k_C1_growth.Sampling   = 'uniform';

% Maximum tumor size
params.names = [params.names; 'k_C1_death'];
params.k_C1_death.UpperBound = 8.4e11;
params.k_C1_death.LowerBound = 2.1e11;
params.k_C1_death.Sampling   = 'loguniform';

% Number of LNs
params.names = [params.names; 'N0'];
params.N0.Median     = 7;
params.N0.Sigma      = 1;
params.N0.Sampling   = 'normal';

% Maximum tumor size
params.names = [params.names; 'C_max'];
params.C_max.Median     = 1e-5;
params.C_max.Sigma      = 1;
params.C_max.Sampling   = 'lognormal';



% % number of CD8 clones
% params.names = [params.names; 'n_clones_CD8'];
% params.n_clones_CD8.UpperBound = 400;
% params.n_clones_CD8.Median     = 100;
% params.n_clones_CD8.LowerBound = 10;
% params.n_clones_CD8.sampling   = 'uniform';
% 
% % number of CD4 clones
% params.names = [params.names; 'n_clones_CD4'];
% params.n_clones_CD4.UpperBound = 400;
% params.n_clones_CD4.Median     = 100;
% params.n_clones_CD4.LowerBound = 10;
% params.n_clones_CD4.sampling = 'uniform';




% i_PSA = [find(strcmp(Parameters(:,1),'vol_tum'             )),...   1
%          find(strcmp(Parameters(:,1),'k_C_growth'          )),...   2
%          find(strcmp(Parameters(:,1),'k_C_death'           )),...   3
%          find(strcmp(Parameters(:,1),'k_C_death_by_T'      )),...   4
%          find(strcmp(Parameters(:,1),'k_Teff_inhibBy_Treg' )),...   5
%          find(strcmp(Parameters(:,1),'n_clone_p1_0'        )),...   6
%          find(strcmp(Parameters(:,1),'Kd_p1_0_M1'          )),...   7
%          find(strcmp(Parameters(:,1),'K_C1_PDL1_Teff_PD1'  )),...   8 9
%          find(strcmp(Parameters(:,1),'Teff_PD1_tot'        )),...   10 
%          find(strcmp(Parameters(:,1),'C1_PDL1_tot'         )),...   11 
%          find(strcmp(Parameters(:,1),'C1_PDL2_tot'         )),...   12 
%          find(strcmp(Parameters(:,1),'k_Teff_death_by_C'   )),...   13
%          find(strcmp(Parameters(:,1),'nLN'                 )),...   14
%          find(strcmp(Parameters(:,1),'Kd_cpt_M1'           )),...   15
%          find(strcmp(Parameters(:,1),'k_nT_entry'          )),...   16
%          find(strcmp(Parameters(:,1),'K_p_M'               )),...   17
%          find(strcmp(Parameters(:,1),'nT_CD8_dens'         )),...   18
%          find(strcmp(Parameters(:,1),'nT_CD4_dens'         )) ...   19 
%          find(strcmp(Parameters(:,1),'S_adhesion_tot'      )),...   20
%          find(strcmp(Parameters(:,1),'f_vol_BV'            )),...   21
%          find(strcmp(Parameters(:,1),'vol_tum_max'         )),...   22
%          find(strcmp(Parameters(:,1),'APC0_Tum'            )),...   23
%          find(strcmp(Parameters(:,1),'APC0_LN'             )),...   24
%          find(strcmp(Parameters(:,1),'n_clone_Treg'        )),...   25
%          find(strcmp(Parameters(:,1),'DAMP_per_C'          )),...   26
%          ]; 