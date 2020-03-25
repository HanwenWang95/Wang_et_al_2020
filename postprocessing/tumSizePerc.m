% Function to calculate and add percentage change in tumor size to 
% postprocessed parameters
%
% Inputs: simDataPSA     -- Object containing the whole simbiology model 
%                           outputs for all batch simulations 
%         simDataPSApost -- Object containing the postprocessed simbiology  
%                           model outputs for all batch simulations  
%         params_out     -- object containing model outputs to be organized
%                           for future sensitivity analysis
%        
% Outputs: simDataPSApost  -- Updated object containing postprocessed 
%                             outputs
%
% Created: Feb 17, 2019 (Mohammad Jafarnejad)
% Last Modified: Mar 20, 2019 (MJ)

function simDataPSAout = tumSizePerc(simDataPSA,simDataPSApost,params_out)

n_PSA = length(params_out.iPatient);
index = params_out.iPatient;
simDataPSAout = simDataPSApost;

for i = 1:n_PSA
    % Access tumor volume (microliter = 1e-9*m^3)
    [~,V_T,~] = selectbyname(simDataPSA(index(i)).simData, 'V_T');
    % Calculate tumor size (diameter) assuming a single sphere nodule (comes out as mm if Tum volume was at microliter)
    D_T = 2*(3/(4*pi)*V_T).^(1/3);
    % Calculates total clonality
    D_T_perc = (D_T - D_T(1))/D_T(1)*100;
    
    % Add calculated tumor size to postprocess structure
    simDataPSAout(index(i)).simData.DataNames = [simDataPSAout(index(i)).simData.DataNames; {'D_T_perc'}];
    simDataPSAout(index(i)).simData.Data      = [simDataPSAout(index(i)).simData.Data     , D_T_perc];
    simDataPSAout(index(i)).simData.DataNames = [simDataPSAout(index(i)).simData.DataNames; {'D_T'}];
    simDataPSAout(index(i)).simData.Data      = [simDataPSAout(index(i)).simData.Data     , D_T];
end

