% Function to generate object with model parameters to include as outputs
% of the parameter sensitivity analysis
%
% Output: params -- object containing output parameters
%                   -> for each parameter:
%                       - Adds the name of the parameter to the list
%                       - defines upper and lower bounds of acceptable
%                       physiological range
%                       - specifies if the output is comaprtment,
%                       parameter, species or postprocessed parameters
%                           - for species: specifies compartment
%         Examples:
%                 % k1
%                 params.names = [params.names; 'k1'];
%                 params.k1.UpperBound = 1;
%                 params.k1.LowerBound = 0;
%                 params.k1.Units      = 'liter';
%                 params.k1.Type       = 'compartment';
%                 params.k1.ScreenName = 'k1 binding rate';
%
%                 % k2
%                 params.names = [params.names; 'k2'];
%                 params.k2.UpperBound = 1;
%                 params.k2.LowerBound = 0;
%                 params.k2.Units      = 'liter';
%                 params.k2.Type       = 'parameter';
%                 params.k2.ScreenName = 'k2 binding rate';
%
%                 % k3 in central
%                 params.names = [params.names; 'k3_C'];
%                 params.k3_C.UpperBound  = 1e12;
%                 params.k3_C.LowerBound  = 0;
%                 params.k3_C.Units       = 'cell';
%                 params.k3_C.Type        = 'species';
%                 params.k3_C.Name        = 'k2';
%                 params.k3_C.Compartment = 'V_C';
%                 params.k3.ScreenName    = 'k3 binding rate';
%
%                 % k4 post processed
%                 params.names = [params.names; 'k4'];
%                 params.k4.UpperBound  = 1;
%                 params.k4.LowerBound  = 0;
%                 params.k4.Units       = 'dimensionless';
%                 params.k4.Type        = 'post';
%                 params.k4.ScreenName  = 'k4 binding rate';
% NOTE: for postprocessed parameters ensure the name here is the same as
%       the name assigned in the postprocess functions

% Created: Jan 20, 2019 (Mohammad Jafarnejad)
% Last Modified: Oct 3, 2019 (HW)

function params = PSA_param_out(varargin)

params.names = {};

% Tumor Volume
params.names = [params.names; 'V_T'];
params.V_T.UpperBound = 1e6;
params.V_T.LowerBound = 0.00;
params.V_T.Units      = 'microliter';
params.V_T.Type       = 'compartment';
params.V_T.ScreenName = 'Tumor Volume';

% Number of CD8 T cells in the blood
% params.names = [params.names; 'T1_C'];
% params.T1_C.UpperBound  = 1e15;
% params.T1_C.LowerBound  = 0;
% params.T1_C.Units       = 'cell';
% params.T1_C.Type        = 'species';
% params.T1_C.Name        = 'T1';
% params.T1_C.Compartment = 'V_C';
% params.T1_C.ScreenName  = 'Number of Teff in Blood';

% Number of Treg cells in the blood
% params.names = [params.names; 'T0_C'];
% params.T0_C.UpperBound  = 1e15;
% params.T0_C.LowerBound  = 0;
% params.T0_C.Units       = 'cell';
% params.T0_C.Type        = 'species';
% params.T0_C.Name        = 'T0';
% params.T0_C.Compartment = 'V_C';
% params.T0_C.ScreenName  = 'Number of Treg in Blood';

% Number of CD8 T cells in the tumor
% params.names = [params.names; 'T1_T'];
% params.T1_T.UpperBound  = 1e15;
% params.T1_T.LowerBound  = 0;
% params.T1_T.Units       = 'cell';
% params.T1_T.Type        = 'species';
% params.T1_T.Name        = 'T1';
% params.T1_T.Compartment = 'V_T';
% params.T1_T.ScreenName  = 'Number of Teff in Tumor';

% Number of Treg cells in the tumor
% params.names = [params.names; 'T0_T'];
% params.T0_T.UpperBound  = 1e15;
% params.T0_T.LowerBound  = 0;
% params.T0_T.Units       = 'cell';
% params.T0_T.Type        = 'species';
% params.T0_T.Name        = 'T0';
% params.T0_T.Compartment = 'V_T';
% params.T0_T.ScreenName  = 'Number of Treg in Tumor';

% Number of Cancer cells in the tumor
% params.names = [params.names; 'C1_T'];
% params.C1_T.UpperBound  = 1e17;
% params.C1_T.LowerBound  = 0;
% params.C1_T.Units       = 'cell';
% params.C1_T.Type        = 'species';
% params.C1_T.Name        = 'C1';
% params.C1_T.Compartment = 'V_T';
% params.C1_T.ScreenName  = 'Number of Cancer cells in Tumor';

% Number of T1 cells in the tumor
params.names = [params.names; 'Teff_density'];
params.Teff_density.UpperBound  = 1e13;
params.Teff_density.LowerBound  = 0;
params.Teff_density.Units       = 'cell/milliliter';
params.Teff_density.Type        = 'post';
params.Teff_density.ScreenName  = 'Teff Density in Tumor';

% Number of T1 cells in the tumor
params.names = [params.names; 'Treg_density'];
params.Treg_density.UpperBound  = 1e13;
params.Treg_density.LowerBound  = 0;
params.Treg_density.Units       = 'cell/milliliter';
params.Treg_density.Type        = 'post';
params.Treg_density.ScreenName  = 'Treg Density in Tumor';

% MDSC density
params.names = [params.names; 'MDSC_density'];
params.MDSC_density.UpperBound  = 1e13;
params.MDSC_density.LowerBound  = 0;
params.MDSC_density.Units      = 'cell/milliliter';
params.MDSC_density.Type       = 'post';
params.MDSC_density.ScreenName = 'MDSC Density in Tumor';

% Teff to Treg ratio
params.names = [params.names; 'CD8_FoxP3_T'];
params.CD8_FoxP3_T.UpperBound  = 1e8;
params.CD8_FoxP3_T.LowerBound  = 0;
params.CD8_FoxP3_T.Units      = 'dimensionless';
params.CD8_FoxP3_T.Type       = 'post';
params.CD8_FoxP3_T.ScreenName = 'Teff to Treg Ratio in Tumor';

% T cell clonality
params.names = [params.names; 'clonality'];
params.clonality.UpperBound = 1;
params.clonality.LowerBound = 0;
params.clonality.Units      = 'dimensionless';
params.clonality.Type       = 'post';
params.clonality.ScreenName = 'CD8 T cell Clonality in Blood';

params.names = [params.names; 'H_P1'];
params.H_P1.UpperBound = 1;
params.H_P1.LowerBound = 0;
params.H_P1.Units      = 'dimensionless';
params.H_P1.Type       = 'parameter';
params.H_P1.ScreenName = 'TCR Receptor Occupancy for Teff (H\_P1)';

params.names = [params.names; 'H_P0'];
params.H_P0.UpperBound = 1;
params.H_P0.LowerBound = 0;
params.H_P0.Units      = 'dimensionless';
params.H_P0.Type       = 'parameter';
params.H_P0.ScreenName = 'TCR Receptor Occupancy for Treg (H\_P0)';

params.names = [params.names; 'H_CD28_APC'];
params.H_CD28_APC.UpperBound = 1;
params.H_CD28_APC.LowerBound = 0;
params.H_CD28_APC.Units      = 'dimensionless';
params.H_CD28_APC.Type       = 'parameter';
params.H_CD28_APC.ScreenName = 'T cell Costimulatory Signaling in LN (H\_CD28)';

params.names = [params.names; 'H_PD1_C1'];
params.H_PD1_C1.UpperBound = 1;
params.H_PD1_C1.LowerBound = 0;
params.H_PD1_C1.Units      = 'dimensionless';
params.H_PD1_C1.Type       = 'parameter';
params.H_PD1_C1.ScreenName = 'Teff Inhibition by PD1/PDL1 in Tumor (H\_PD1)';

params.names = [params.names; 'H_MDSC_C1'];
params.H_MDSC_C1.UpperBound = 1;
params.H_MDSC_C1.LowerBound = 0;
params.H_MDSC_C1.Units      = 'dimensionless';
params.H_MDSC_C1.Type       = 'parameter';
params.H_MDSC_C1.ScreenName = 'Teff Inhibition by MDSC in Tumor (H\_MDSC)';

params.names = [params.names; 'H_ENT_C1'];
params.H_ENT_C1.UpperBound = 1;
params.H_ENT_C1.LowerBound = 0;
params.H_ENT_C1.Units      = 'dimensionless';
params.H_ENT_C1.Type       = 'parameter';
params.H_ENT_C1.ScreenName = 'Anti-proliferation of Tumor cell by ENT (H\_ENT)';

params.names = [params.names; 'H_APC'];
params.H_APC.UpperBound = 1;
params.H_APC.LowerBound = 0;
params.H_APC.Units      = 'dimensionless';
params.H_APC.Type       = 'parameter';
params.H_APC.ScreenName = 'APC Engagement for Treg Activation in LN (H\_APC)';

params.names = [params.names; 'H_mAPC'];
params.H_mAPC.UpperBound = 1;
params.H_mAPC.LowerBound = 0;
params.H_mAPC.Units      = 'dimensionless';
params.H_mAPC.Type       = 'parameter';
params.H_mAPC.ScreenName = 'mAPC Engagement for Teff Activation in LN (H\_mAPC)';
