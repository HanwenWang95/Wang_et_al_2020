% Function to prepare the batch simulation data and extract outputs of
% interest based on the params_out list
% Inputs: simDataPSA     -- Object containing the whole simbiology model 
%                           outputs for all batch simulations 
%         simDataPSApost -- Object containing the post processed simbiology  
%                           model outputs for all batch simulations 
%         params_out     -- object containing model outputs to be organized
%                           for future sensitivity analysis
%        
% Outputs: params_outPlaus  -- Object containing organized outputs
%         
%
% Created: Dec 11, 2018 (Mohammad Jafarnejad)
% Last Modified: Mar 20, 2019 (MJ)

function params_outPlaus = PSA_prep(simDataPSA,simDataPSApost,params_out)

n_PSA = length(params_out.iPatient);
index = params_out.iPatient;

% populate simDataPSApost with all the outputs
for i = 1:length(params_out.names)
    if     strcmpi(params_out.(params_out.names{i}).Type , 'compartment')
        for j = 1:n_PSA
            [~,temp,~] = selectbyname(simDataPSA(index(j)).simData, params_out.names{i});
            simDataPSAprep(index(j),i) = temp(end);
        end
    elseif strcmpi(params_out.(params_out.names{i}).Type , 'parameter')
        for j = 1:n_PSA
            [~,temp,~] = selectbyname(simDataPSA(index(j)).simData, params_out.names{i});
            simDataPSAprep(index(j),i) = temp(end);
        end
    elseif strcmpi(params_out.(params_out.names{i}).Type , 'species')
        for j = 1:n_PSA
            [~,temp,~] = selectbyname(simDataPSA(index(j)).simData, [(params_out.(params_out.names{i}).Compartment),'.',(params_out.(params_out.names{i}).Name)]);
            simDataPSAprep(index(j),i) = temp(end);
        end  
    elseif strcmpi(params_out.(params_out.names{i}).Type , 'post')
        for j = 1:n_PSA
            k = find(strcmp(simDataPSApost(index(j)).simData.DataNames, params_out.names{i} ));
            simDataPSAprep(index(j),i) = simDataPSApost(index(j)).simData.Data(end,k);
        end  
    end
    
end

params_outPlaus = params_out;

% find the out-of-bound outputs and the plausible simulation indeces
iPlaus = PSA_plaus(simDataPSAprep,params_out);

params_outPlaus.post          = simDataPSAprep;
params_outPlaus.iPlaus        = iPlaus;
params_outPlaus.iPatientPlaus = intersect(params_out.iPatient,iPlaus);
params_outPlaus.iHealthyPlaus = intersect(params_out.iHealthy,iPlaus);

% Adds response status (RECIST and Responder/Nonresponder) to the params_out
params_outPlaus = responseStatus(simDataPSA,simDataPSApost,params_outPlaus);


display(['PSA data prepared for further analysis.']);

