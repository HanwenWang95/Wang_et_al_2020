% Function to export simbiology model components into excel files
%
% Inputs: model -- SimBiology model object 
%
%
% Created: Feb 19, 2019 (Mohammad Jafarnejad)
% Last Modified: Feb 19, 2019 (MJ)

function simbio_export(model,name)

% create  list of Comaprtments, species, parameters, reactions, rules, and events 

for i = 1:size(model.Compartments,1)
    Compartments(i,1) = {model.Compartments(i).Name};
    Compartments(i,2) = {model.Compartments(i).Capacity};
    Compartments(i,3) = {model.Compartments(i).CapacityUnits};
    Compartments(i,4) = {model.Compartments(i).Notes};
end
Compartments = cell2table(Compartments);
Compartments.Properties.VariableNames = {'Name' 'Capacity' 'CapacityUnits' 'Notes'};

for i = 1:size(model.Species,1)
    Species(i,1) = {model.Species(i).Name};
    Species(i,2) = {model.Species(i).InitialAmount};
    Species(i,3) = {model.Species(i).InitialAmountUnits};
    Species(i,4) = {model.Species(i).Parent.Name};
    Species(i,5) = {model.Species(i).Notes};
end
Species = cell2table(Species);
Species.Properties.VariableNames = {'Name' 'InitialAmount' 'InitialAmountUnits' 'Parent' 'Notes'};

for i = 1:size(model.Parameters,1)
    Parameters(i,1) = {model.Parameters(i).Name};
    Parameters(i,2) = {model.Parameters(i).Value};
    Parameters(i,3) = {model.Parameters(i).ValueUnits};
    Parameters(i,4) = {model.Parameters(i).Notes};
end
Parameters = cell2table(Parameters);
Parameters.Properties.VariableNames = {'Name' 'Value' 'ValueUnits' 'Notes'};

for i = 1:size(model.Reaction,1)
    Reactions(i,1) = {i};
    Reactions(i,2) = {model.Reaction(i).Reaction};
    Reactions(i,3) = {model.Reaction(i).ReactionRate};
    Reactions(i,4) = {model.Reaction(i).Notes};
end
Reactions = cell2table(Reactions);
Reactions.Properties.VariableNames = {'ID' 'Reaction' 'ReactionRate' 'Notes'};

for i = 1:size(model.Rules,1)
    Rules(i,1) = {i};
    Rules(i,2) = {model.Rules(i).Rule};
    Rules(i,3) = {model.Rules(i).RuleType};
    Rules(i,4) = {model.Rules(i).Notes};
end
Rules = cell2table(Rules);
Rules.Properties.VariableNames = {'ID' 'Rule' 'RuleType' 'Notes'};

numEvents = size(model.Events,1);
if numEvents > 0
k = 1;
for i = 1:size(model.Events,1)
    for j = 1:size(model.Events(i).EventFcns , 1)
        if j == 1
            Events(k,1) = {i};
            Events(k,2) = {model.Events(i).Trigger};
            Events(k,3) =  model.Events(i).EventFcns(j);
            Events(k,4) = {model.Events(i).Notes};
        else
            Events(k,3) =  model.Events(i).EventFcns(j);
        end
        k = k+1;
    end
end
Events = cell2table(Events);
Events.Properties.VariableNames = {'ID' 'Trigger' 'EventFunction' 'Notes'};
end


%% Write to excel files individually and all-in-one
filenameCompartments = [ name,'_Compartments.xlsx'     ];
filenameSpecies      = [ name,'_species.xlsx'          ];
filenameParameters   = [ name,'_parameters.xlsx'       ];
filenameReactions    = [ name,'_reactions.xlsx'        ];
filenameRules        = [ name,'_rules.xlsx'            ];
filenameEvents       = [ name,'_Events.xlsx'           ];
filenameAll          = [ name,'_all.xlsx'              ];

% writetable(Compartments  , filenameCompartments);
% writetable(Species       , filenameSpecies     );
% writetable(Parameters    , filenameParameters  );
% writetable(Reactions     , filenameReactions   );
% writetable(Rules         , filenameRules       );
% if numEvents > 0
% writetable(Events        , filenameEvents      );
% end

writetable(Compartments  , filenameAll, 'Sheet', 'Compartments');
writetable(Species       , filenameAll, 'Sheet', 'Species'     );
writetable(Parameters    , filenameAll, 'Sheet', 'Parameters'  );
writetable(Reactions     , filenameAll, 'Sheet', 'Reactions'   );
writetable(Rules         , filenameAll, 'Sheet', 'Rules'       );
if numEvents > 0
writetable(Events        , filenameAll, 'Sheet', 'Events'      );
end

display('Model contents exported successfully')