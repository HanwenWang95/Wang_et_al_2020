% Function to run the model with parameter snesitivity analysis cases
%
% Inputs: model        -- simbio model object 
%                      -- variant for simbiology model 
%
% Outputs: model_SS    -- simbio model that has reached steady state
%
% Created: Dec 11, 2018 (Mohammad Jafarnejad)
% Last Modified: Dec 11, 2018 (MJ)

function model_SS = simbio_steadyState(model,variantObj)

%         model.Reactions(find(strcmp(ReactionRates(:,3),'SteadyState'))).Active = 1;
%         % % % % No Drugs
%         model.Parameters(find(strcmp(Parameters(:,1),'n_dose_Nivo'   ))).Value = 0;
%         model.Parameters(find(strcmp(Parameters(:,1),'dose_mg_Nivo'  ))).Value = 0;
% 
%         speciesObj = sbioselect (model, 'Where','Name', '==', params_PSA.names{i})
% 
%         configsetObj = getconfigset(model);
%         set(configsetObj, 'StopTime',  365)
%         simData_v2_00_ss  = sbiosimulate(model);
%         speciesSS = simData_v2_00_ss.data(end,:)'; 
%         for k = 1:size(model_SS.Species,1)
%             model_SS.Species(k).InitialAmount = speciesSS(k);
%         end

    model_SS = copyobj(model);

end