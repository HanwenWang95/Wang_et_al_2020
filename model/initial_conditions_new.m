% Initial Conditions Module
%
% Generates initial conditions
%
% Inputs: model           -- pre-initialized SimBiology model object 
%         varargin        -- variant object
%        
% Outputs: model   -- initialized SimBiology model
%          success -- shows if it reached the initial tumor diameter
%          simData -- initial condition data
%
% future release: name/value pair inputs, IC output time resolution
%
% Created: Mar 25, 2019 (Richard Sové)
% Last Modified: Mar 25, 2019 (RJS)

function [model_out,success,simData] = initial_conditions_new(model_in,varargin)

model = copyobj(model_in);

if (nargin == 2)
variantWithInitialTumourDiameter = false;
% Check if 'Variant Object' Contains Initial Tumour Diameter
    for i = 1:length(varargin{1}.content)
        variantParam = varargin{1}.content{i};
        if strcmp(variantParam(2),'initial_tumour_diameter')
            % Get Initial Tumour Diameter from 'variant'
            D_Ti = sbioselect(model,'Name','initial_tumour_diameter');
            tumour_diameter.Value = variantParam{4};
            tumour_diameter.Units = D_Ti.ValueUnits;
            tumour_diameter.Notes = D_Ti.Notes;
            
            variantWithInitialTumourDiameter = true;
        end
    end
    if ~variantWithInitialTumourDiameter
        % Get Initial Tumour Diameter from 'model'
        D_Ti = sbioselect(model,'Name','initial_tumour_diameter');
        tumour_diameter.Value = D_Ti.Value;
        tumour_diameter.Units = D_Ti.ValueUnits;
        tumour_diameter.Notes = D_Ti.Notes;
    end
else
% Get Initial Tumour Diameter from 'model'
D_Ti = sbioselect(model,'Name','initial_tumour_diameter');
% if (nargin == 2)
%     D_Ti = sbioselect(varargin{1},'Name','initial_tumour_diameter');
% end
tumour_diameter.Value = D_Ti.Value;
tumour_diameter.Units = D_Ti.ValueUnits;
tumour_diameter.Notes = D_Ti.Notes;
end
% Calculate Target Tumour Volume
tumour_volume = 4/3*pi*(tumour_diameter/2)^3;

% Get User-Defined Confiuration Settings
config = getconfigset(model);
user_output_times = config.SolverOptions.OutputTimes; 
user_abs_tol = get(config.SolverOptions,'AbsoluteTolerance');
user_rel_tol = get(config.SolverOptions,'RelativeTolerance');

% Reset Output Times for IC Simulation (assumes time in days)
set(config,'StopTime',1000);
set(config.SolverOptions,'OutputTimes',[]);

% IC Simulation 
if (nargin == 1) % baseline simulation
    simData = sbiosimulate(model);
elseif (nargin == 2) % variant simulation
    simData = sbiosimulate(model,varargin{1});
else
    error('Wrong number of inputs');
end

% Get Time to Reach Target Tumour Size
% Get Tumour Volume from Simulation
% add [~,V_T,~] = selectbyname(simData, 'V_T'); <need to get units of V_T
for i = 1:size(simData.Data,2)
    if (strcmp(simData.DataInfo{i}.Name,'V_T'))
        idx = i;
        break;
    end
end
V_T = simData.Data(:,idx);
V_T_units = simData.DataInfo{idx}.Units;
% Convert Units of Target Volume to Units in Simulation
zero.Value = 0; % define 'zero' parameter object with same units as simulation
zero.Units = V_T_units;
tumour_volume = zero + tumour_volume; % operator converts to units of first input 
target_V_T = tumour_volume.Value; % tumour volume in same units as simulation
% Get Time of Target Tumour Size
idx = find((target_V_T-V_T)<0,1); % difference should cross zero at target time

% Re-Initialize Model with New ICs
if isempty(idx) % tumour did not reach target size
    success = false;
    return;
else
    success = true;
    % Reset User Defined Configuration Settings
    set(config,'StopTime',user_output_times(end));
    set(config.SolverOptions,'OutputTimes',user_output_times);
    
    % Set New ICs for Species
    for i = 1:length(model.Species)
        model.Species(i).InitialAmount = simData.Data(idx,i);
    end    
end

model_out = copyobj(model);