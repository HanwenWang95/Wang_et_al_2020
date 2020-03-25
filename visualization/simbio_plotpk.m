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
% Last Modified: Jun 18, 2019 (Hanwen Wang)

function simbio_plotpk(simData,name,varargin)

% Optional Inputs
p = inputParser;
addParameter(p,'legendEntry','');
addParameter(p,'compartmentName','V_C');
addParameter(p,'unit','ugml');
addParameter(p,'Gamma',0.686);
addParameter(p,'MW',1.486e5);
parse(p,varargin{:});
legend = p.Results.legendEntry;
comp = p.Results.compartmentName;
unit = p.Results.unit;
Gamma = p.Results.Gamma;
MW = p.Results.MW;

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

% Convert unit from M to ng/mL and apparent conc. to plasma conc. (MW in g/mole)
if (strcmp(unit,'ngmL'))
    u = 1e6;
else
    u = 1e3;
end
Conc = simData.data(:,idx).*MW.*u./Gamma;

% Plot Data
try
    plot(simData.time,Conc,'DisplayName',legend); % plot data
    if (strcmp(unit,'ngmL'))
        units = ['(ng/mL)']; % enclose units in brackets
    else
        units = ['($\mu$g/mL)']; % enclose units in brackets
    end
    ystring = ['Plasma Concentration' units];
    xlabel('Time (days)'); ylabel(ystring);
catch
    disp(['Species ' name ' not found']);
end
