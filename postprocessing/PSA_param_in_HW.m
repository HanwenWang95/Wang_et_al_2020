% Function to generate object with model parameters to include in parameter
% sensitivity analysis
%
% Output: params -- object containing parameters
%                   -> for each parameter:
%                       - Adds the name of the parameter to the list
%                       - defines upper and lower bounds for uniform and
%                       loguniform
%                       - defines Median and Sigma for normal and lognormal
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
%             params.k1.ScreenName = 'k1 binding rate';
%
%             % k2
%             params.names = [params.names; 'k2'];
%             params.k2.UpperBound = 1;
%             params.k2.LowerBound = 0;
%             params.k2.Sampling   = 'loguniform';
%             params.k2.ScreenName = 'k2 binding rate';
%
%             % k3
%             params.names = [params.names; 'k3'];
%             params.k3.Median     = 1;
%             params.k3.Sigma      = 1;
%             params.k3.Sampling   = 'normal';
%             params.k3.ScreenName = 'k3 binding rate';
%
%             % k4
%             params.names = [params.names; 'k4'];
%             params.k4.Median     = 1;
%             params.k4.Sigma      = 1;
%             params.k4.Sampling   = 'lognormal';
%             params.k4.ScreenName = 'k4 binding rate';

% Created: Nov 18, 2018 (Mohammad Jafarnejad)
% Last Modified: Oct 3, 2019 (HW)

function params = PSA_param_in_HW

params.names = {};

% C1 growth rate 0.0035 for HER2-negative BC: 197.56 +/- 30 days
% TNBC: 103 +/- 43 days; ER+: 241 +/- 166 days
params.names = [params.names; 'k_C1_growth'];
params.k_C1_growth.Median = log(0.00745); % 0.01155
params.k_C1_growth.Sigma = 1; % 0.00475
params.k_C1_growth.Sampling   = 'lognormal';
params.k_C1_growth.ScreenName = 'Cancer Growth Rate';

% C1 basal death rate
params.names = [params.names; 'k_C1_death'];
params.k_C1_death.UpperBound = 0.001;
params.k_C1_death.LowerBound = 0.00001;
params.k_C1_death.Sampling   = 'loguniform';
params.k_C1_death.ScreenName = 'Rate of Cancer Death by NK cell';

% T cell exhaustion by cancer cell
params.names = [params.names; 'k_T1'];
params.k_T1.UpperBound = 0.5;
params.k_T1.LowerBound = 0.05;
params.k_T1.Sampling   = 'loguniform';
params.k_T1.ScreenName = 'Rate of T cell Exhaustion by Cancer Cell';

% T cell killing of cancer cell
params.names = [params.names; 'k_C_T1'];
params.k_C_T1.UpperBound = 10;
params.k_C_T1.LowerBound = 2;
params.k_C_T1.Sampling   = 'uniform';
params.k_C_T1.ScreenName = 'Rate of Cancer Death by T cell';

% T reg inhibition of Teff
params.names = [params.names; 'k_Treg'];
params.k_Treg.UpperBound = 1;
params.k_Treg.LowerBound = 0.1;
params.k_Treg.Sampling   = 'loguniform';
params.k_Treg.ScreenName = 'Rate of T cell inhibition by Treg';

% Kd of antigen P1
params.names = [params.names; 'k_P1_d1'];
params.k_P1_d1.UpperBound = 27e-9*20;
params.k_P1_d1.LowerBound = 27e-9/10;
params.k_P1_d1.Sampling   = 'loguniform';
params.k_P1_d1.ScreenName = 'Kd of antigen';

% Tumor mutational Burden
params.names = [params.names; 'n_T1_clones'];
params.n_T1_clones.Median = log(100);
params.n_T1_clones.Sigma = 1;
params.n_T1_clones.Sampling   = 'lognormal';
params.n_T1_clones.ScreenName = 'Tumor Mutational Burden';

% Initial tumor diameter
params.names = [params.names; 'initial_tumour_diameter'];
params.initial_tumour_diameter.UpperBound = 4.5;
params.initial_tumour_diameter.LowerBound = 1.1;
params.initial_tumour_diameter.Sampling   = 'uniform';
params.initial_tumour_diameter.ScreenName = 'Initial Tumor Diameter';

% MDSC Module
params.names = [params.names; 'k_sec_NO'];
params.k_sec_NO.UpperBound = 5.65e-7;
params.k_sec_NO.LowerBound = 3.95e-7;
params.k_sec_NO.Sampling   = 'uniform';
params.k_sec_NO.ScreenName = 'Secretion rate of NO by MDSC';

params.names = [params.names; 'k_sec_ArgI'];
params.k_sec_ArgI.UpperBound = 1.6e-2;
params.k_sec_ArgI.LowerBound = 1.2e-2;
params.k_sec_ArgI.Sampling   = 'uniform';
params.k_sec_ArgI.ScreenName = 'Secretion rate of Arg I by MDSC';

params.names = [params.names; 'k_sec_CCL2'];
params.k_sec_CCL2.UpperBound = 20.2e-11;
params.k_sec_CCL2.LowerBound = 8.2e-11;
params.k_sec_CCL2.Sampling   = 'uniform';
params.k_sec_CCL2.ScreenName = 'Secretion rate of CCL2 by MDSC';

params.names = [params.names; 'MDSC_max'];
params.MDSC_max.Median = log(1.637e5); % 4e5*2.5
params.MDSC_max.Sigma = 2;
params.MDSC_max.Sampling   = 'lognormal';
params.MDSC_max.ScreenName = 'Steady-state MDSC number in tumor';

params.names = [params.names; 'ki_Treg'];
params.ki_Treg.UpperBound = 2.7;
params.ki_Treg.LowerBound = .27;
params.ki_Treg.Sampling   = 'loguniform';
params.ki_Treg.ScreenName = 'Treg expansion rate by ArgI';

params.names = [params.names; 'rho_cell'];
params.rho_cell.UpperBound = 2.06e8;
params.rho_cell.LowerBound = 1.67e8;
params.rho_cell.Sampling   = 'uniform';
params.rho_cell.ScreenName = 'Cancer cell density in the tumor';

params.names = [params.names; 'C1_PDL1_total'];
params.C1_PDL1_total.UpperBound = 1.6e6;
params.C1_PDL1_total.LowerBound = 1.6e6/40;
params.C1_PDL1_total.Sampling   = 'loguniform';
params.C1_PDL1_total.ScreenName = 'Number of PDL1 on cancer cell';

params.names = [params.names; 'C1_PDL2_total'];
params.C1_PDL2_total.UpperBound = 40000;
params.C1_PDL2_total.LowerBound = 40000/40;
params.C1_PDL2_total.Sampling   = 'loguniform';
params.C1_PDL2_total.ScreenName = 'Number of PDL2 on cancer cell';

% ADCC
params.names = [params.names; 'k_CTLA4_ADCC'];
params.k_CTLA4_ADCC.UpperBound = .1*10;
params.k_CTLA4_ADCC.LowerBound = .1;
params.k_CTLA4_ADCC.Sampling   = 'loguniform';
params.k_CTLA4_ADCC.ScreenName = 'Treg ADCC rate via $\alpha$CTLA4-FcR';

params.names = [params.names; 'Treg_CTLA4_50'];
params.Treg_CTLA4_50.UpperBound = 1000;
params.Treg_CTLA4_50.LowerBound = 100;
params.Treg_CTLA4_50.Sampling   = 'loguniform';
params.Treg_CTLA4_50.ScreenName = 'Half-maximal $\alpha$CTLA4 conc. for Treg death';

% CTLA-4
params.names = [params.names; 'CD28_CD8X_50'];
params.CD28_CD8X_50.UpperBound = 200*5;
params.CD28_CD8X_50.LowerBound = 200/2;
params.CD28_CD8X_50.Sampling   = 'loguniform';
params.CD28_CD8X_50.ScreenName = 'CD28-CD80/86 conc. for half-maximal T activation';

params.names = [params.names; 'N_costim'];
params.N_costim.UpperBound = 5;
params.N_costim.LowerBound = 2;
params.N_costim.Sampling   = 'uniform';
params.N_costim.ScreenName = 'Number of activated T cell generations for co-stimulation';

% MDSC
params.names = [params.names; 'Treg_max'];
params.Treg_max.Median = log(955); % 955 - 1105809
params.Treg_max.Sigma = 2;
params.Treg_max.Sampling   = 'lognormal';
params.Treg_max.ScreenName = 'Steady-state Treg density in tumor';

params.names = [params.names; 'EC50_ArgI_Treg'];
params.EC50_ArgI_Treg.UpperBound = 22.1*10;
params.EC50_ArgI_Treg.LowerBound = 22.1/10;
params.EC50_ArgI_Treg.Sampling   = 'loguniform';
params.EC50_ArgI_Treg.ScreenName = 'ArgI half-maximal conc. on Treg expansion';

params.names = [params.names; 'IC50_ArgI_CTL'];
params.IC50_ArgI_CTL.UpperBound = 61.7*10;
params.IC50_ArgI_CTL.LowerBound = 61.7/10;
params.IC50_ArgI_CTL.Sampling   = 'loguniform';
params.IC50_ArgI_CTL.ScreenName = 'ArgI half-maximal conc. on Teff inhibition';

params.names = [params.names; 'IC50_NO_CTL'];
params.IC50_NO_CTL.UpperBound = .75e-9*10;
params.IC50_NO_CTL.LowerBound = .75e-9/10;
params.IC50_NO_CTL.Sampling   = 'loguniform';
params.IC50_NO_CTL.ScreenName = 'NO half-maximal conc. on Teff inhibition';

% PK Parameters
params.names = [params.names; 'k_cln_ENT'];
params.k_cln_ENT.UpperBound = 46/376400; % 1e-4
params.k_cln_ENT.LowerBound = 23/376400; % 6e-5
params.k_cln_ENT.Sampling   = 'uniform';
params.k_cln_ENT.ScreenName = 'Non-linear clearance rate of entinostat';

params.names = [params.names; 'k_a1_ENT'];
params.k_a1_ENT.UpperBound = 2.24;
params.k_a1_ENT.LowerBound = 1.91;
params.k_a1_ENT.Sampling   = 'uniform';
params.k_a1_ENT.ScreenName = 'Buccal absorption rate of entinostat';

params.names = [params.names; 'k_a2_ENT'];
params.k_a2_ENT.UpperBound = 7.47;
params.k_a2_ENT.LowerBound = 2.47;
params.k_a2_ENT.Sampling   = 'uniform';
params.k_a2_ENT.ScreenName = 'GI absorption rate of entinostat';

params.names = [params.names; 'k_cl_ENT'];
params.k_cl_ENT.UpperBound = 1.27;
params.k_cl_ENT.LowerBound = .152;
params.k_cl_ENT.Sampling   = 'loguniform';
params.k_cl_ENT.ScreenName = 'Clearance rate of entinostat';

params.names = [params.names; 'q_T_ENT'];
params.q_T_ENT.UpperBound = 3420;
params.q_T_ENT.LowerBound = 3200;
params.q_T_ENT.Sampling   = 'uniform';
params.q_T_ENT.ScreenName = 'Diffustion rate of entinostat from central to tumor';

params.names = [params.names; 'IC50_ENT_C'];
params.IC50_ENT_C.UpperBound = 3.74e-7;
params.IC50_ENT_C.LowerBound = 2.5e-7/100;
params.IC50_ENT_C.Sampling   = 'loguniform';
params.IC50_ENT_C.ScreenName = 'ENT half-maximal conc. on tumor inhibition';

params.names = [params.names; 'IC50_ENT_NO'];
params.IC50_ENT_NO.UpperBound = .56e-9*10; % 1e-9*20
params.IC50_ENT_NO.LowerBound = .56e-9/10; % 1e-9/2
params.IC50_ENT_NO.Sampling   = 'loguniform';
params.IC50_ENT_NO.ScreenName = 'ENT half-maximal conc. on NO inhibition';

params.names = [params.names; 'IC50_ENT_CCL2'];
params.IC50_ENT_CCL2.UpperBound = 1.2e-9*10;
params.IC50_ENT_CCL2.LowerBound = 1.2e-9/10;
params.IC50_ENT_CCL2.Sampling   = 'loguniform';
params.IC50_ENT_CCL2.ScreenName = 'ENT half-maximal conc. on MCP-1 inhibition';
