% Treg CTLA4 Module
%
% Models Treg depletion through antibody binding to CTLA4 
% [Use after checkopoint and Treg module]
%
% Inputs: model        -- SimBiology model object with four compartments 
%         params       -- object containing the default parameters 
%        
% Outputs: model -- SimBiology model object with new Treg-CTLA4 module
%
% Created: Mar 04, 2019 (Mohammad Jafarnejad)
% Last Modified: Mar 04, 2019 (MJ)

function model = Treg_ADCC_module(model,params)

% Determine if some of the prameters that could have been defined in Checkpoint module are defined   
first_call = true;
try % Add kon Values
    kon = addparameter(model,'kon_CTLA4_ipi',params.kon_CTLA4_ipi.Value,'ValueUnits',params.kon_CTLA4_ipi.Units);
    set(kon,'Notes',['kon of CTLA4-ipilimumab binding ' params.kon_CTLA4_ipi.Notes]);
catch 
    first_call = false;
end
if first_call
% add Ipi PK if it does not exist yet
model = pk_module(model,'ipi' ,ipi_params);
% Add koff Values
koff = addparameter(model,'koff_CTLA4_ipi',params.koff_CTLA4_ipi.Value,'ValueUnits',params.koff_CTLA4_ipi.Units);
    set(koff,'Notes',['koff of CTLA4-ipilimumab binding ' params.koff_CTLA4_ipi.Notes]);
% Bivalent anibody parameters  
p = addparameter(model,'Chi_CTLA4_ipi' ,params.Chi_CTLA4_ipi.Value ,'ValueUnits',params.Chi_CTLA4_ipi.Units);
    set(p,'Notes',['Antibody cross-arm binding efficiency ' params.Chi_CTLA4_ipi.Notes]);
end

% Add area of a T cell if not defined before in antigen module
try 
    parameter = addparameter(model,'A_Tcell' ,params.A_Tcell.Value ,'ValueUnits',params.A_Tcell.Units);
    set(parameter,'Notes',['Surface area of the T cell ' params.A_Tcell.Notes]);
catch 
end

% Total amount of CTLA4 on Treg
p = addparameter(model,'Treg_CTLA4_tot',params.Treg_CTLA4_tot.Value,'ValueUnits',params.Treg_CTLA4_tot.Units,'ConstantValue',false);
    set(p,'Notes',['Total number of CTLA4 on Treg cells ' params.Treg_CTLA4_tot.Notes]);   
% CTLA4-related Hill parameters
p = addparameter(model,'Treg_CTLA4_50',params.Treg_CTLA4_50.Value,'ValueUnits',params.Treg_CTLA4_50.Units);
    set(p,'Notes',['CTLA4 occupancy for half-maximal Treg inactivation by macrophages' params.Treg_CTLA4_50.Notes]);
p = addparameter(model,'n_Treg_CTLA4',params.n_Treg_CTLA4.Value,'ValueUnits',params.n_Treg_CTLA4.Units);
    set(p,'Notes',['CTLA4 occupancy Hill coefficient for Treg inactivation by macrophages' params.n_Treg_CTLA4.Notes]);   
% Treg ADCC rates
p = addparameter(model,'k_CTLA4_ADCC',params.k_CTLA4_ADCC.Value,'ValueUnits',params.k_CTLA4_ADCC.Units,'ConstantValue',false);
    set(p,'Notes',[params.k_CTLA4_ADCC.Notes]);  
% Define Hill function for ADCC in tumor and peripheral compartments
addparameter(model,'H_Treg_T',0.0,'ValueUnits','dimensionless','ConstantValue',false);
addparameter(model,'H_Treg_P',0.0,'ValueUnits','dimensionless','ConstantValue',false);    

% Species for states of CTLA4 on Treg
x = addspecies(model.Compartment(3),'Treg_CTLA4',0,'InitialAmountUnits','molecule');
    set(x,'Notes','Number of free CTLA4 molecules on Treg in Tumour compartment');
x = addspecies(model.Compartment(3),'Treg_CTLA4_ipi',0,'InitialAmountUnits','molecule');
    set(x,'Notes','Number of CTLA4-ipilimumab complex on Treg in Tumour compartment');
x = addspecies(model.Compartment(3),'Treg_CTLA4_ipi_CTLA4',0,'InitialAmountUnits','molecule');
    set(x,'Notes','Number of CTLA4-ipilimumab-CTLA4 complex on Treg in Tumour compartment');
x = addspecies(model.Compartment(2),'Treg_CTLA4',0,'InitialAmountUnits','molecule');
    set(x,'Notes','Number of free CTLA4 molecules on Treg in Peripheral compartment');
x = addspecies(model.Compartment(2),'Treg_CTLA4_ipi',0,'InitialAmountUnits','molecule');
    set(x,'Notes','Number of CTLA4-ipilimumab complex on Treg in Peripheral compartment');
x = addspecies(model.Compartment(2),'Treg_CTLA4_ipi_CTLA4',0,'InitialAmountUnits','molecule');
    set(x,'Notes','Number of CTLA4-ipilimumab-CTLA4 complex on Treg in Peripheral compartment');
    
% Initialize the total CTLA4 on the cells 
addrule(model,'V_T.Treg_CTLA4 = Treg_CTLA4_tot' ,'initialAssignment');
addrule(model,'V_P.Treg_CTLA4 = Treg_CTLA4_tot' ,'initialAssignment');  
% Add the Hill parameters and the rules for them
addrule(model,'H_Treg_T = ((V_T.Treg_CTLA4_ipi+2*V_T.Treg_CTLA4_ipi_CTLA4)/Treg_CTLA4_50)^n_Treg_CTLA4/(((V_T.Treg_CTLA4_ipi+2*V_T.Treg_CTLA4_ipi_CTLA4)/Treg_CTLA4_50)^n_Treg_CTLA4 + 1)','repeatedAssignment');
addrule(model,'H_Treg_P = ((V_P.Treg_CTLA4_ipi+2*V_P.Treg_CTLA4_ipi_CTLA4)/Treg_CTLA4_50)^n_Treg_CTLA4/(((V_P.Treg_CTLA4_ipi+2*V_P.Treg_CTLA4_ipi_CTLA4)/Treg_CTLA4_50)^n_Treg_CTLA4 + 1)','repeatedAssignment');

% Binding and unbinding of Ipi to CTLA4 on Treg on Tumour and Peripheral
R = addreaction(model, 'V_T.Treg_CTLA4 <-> V_T.Treg_CTLA4_ipi');
    set (R, 'ReactionRate', 'kon_CTLA4_ipi*(V_T.Treg_CTLA4 * V_T.ipi/gamma_C_ipi) -  koff_CTLA4_ipi*V_T.Treg_CTLA4_ipi');
    set (R, 'Notes'       , 'binding and unbinding of CTLA4 to Ipi on Treg surface in Tumor');
R = addreaction(model, 'V_T.Treg_CTLA4_ipi + V_T.Treg_CTLA4 <-> V_T.Treg_CTLA4_ipi_CTLA4');
    set (R, 'ReactionRate', 'Chi_CTLA4_ipi*kon_CTLA4_ipi*(V_T.Treg_CTLA4 * V_T.Treg_CTLA4_ipi)/A_Tcell -  koff_CTLA4_ipi*V_T.Treg_CTLA4_ipi_CTLA4');
    set (R, 'Notes'       , 'binding and unbinding of CTLA4 to CTLA4-Ipi on Treg surface in Tumor');    
R = addreaction(model, 'V_P.Treg_CTLA4 <-> V_P.Treg_CTLA4_ipi');
    set (R, 'ReactionRate', 'kon_CTLA4_ipi*(V_P.Treg_CTLA4 * V_P.ipi/gamma_P_ipi) -  koff_CTLA4_ipi*V_P.Treg_CTLA4_ipi');
    set (R, 'Notes'       , 'binding and unbinding of CTLA4 to Ipi on Treg surface in Peripheral compartment');
R = addreaction(model, 'V_P.Treg_CTLA4_ipi + V_P.Treg_CTLA4 <-> V_P.Treg_CTLA4_ipi_CTLA4');
    set (R, 'ReactionRate', 'Chi_CTLA4_ipi*kon_CTLA4_ipi*(V_P.Treg_CTLA4 * V_P.Treg_CTLA4_ipi)/A_Tcell -  koff_CTLA4_ipi*V_P.Treg_CTLA4_ipi_CTLA4');
    set (R, 'Notes'       , 'binding and unbinding of CTLA4 to CTLA4-Ipi on Treg surface in Peripheral compartment');
    
% Treg Death through CTLA4 binding
R = addreaction(model,'V_T.T0 -> null');
    set(R,'ReactionRate','k_CTLA4_ADCC*V_T.T0*H_Treg_T');
    set(R,'Notes','CTLA4 ADCC in the tumor compartment');
R = addreaction(model,'V_P.T0 -> null');
    set(R,'ReactionRate','k_CTLA4_ADCC*V_P.T0*H_Treg_P');
    set(R,'Notes','CTLA4 ADCC in the peripheral compartment');


  
    