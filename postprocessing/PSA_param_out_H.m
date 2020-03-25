% Function to generate object with model parameters to include as outputs 
% of the parameter sensitivity analysis
%
% Input:  model  -- Simbiology model object 
%
% Output: params -- object containing output parameters
%                   -> for each parameter: 
%                       - Adds the name of the parameter to the list
%                       - defines upper and lower bounds of acceptable
%                       physiological range
%                       - specifies if the output is comaprtment,
%                       parameter, species or postprocessed parameters
%                           - for species: specifies compartment
%         Examples:      
%                 % k2
%                 params.names = [params.names; 'k2'];
%                 params.k2.UpperBound = 1; 
%                 params.k2.LowerBound = 0;
%                 params.k2.Units      = 'liter';
%                 params.k2.Type       = 'parameter';
%                 params.k2.ScreenName = 'k2 binding rate';
%
% Created: Mar 11, 2019 (Mohammad Jafarnejad)
% Last Modified: Mar 11, 2019 (MJ)

function params = PSA_param_out_H(model)

params.names = {};

for i = 1:length(model.Parameters)
    if (model.Parameters(i).Name(1)=='H')
        params.names = [params.names; model.Parameters(i).Name];
        params.(model.Parameters(i).Name).UpperBound = 1;
        params.(model.Parameters(i).Name).LowerBound = 0;
        params.(model.Parameters(i).Name).Units      = model.Parameters(i).ValueUnits;
        params.(model.Parameters(i).Name).Type       = 'parameter';
        params.(model.Parameters(i).Name).ScreenName = strrep(model.Parameters(i).Name,'_','\_');
    end
end
