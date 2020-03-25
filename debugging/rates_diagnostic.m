% Adds some of the important rates as parameters to the model to be
% calculated algebraicly at all timepoints and will be used to plot the
% importance of different mechanisms
%
% Inputs: model  -- SimBiology model object
%        
% Outputs: model -- SimBiology model object with new parameters
%
% Created: Mar 19, 2019 (Mohammad Jafarnejad)
% Last Modified: Mar 19, 2019 (MJ)

function model = rates_diagnostic(model)

% Cancer Dyanmic Rates
% Growth
p = addparameter(model,'rate_C1_growth',1,'ValueUnits','cell/day' , 'ConstantValue', 0); set(p,'Notes','rate of Cancer cell growth');
r = addrule(model,'rate_C1_growth = k_C1_growth*V_T.C1*(1-C_total/C_max)','repeatedAssignment');
% Basal Death
p = addparameter(model,'rate_C1_deathby_base',1,'ValueUnits','cell/day' , 'ConstantValue', 0); % set(p,'Notes','rate of Cancer cell growth');
r = addrule(model,'rate_C1_deathby_base = k_C1_death*V_T.C1','repeatedAssignment');
% Death by T cells
p = addparameter(model,'rate_C1_deathby_T1',1,'ValueUnits','cell/day' , 'ConstantValue', 0); % set(p,'Notes','rate of Cancer cell growth');
r = addrule(model,'rate_C1_deathby_T1 = k_C_T1*V_T.T1*V_T.C1/(C_total+T_total+cell)*(1-H_PD1_C1)','repeatedAssignment');


% T1 cell Dynamic Rates
% Entry
p = addparameter(model,'rate_T1_entry',1,'ValueUnits','cell/day' , 'ConstantValue', 0); % set(p,'Notes','rate of Cancer cell growth');
r = addrule(model,'rate_T1_entry = q_T1_T_in*V_T*V_C.T1','repeatedAssignment');
% Basal Death 
p = addparameter(model,'rate_T1_deathby_base',1,'ValueUnits','cell/day' , 'ConstantValue', 0); % set(p,'Notes','rate of Cancer cell growth');
r = addrule(model,'rate_T1_deathby_base = k_T1_death*V_T.T1','repeatedAssignment');
% Death by Cancer cells
p = addparameter(model,'rate_T1_deathby_C1',1,'ValueUnits','cell/day' , 'ConstantValue', 0); % set(p,'Notes','rate of Cancer cell growth');
r = addrule(model,'rate_T1_deathby_C1 = k_T1*V_T.T1*C_total/(C_total+T_total+cell)*H_PD1_C1','repeatedAssignment');
% Death by Treg
p = addparameter(model,'rate_T1_deathby_T0',1,'ValueUnits','cell/day' , 'ConstantValue', 0); % set(p,'Notes','rate of Cancer cell growth');
r = addrule(model,'rate_T1_deathby_T0 = k_Treg*V_T.T1*Tregs_/(C_total+T_total+cell)','repeatedAssignment');


% T0 cell Dynamic Rates
% Entry
p = addparameter(model,'rate_T0_entry',1,'ValueUnits','cell/day' , 'ConstantValue', 0); % set(p,'Notes','rate of Cancer cell growth');
r = addrule(model,'rate_T0_entry = q_T0_T_in*V_T*V_C.T0','repeatedAssignment');
% Basal Death 
p = addparameter(model,'rate_T0_deathby_base',1,'ValueUnits','cell/day' , 'ConstantValue', 0); % set(p,'Notes','rate of Cancer cell growth');
r = addrule(model,'rate_T0_deathby_base = k_T0_death*V_T.T0','repeatedAssignment');
% Death by ADCC
p = addparameter(model,'rate_T0_deathby_ADCC',1,'ValueUnits','cell/day' , 'ConstantValue', 0); % set(p,'Notes','rate of Cancer cell growth');
r = addrule(model,'rate_T0_deathby_ADCC = k_CTLA4_ADCC*V_T.T0*H_Treg_T','repeatedAssignment');