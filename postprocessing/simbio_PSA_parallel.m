% Function to run the model with parameter snesitivity analysis cases
% NOTE: parfor (parallel for) implementation leads to an error on mac
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
% Last Modified: Mar 27, 2019 (RJS)

function [simDataPSA, params_out] = simbio_PSA_parallel(model,params_in,params_out,dose_schedule)
  
% Check if ICs are set  
new_sim = ~isfield(params_out,'ICs');  
n_PSA = length(params_in.(params_in.names{1}).LHS);

% Create the variant objects and model objects for each simulation
display(['Set up for parallel for loop ...']);
for i = 1:n_PSA
    model_PSA = copyobj(model);
    if (~new_sim)
        ICs{i}     = params_out.ICs(i).Values;
        patient(i) = params_out.patient(i);
    else
        ICs{i}     = [];
        patient(i) = 0;
    end
    variantObj = addvariant(model_PSA, ['v',num2str(i,'%5.5i')]);
    for j = 1:length(params_in.names)
        if ~isempty(sbioselect (model, 'Type', 'parameter', 'Name', params_in.names{j}))
            addcontent(variantObj, {'parameter', params_in.names{j}, 'Value', params_in.(params_in.names{j}).LHS(i)});
        end
    end
    variantObjPar{i} = variantObj;
    modelPar{i}      = copyobj(model_PSA);
    new_simPar(i)    = new_sim;
    doseObjPar{i}    = dose_schedule;
end
%% Parallel loop
display(['Run the simulations in the parallel for loop ...']);
parfor i = 1:n_PSA
    display(['Sample ',num2str(i),'/',num2str(n_PSA)]);
%     warning('off','all')
    % Initializes the model
    if (new_simPar(i))
        [model_PSA,success,~] = initial_conditions(modelPar{i},'Variant',variantObjPar{i});
        patient(i) = double(success);
    else
        success = logical(patient(i)); % 0 evaluates to false and 1,-1 evaluates to true
        model_PSA = set_ICs(modelPar{i},ICs{i});  
    end
    % Runs the initialized model for the variant with the treatment
    if (success)
        try
            simData = sbiosimulate(modelPar{i},[],variantObjPar{i},doseObjPar{i} );
            IC = get_ICs(simData);
        catch
            disp('Integration tolerance not met'); 
            simData = [];
            IC = [];
            patient(i) = -1; 
        end
    else
        disp('Initial conditions not reached'); 
        simData = [];
        IC = [];
    end
    % Saves the outputs
    simDataPSApar{i} = simData;
    ICs{i} = IC;
end
warning('on','all')
%% Assign the parfor outputs to relevant variables
display(['Assign the parallel for outputs to relevant variables ...']);
for i = 1:n_PSA
    simDataPSA(i).simData = simDataPSApar{i};
    if (new_sim)
        params_out.ICs(i) = ICs{i};
        params_out.patient(i) = patient(i);
    end
end

params_out.iPatient = find(params_out.patient == 1);
params_out.iHealthy = find(params_out.patient == 0);


%% parfor implementation sometimes give errors that could be fixed by the following
% If had "Not enough input arguments" error from parfor
% Enter matlab command window 'prefdir' --> 
% You can see C:\Users\xxx\AppData\Roaming\MathWorks\MATLAB\R2016a (or wahtever you see on your machine) --> 
% Delete local_cluster_jobs and restart matlab --> 
% I hope this will fix the issue.

% Use something like this to display progress for parfor
% https://stackoverflow.com/questions/23515240/matlab-print-progress-from-parfor-loop