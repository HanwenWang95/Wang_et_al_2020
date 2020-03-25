% SimBiology Plot Generator
%
% Plots SimBiology Data
%
% Inputs: simData - SimBiology output data
%         name    - string with species name
%
% Optional Name-Value Pairs
%         legendEntry -- string containing legend entry
%         compartmentName -- string containing compartment name <required for species in multiple compartments>
%         axisLabel -- srting containing y-axis label, units are added by default
%         
% Created: Nov 12, 2018 (Richard Sové)
% Last Modified: Feb 28, 2019 (RJS) 

function simbio_plot(simData,name,varargin)

% Optional Inputs
p = inputParser;
addParameter(p,'legendEntry','');
addParameter(p,'compartmentName','');
addParameter(p,'axisLabel','');
addParameter(p,'surfaceArea','');
parse(p,varargin{:});
legend = p.Results.legendEntry;
comp = p.Results.compartmentName;
axis_label = p.Results.axisLabel;
compA = p.Results.surfaceArea;

% Set Figure Defaults
figure_defaults;

% Get Data Index
for i = 1:size(simData.Data,2)
    if (~isempty(comp))
        try
            comp_match = strcmp(simData.DataInfo{i}.Compartment,comp);
        catch
            break;
        end
    else
        comp_match = true;
    end
    if (strcmp(simData.DataInfo{i}.Name,name)&&comp_match)
        idx = i;
        break;
    end
end

% Plot Data
try
    if isempty(compA)
        plot(simData.time,simData.data(:,idx),'DisplayName',legend); % plot data
        units = simData.DataInfo{idx}.Units; % get units for y-axis label
        if (strcmp(units,'dimensionless')||strcmp(units,'cell'))
            units = ''; % do not display units for dimensionless quantities
        else
            units = symunit2str(str2symunit(units,'SimBiology'),'Simulink'); % convert to symbols
            units = [' ($' units '$)']; % enclose units in brackets
        end
        ystring = [axis_label units]; 
        xlabel('Time (days)'); ylabel(ystring);
    else
        % Plots #of molecules on the surface of the cell or endosome given
        % surface area and if data is in mole/micrometer^2
        plot(simData.time,simData.data(:,idx)*str2double(compA),'DisplayName',legend); % plot data
        units = ' ($\#$ of molecules)'; % enclose units in brackets
        ystring = [axis_label units]; 
        xlabel('Time (days)'); ylabel(ystring);
    end
catch
    disp(['Species ' name ' not found']);
end
