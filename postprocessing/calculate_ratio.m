% This function calculates the ratios of T cell sunsets
%
% Inputs: simDataPSA     -- Object containing the whole simbiology model
%                           outputs for all batch simulations
%         simDataPSApost -- Object containing the postprocessed simbiology
%                           model outputs for all batch simulations
%         params_out     -- object containing model outputs to be organized
%                           for future sensitivity analysis
%
% Outputs: simDataPSAout  -- Updated object containing postprocessed
%                            outputs
%
% Created: Jul 21, 2019 (Hanwen Wang)
% Last Modified: Oct 3, 2019 (HW)

function simDataPSAout = calculate_ratio(simDataPSA,simDataPSApost,params_out)

n_PSA = length(params_out.iPatient);
index = params_out.iPatient;
simDataPSAout = simDataPSApost;

% Need to define these based on the literature or individual patient data
diver     = 1e6;      % diversity of naive T cells
nT        = 1e2;      % number of naive T cells per naive clone

for i = 1:n_PSA
    T_C_total = diver*nT; % total naive CD8 T cells in the blood
    T_T_total = 0;
    T0_C_total = 0; % total naive CD4 T cells needs to be determined
    T0_T_total = 0;
    % Calculates the number of clones for that simulation
    numClones = howManyClones(simDataPSA(index(i)).simData);
    % Calculates total CD8 T cells
    for j=1:numClones
        [~,Ti,~] = selectbyname(simDataPSA(index(i)).simData, ['V_C.T',num2str(j)]);
        T_C_total = T_C_total + Ti;

        [~,Ti,~] = selectbyname(simDataPSA(index(i)).simData, ['V_T.T',num2str(j)]);
        T_T_total = T_T_total + Ti;
    end
    % Calculate total FoxP3+ T cells
    [~,Ti,~] = selectbyname(simDataPSA(index(i)).simData, ['V_C.T0']);
    T0_C_total = T0_C_total + Ti;

    [~,Ti,~] = selectbyname(simDataPSA(index(i)).simData, ['V_T.T0']);
    T0_T_total = T0_T_total + Ti;

    % Calculate total MDSC in Tumor
    [~,MDSC_total,~] = selectbyname(simDataPSA(index(i)).simData, 'V_T.MDSC');

    % Calculate ratios of T cell subsets
    CD8FoxP3ratio_C = T_C_total./T0_C_total;
    CD8FoxP3ratio_T = T_T_total./T0_T_total;
    % Calculate T cell density
    [~,V_T,~] = selectbyname(simDataPSA(index(j)).simData, 'V_T');
    Teff_density = T_T_total./V_T;
    Treg_density = T0_T_total./V_T;
    % Calculate MDSC density
    MDSC_density = MDSC_total./V_T;

    % Add calculated clonality to postprocess structure
    simDataPSAout(index(i)).simData.DataNames = [simDataPSAout(index(i)).simData.DataNames; {'CD8_FoxP3_C'}];
    simDataPSAout(index(i)).simData.Data      = [simDataPSAout(index(i)).simData.Data     , CD8FoxP3ratio_C];
    simDataPSAout(index(i)).simData.DataNames = [simDataPSAout(index(i)).simData.DataNames; {'CD8_FoxP3_T'}];
    simDataPSAout(index(i)).simData.Data      = [simDataPSAout(index(i)).simData.Data     , CD8FoxP3ratio_T];
    % Add calculated density to postprocess structure
    simDataPSAout(index(i)).simData.DataNames = [simDataPSAout(index(i)).simData.DataNames; {'Teff_density'}];
    simDataPSAout(index(i)).simData.Data      = [simDataPSAout(index(i)).simData.Data     , Teff_density];
    simDataPSAout(index(i)).simData.DataNames = [simDataPSAout(index(i)).simData.DataNames; {'Treg_density'}];
    simDataPSAout(index(i)).simData.Data      = [simDataPSAout(index(i)).simData.Data     , Treg_density];
    simDataPSAout(index(i)).simData.DataNames = [simDataPSAout(index(i)).simData.DataNames; {'MDSC_density'}];
    simDataPSAout(index(i)).simData.Data      = [simDataPSAout(index(i)).simData.Data     , MDSC_density];
end
