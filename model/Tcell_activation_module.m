% Tcell Module
%
% Models Tcell transport and activation by APCs [Use before antigen corresponding module]
%
% Inputs: model      -- SimBiology model object with four compartments
%         first_call -- boolean indicating if T Cell module is being called for the first time
%         H_APC      -- string of APC hill function
%         ID         -- T cell ID number
%        
% Outputs: model -- SimBiology model object with new Tcell module
%          F_act -- parameter object containing handle for F_act
%
% Created: Jan 23, 2019 (Richard Sové)
% Last Modified: Jan 23, 2019 (RJS)

function [model,F_act,k_ratio] = Tcell_activation_module(model,first_call,H_APC,ID)

% Model Parameters (add on first call only)
if (first_call)
    % m - determined by fitting (4th order polynomial)
    addparameter(model,'a0',0.692556926727918,'ValueUnits','dimensionless');
    addparameter(model,'a1',-0.096114835729841,'ValueUnits','dimensionless');
    addparameter(model,'a2',0.008638124313520,'ValueUnits','dimensionless');
    addparameter(model,'a3',-0.000403990701606,'ValueUnits','dimensionless');
    addparameter(model,'a4',0.000007591612050,'ValueUnits','dimensionless');
    addparameter(model,'m',0,'ConstantValue',false,'ValueUnits','dimensionless');
    addrule(model,'m = a0 + a1*N_aT + a2*N_aT^2 + a3*N_aT^3 + a4*N_aT^4','repeatedAssignment');
    % k - determined by setting f(x*) = f*
    addparameter(model,'k',0,'ConstantValue',false,'ValueUnits','dimensionless');
    addrule(model,'k = -log((exp(N_aT)-1)/(2*exp(N_aT)-1)/(1-exp(-N_aT)))','repeatedAssignment'); 
end
% F_act (needs to be set for each T Cell species)
k_ratio = addparameter(model,'k_ratio',0,'ValueUnits','dimensionless');
addrule(model,'k_ratio = k_pro/k_act','initialAssignment');
F_act = addparameter(model,'F_act',0,'ConstantValue',false,'ValueUnits','cell');
str = ['F_act = V_LN.aT*(1-(1-exp(-N_aT))*exp(-k*(k_ratio*V_LN.aT/(' H_APC '*V_LN.nT+1e-9)/(2*exp(N_aT)-1))^m))'];
addrule(model,str,'repeatedAssignment');

% Rename k_ratio
rename(k_ratio,['k_ratio_' ID]);

% Remove MATLAB Warnings for dimensional analysis in MATLAB functions
warning('off','SimBiology:DimAnalysisNotDone_MatlabFcn_Dimensionless');