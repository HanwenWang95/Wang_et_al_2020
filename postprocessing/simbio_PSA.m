% Function to run the model with parameter snesitivity analysis cases
%
% Inputs: model         -- simbio model object
%         params_in     -- object containing LHS values of model parameters
%         params_out    -- object containing a list of output parameters
%         dose_schedule -- dose object
%
% Outputs: simDataPSA  -- results from the LHS simulations
%          params_out  -- updated out parameters object containing patients
%                         status (1:patient,0:healthy,-1:simulation failed to converge)
%
% Created: Dec 11, 2018 (Mohammad Jafarnejad)
% Last Modified: Oct 3, 2019 (HW)

function [simDataPSA, params_out] = simbio_PSA(model,params_in,params_out,dose_schedule)

% Check if ICs are set
new_sim = ~isfield(params_out,'ICs');

n_PSA = length(params_in.(params_in.names{1}).LHS);

for i = 1:n_PSA
    % Set the new parameters
    model_PSA = copyobj(model);
    variantObj = addvariant(model_PSA, ['v',num2str(i,'%5.5i')]);
    for j = 1:length(params_in.names)
        if ~isempty(sbioselect (model, 'Type', 'parameter', 'Name', params_in.names{j}))
            addcontent(variantObj, {'parameter', params_in.names{j}, 'Value', params_in.(params_in.names{j}).LHS(i)});
        end
    end

    % Set Initial Conditions
    if (new_sim || isempty(params_out.ICs(i).Values))
      [model_PSA,success,~] = initial_conditions(model_PSA,'Variant',variantObj);
      params_out.patient(i) = double(success);
    else
      success = logical(params_out.patient(i));
      model_PSA = set_ICs(model_PSA,params_out.ICs(i).Values);
    end

    % Run the model with drugs
    display(['Sample ',num2str(i),'/',num2str(n_PSA)]);
    if (success)
          try
              simData = sbiosimulate(model_PSA,[],variantObj,dose_schedule);
          catch
              disp('Integration tolerance not met');
              simData = [];
              params_out.patient(i) = -1;
          end
    else
        disp('Initial conditions not reached');
        simData = [];
    end

    % save model output struture within an array of structures
    simDataPSA(i).simData = simData;

    % save model ICs
    params_out.ICs(i).Values = get_ICs(simData);
end

params_out.iPatient = find(params_out.patient == 1);
params_out.iHealthy = find(params_out.patient == 0);

%% parfor implementation gives error on MJ's mac machine
% If had "Not enough input arguments" error from parfor
% Enter matlab command window 'prefdir' -->
% You can see C:\Users\xxx\AppData\Roaming\MathWorks\MATLAB\R2016a (or wahtever you see on your machine) -->
% Delete local_cluster_jobs and restart matlab -->
% I hope this will fix the issue.
