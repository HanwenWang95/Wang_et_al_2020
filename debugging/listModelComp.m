% Function to generate a list of model Species and Parameters for
% examination and debuging
% Inputs: model        -- simbio model object  
%        
% Outputs: modelComp -- list model components (e.g. compartments, species,
%                        parameters, reactions, rules, events)
%
% Created: Jan 20, 2019 (Mohammad Jafarnejad)
% Last Modified: Jan 20, 2019 (MJ)

function modelComp = listModelComp(model)

modelComp = struct; 
  
for i = 1:size(model.Compartments,1)
    modelComp.Compartments(i,1) = {model.Compartments(i).Name};
    modelComp.Compartments(i,2) = {model.Compartments(i).Capacity};
    modelComp.Compartments(i,3) = {model.Compartments(i).CapacityUnits};
    modelComp.Compartments(i,4) = {model.Compartments(i).Notes};
end
for i = 1:length(model.Species)
    modelComp.Species(i,1) = {model.Species(i).Name};
    modelComp.Species(i,2) = {model.Species(i).InitialAmount};
    modelComp.Species(i,3) = {model.Species(i).Parent.Name};
    modelComp.Species(i,4) = {model.Species(i).InitialAmountUnits};
    modelComp.Species(i,5) = {model.Species(i).Note};
end
for i = 1:length(model.Parameters)
    modelComp.Parameters(i,1) = {model.Parameters(i).Name};
    modelComp.Parameters(i,2) = {model.Parameters(i).Value};
    modelComp.Parameters(i,3) = {model.Parameters(i).ValueUnits};
    modelComp.Parameters(i,4) = {model.Parameters(i).Note};
end
for i = 1:size(model.Reaction,1)
    modelComp.Reactions(i,1) = {i};
    modelComp.Reactions(i,2) = {model.reaction(i).Reaction};
    modelComp.Reactions(i,3) = {model.reaction(i).ReactionRate};
    modelComp.Reactions(i,4) = {model.reaction(i).Notes};
end
for i = 1:size(model.Rules,1)
    modelComp.Rules(i,1) = {model.Rules(i).Name};
    modelComp.Rules(i,2) = {model.Rules(i).Rule};
    modelComp.Rules(i,3) = {model.Rules(i).RuleType};
    modelComp.Rules(i,4) = {model.Rules(i).active};
    modelComp.Rules(i,5) = {model.Rules(i).Notes};
end
k = 1;
for i = 1:size(model.Events,1)
    for j = 1:size(model.Events(i).EventFcns , 1)
        if j == 1
            modelComp.Events(k,1) = {i};
            modelComp.Events(k,2) = {model.Events(i).Trigger};
            modelComp.Events(k,3) =  model.Events(i).EventFcns(j);
            modelComp.Events(k,4) = {model.Events(i).Notes};
        else
            modelComp.Events(k,3) =  model.Events(i).EventFcns(j);
        end
        k = k+1;
    end
end

end

