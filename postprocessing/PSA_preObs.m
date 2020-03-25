% Function to add pre-treatment observables to the params_in
%
% Inputs: simDataPSA     -- Object containing the whole simbiology model 
%                           outputs for all batch simulations 
%         simDataPSApost -- Object containing the post processed simbiology  
%                           model outputs for all batch simulations 
%         params_in      -- object containing model inputs to be organized
%                           for future sensitivity analysis 
%         params_out     -- object containing model outputs to be organized
%                           for future sensitivity analysis
%        
% Outputs: simDataPSApost  -- Object containing postprocessed outputs
%
% Created: Mar 20, 2019 (Mohammad Jafarnejad)
% Last Modified: Mar 20, 2019 (MJ)

function params = PSA_preObs(simDataPSA,simDataPSApost,params_in,params_out)

n_PSA = length(params_out.iPatient);
index = params_out.iPatient;

params = params_in;
params.allObs = zeros(length(params_out.patient),length(params_in.namesObs));

% populate simDataPSApost with all the outputs
for i = 1:length(params_in.namesObs)
    if     strcmpi(params_in.(params_in.namesObs{i}).Type , 'compartment')
        for j = 1:n_PSA
            [~,temp,~] = selectbyname(simDataPSA(index(j)).simData, params_in.namesObs{i});
            params.allObs(index(j),i) = temp(1);
        end
    elseif strcmpi(params_in.(params_in.namesObs{i}).Type , 'parameter')
        for j = 1:n_PSA
            [~,temp,~] = selectbyname(simDataPSA(index(j)).simData, params_in.namesObs{i});
            params.allObs(index(j),i) = temp(1);
        end
    elseif strcmpi(params_in.(params_in.namesObs{i}).Type , 'species')
        for j = 1:n_PSA
            [~,temp,~] = selectbyname(simDataPSA(index(j)).simData, [(params_in.(params_in.namesObs{i}).Compartment),'.',(params_in.(params_in.namesObs{i}).Name)]);
            params.allObs(index(j),i) = temp(1);
        end  
    elseif strcmpi(params_in.(params_in.namesObs{i}).Type , 'post')
        for j = 1:n_PSA
            k = find(strcmp(simDataPSApost(index(j)).simData.DataNames, params_in.namesObs{i} ));
            params.allObs(index(j),i) = simDataPSApost(index(j)).simData.Data(1,k);
        end  
    end
    
end

display(['Pre-treatment observables are added']);


    

