% Function to generate object with random variation in the parameters
% of interest to be varied in parameter snesitivity analysis
%
% Inputs: model        -- simbio model object  
%         params       -- object containing model parameter Values, Median, LowerBound, UpperBound, type of distribution:
%         n_PSA        -- number of samples
%        
% Outputs: params_in -- sampled parameter values for params and n_PSA 
%
% Created: Dec 04, 2018 (Mohammad Jafarnejad)
% Last Modified: Mar 15, 2019 (MJ)

function params_in = PSA_setup(model,params,n_PSA)

params_in = params;

% Create LHS fit samples between 0 and 1
lhs = lhsdesign(n_PSA, length(params.names));

for i = 1:length(params.names)
    
   if     strcmp(params.(params.names{i}).Sampling , 'uniform')
       LB = params.(params.names{i}).LowerBound;
       UB = params.(params.names{i}).UpperBound;
       params_in.(params.names{i}).LHS = LB + (UB-LB) * lhs(:,i);
       params_in.all(:,i) = params_in.(params.names{i}).LHS;
       
   elseif strcmp(params.(params.names{i}).Sampling , 'loguniform')
       LB = params.(params.names{i}).LowerBound;
       UB = params.(params.names{i}).UpperBound;
       params_in.(params.names{i}).LHS = 10.^( log10(LB) + (log10(UB)-log10(LB)) * lhs(:,i) );
       params_in.all(:,i) = params_in.(params.names{i}).LHS;
       
   elseif strcmp(params.(params.names{i}).Sampling , 'normal')
       Median = params.(params.names{i}).Median;
       Sigma  = params.(params.names{i}).Sigma;
       params_in.(params.names{i}).LHS = icdf('Normal',lhs(:,i),Median,Sigma);
       params_in.all(:,i) = params_in.(params.names{i}).LHS;
       
   elseif strcmp(params.(params.names{i}).Sampling , 'lognormal') 
       Median = params.(params.names{i}).Median;
       Sigma  = params.(params.names{i}).Sigma;
       params_in.(params.names{i}).LHS = icdf('Lognormal',lhs(:,i),Median,Sigma);
       params_in.all(:,i) = params_in.(params.names{i}).LHS;
   end
   
end

