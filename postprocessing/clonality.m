% Function to calculate and add clonality to postprocessed parameters
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
% Created: Jan 22, 2019 (Mohammad Jafarnejad)
% Last Modified: Mar 20, 2019 (MJ)

function simDataPSAout = clonality(simDataPSA,simDataPSApost,params_out)

n_PSA = length(params_out.iPatient);
index = params_out.iPatient;
simDataPSAout = simDataPSApost;

% Need to define these based on the literature or individual patient data
diver     = 1e6;      % diversity of naive T cells
nT        = 1e2;      % number of naive T cells per naive clone

for i = 1:n_PSA
    T_C_total = diver*nT; % total naive CD8 T cells in the blood
    % Calculates the number of clones for that simulation
    numClones = howManyClones(simDataPSA(index(i)).simData);
    % Calculates total CD8 T cells in the blood
    for j=1:numClones
        [~,Ti,~] = selectbyname(simDataPSA(index(i)).simData, ['V_C.T',num2str(j)]);
        T_C_total = T_C_total + Ti;
    end
    % Adds the contribution of naive CD8 clones
    CD8clonality = diver.*(nT./T_C_total).*log2(nT./T_C_total);
    % Adds the contribution of effector CD8 clones
    for j=1:numClones
        [~,Ti,~] = selectbyname(simDataPSA(index(i)).simData, ['V_C.T',num2str(j)]);
        CD8clonality = CD8clonality + (Ti./T_C_total).*log2(Ti./T_C_total);
    end
    
    % calculates total clonality
    CD8clonality = 1 + CD8clonality./log2(diver+numClones);
    
    % Add calculated clonality to postprocess structure
    simDataPSAout(index(i)).simData.DataNames = [simDataPSAout(index(i)).simData.DataNames; {'clonality'}];
    simDataPSAout(index(i)).simData.Data      = [simDataPSAout(index(i)).simData.Data     , CD8clonality];
    simDataPSAout(index(i)).simData.DataNames = [simDataPSAout(index(i)).simData.DataNames; {'T_C_total'}];
    simDataPSAout(index(i)).simData.Data      = [simDataPSAout(index(i)).simData.Data     , T_C_total];
end

