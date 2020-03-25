% Function to generate object with model parameters to be added as
% pre-treatment conditions to investigate biomarkers
%
% Inputs: params_in  -- object containing model inputs to be organized
%                       for future sensitivity analysis
%
% Output: params -- object containing observable parameters
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
%                 params.k1.Units      = 'liter';
%                 params.k1.Type       = 'compartment';
%                 params.k1.ScreenName = 'k1 binding rate';
%
%                 % k2
%                 params.names = [params.names; 'k2'];
%                 params.k2.Units      = 'liter';
%                 params.k2.Type       = 'parameter';
%                 params.k2.ScreenName = 'k2 binding rate';
%
%                 % k3 in central
%                 params.names = [params.names; 'k3_C'];
%                 params.k3_C.Units       = 'cell';
%                 params.k3_C.Type        = 'species';
%                 params.k3_C.Name        = 'k2';
%                 params.k3_C.Compartment = 'V_C';
%                 params.k3.ScreenName    = 'k3 binding rate';
%
%                 % k4 post processed
%                 params.names = [params.names; 'k4'];
%                 params.k4.Units       = 'dimensionless';
%                 params.k4.Type        = 'post';
%                 params.k4.ScreenName  = 'k4 binding rate';
% NOTE: for postprocessed parameters ensure the name here is the same as
%       the name assigned in the postprocess functions

% Created: Mar 18, 2018 (Mohammad Jafarnejad)
% Last Modified: Oct 3, 2019 (HW)

function params = PSA_param_obs(params_in)

params = params_in;

params.namesObs = {};

% Number of T1 cells in the tumor
params.namesObs = [params.namesObs; 'Teff_density'];
params.Teff_density.Units       = 'cell/milliliter';
params.Teff_density.Type        = 'post';
params.Teff_density.ScreenName  = 'Teff density in Tumor';

% Number of T1 cells in the tumor
params.namesObs = [params.namesObs; 'Treg_density'];
params.Treg_density.Units       = 'cell/milliliter';
params.Treg_density.Type        = 'post';
params.Treg_density.ScreenName  = 'Treg density in Tumor';

% Number of T1 cells in the tumor
% params.namesObs = [params.namesObs; 'T1_T'];
% params.T1_T.Units       = 'cell';
% params.T1_T.Type        = 'species';
% params.T1_T.Name        = 'T1';
% params.T1_T.Compartment = 'V_T';
% params.T1_T.ScreenName  = 'Number of T1 cells in Tumor';

% Number of T0 cells in the tumor
% params.namesObs = [params.namesObs; 'T0_T'];
% params.T0_T.Units       = 'cell';
% params.T0_T.Type        = 'species';
% params.T0_T.Name        = 'T0';
% params.T0_T.Compartment = 'V_T';
% params.T0_T.ScreenName  = 'Number of T0 cells in Tumor';

% Number of T1 cells in the blood
% params.namesObs = [params.namesObs; 'T1_C'];
% params.T1_C.Units       = 'cell';
% params.T1_C.Type        = 'species';
% params.T1_C.Name        = 'T1';
% params.T1_C.Compartment = 'V_C';
% params.T1_C.ScreenName  = 'Number of T1 cells in blood';

% Number of T0 cells in the blood
% params.namesObs = [params.namesObs; 'T0_C'];
% params.T0_C.Units       = 'cell';
% params.T0_C.Type        = 'species';
% params.T0_C.Name        = 'T0';
% params.T0_C.Compartment = 'V_C';
% params.T0_C.ScreenName  = 'Number of T0 cells in blood';

% MDSC density
params.namesObs = [params.namesObs; 'MDSC_density'];
params.MDSC_density.Units      = 'cell/milliliter';
params.MDSC_density.Type       = 'post';
params.MDSC_density.ScreenName = 'MDSC density in tumor';

% Teff to Treg ratio
params.namesObs = [params.namesObs; 'CD8_FoxP3_T'];
params.CD8_FoxP3_T.Units      = 'dimensionless';
params.CD8_FoxP3_T.Type       = 'post';
params.CD8_FoxP3_T.ScreenName = 'Teff to Treg ratio in tumor';
