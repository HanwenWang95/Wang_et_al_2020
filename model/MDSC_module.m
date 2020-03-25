% MDSC Module
%
% Inputs: model        -- simbio model object with four compartments
%         species      - MDSC--Myeloid-derived suppressor cell
%                      - ArgI--Arginase I
%                      - CCL2--Monocyte Chemoattractant Protein-1 (CCL2)
%                      - NO--Nitrite Oxide
%         params
%                      - k_rec_MDSC--MDSC recruitment rate by MCP-1
%                      - k_brec_MDSC--Baseline MDSC recruitment rate
%                      - kd_MDSC--MDSC death rate
%                      - k_deg_CCL2--Degradation rate of MCP-1
%                      - k_deg_NO--Degradation rate of NO
%                      - k_deg_ArgI--Degradation rate of Arg I
%                      - k_sec_CCL2--Secretion rate of MCP-1
%                      - k_sec_NO--Secretion rate of NO
%                      - k_sec_ArgI--Secretion rate of Arg I
%                      - IC50_ENT_C--Effective concentration of entinostat on inhibition of cancer proliferation
%                      - IC50_ENT_NO--Effective concentration of entinostat on inhibition of NO production
%                      - IC50_ENT_ArgI--Effective concentration of entinostat on inhibition of Arg I production
%                      - IC50_ENT_CCL2--Effective concentration of entinostat on inhibition of MCP-1 production
%                      - ki_Treg--Treg expansion rate
%                      - IC50_ArgI_CTL--Effective concentration of Arg I on inhibition of CTL activity
%                      - IC50_NO_CTL--Effective concentration of NO on inhibition of CTL activity
%                      - EC50_CCL2_rec--Effective concentration of MCP-1 on recruitment of MDSC
%                      - EC50_ArgI_Treg--Effective concentration of Arg I on Treg expansion
%                      - MDSC_max--Maximal MDSC available to recruit
%                      - Treg_max--Maximal Treg density in tumor
%
% Outputs: model -- SimBiology model object with new MDSC module
%
% Created: Dec 21, 2018 (Hanwen Wang)
% Last Modified: Aug 13, 2018 (Hanwen Wang)

function model = MDSC_module(model,params)

% Species Names
species_name = 'MDSC';

% Initial Conditions
CCL20 = 0; NO0 = 0; Arg0 = 0;

% Add Species
% MDSC in tumor
MDSC = addspecies(model.Compartment(3),'MDSC',0,'InitialAmountUnits','cell');
set(MDSC,'Notes',['Number of MDSCs in the tumour compartment']);
% CCL2 in tumor
CCL2 = addspecies(model.Compartment(3),'CCL2',CCL20,'InitialAmountUnits','molarity');
set(CCL2,'Notes','Concentration of CCL2 in the tumor compartment');
% add NO
NO = addspecies(model.Compartment(3),'NO',NO0,'InitialAmountUnits','molarity');
set(NO,'Notes','Concentration of NO in the tumor compartment');
% add ArgI
ArgI = addspecies(model.Compartment(3),'ArgI',Arg0,'InitialAmountUnits','mU');
set(ArgI,'Notes','Concentration of Arg I in the tumor compartment');

% Add Parameters
k_rec_MDSC = addparameter(model,'k_rec_MDSC',params.k_rec_MDSC.Value,'ValueUnits',params.k_rec_MDSC.Units);
set(k_rec_MDSC,'Notes',['Rate of MDSC recruitment into the tumor' params.k_rec_MDSC.Notes]);
kd_MDSC = addparameter(model,'kd_MDSC',params.kd_MDSC.Value,'ValueUnits',params.kd_MDSC.Units);
set(kd_MDSC,'Notes',['Rate of MDSC death ' params.kd_MDSC.Notes]);

IC50_ENT_C = addparameter(model,'IC50_ENT_C',params.IC50_ENT_C.Value,'ValueUnits',params.IC50_ENT_C.Units);
set(IC50_ENT_C,'Notes',['ENT concentration for half-maximal tumor cell death' params.IC50_ENT_C.Notes]);
% CCL2 Parameters
p = addparameter(model,'k_deg_CCL2',params.k_deg_CCL2.Value,'ValueUnits',params.k_deg_CCL2.Units);
set(p,'Notes',['rate of CCL2 degradation ' params.k_deg_CCL2.Notes]);
p = addparameter(model,'k_deg_NO',params.k_deg_NO.Value,'ValueUnits',params.k_deg_NO.Units);
set(p,'Notes',['rate of NO degradation ' params.k_deg_NO.Notes]);
p = addparameter(model,'k_deg_ArgI',params.k_deg_ArgI.Value,'ValueUnits',params.k_deg_ArgI.Units);
set(p,'Notes',['rate of ArgI degradation ' params.k_deg_ArgI.Notes]);

p = addparameter(model,'k_sec_CCL2',params.k_sec_CCL2.Value,'ValueUnits',params.k_sec_CCL2.Units);
set(p,'Notes',['rate of CCL2 secretion ' params.k_sec_CCL2.Notes]);
p = addparameter(model,'k_sec_NO',params.k_sec_NO.Value,'ValueUnits',params.k_sec_NO.Units);
set(p,'Notes',['rate of NO secretion from MDSCs ' params.k_sec_NO.Notes]);
p = addparameter(model,'k_sec_ArgI',params.k_sec_ArgI.Value,'ValueUnits',params.k_sec_ArgI.Units);
set(p,'Notes',['rate of ArgI secretion ' params.k_sec_ArgI.Notes]);

p = addparameter(model,'IC50_ENT_NO',params.IC50_ENT_NO.Value,'ValueUnits',params.IC50_ENT_NO.Units);
set(p,'Notes',['half-maximal ENT concentration for NO inhibition ' params.IC50_ENT_NO.Notes]);
p = addparameter(model,'ki_Treg',params.ki_Treg.Value,'ValueUnits',params.ki_Treg.Units);
set(p,'Notes',['rate of ArgI-induced Treg expension ' params.ki_Treg.Notes]);

p = addparameter(model,'IC50_ArgI_CTL',params.IC50_ArgI_CTL.Value,'ValueUnits',params.IC50_ArgI_CTL.Units);
set(p,'Notes',['rate of ArgI-induced T cell death ' params.IC50_ArgI_CTL.Notes]);
p = addparameter(model,'IC50_NO_CTL',params.IC50_NO_CTL.Value,'ValueUnits',params.IC50_NO_CTL.Units);
set(p,'Notes',['rate of NO-induced T cell death ' params.IC50_NO_CTL.Notes]);
p = addparameter(model,'EC50_CCL2_rec',params.EC50_CCL2_rec.Value,'ValueUnits',params.EC50_CCL2_rec.Units);
set(p,'Notes',['Half-maximal CCL2 level of MDSC recruitment ' params.EC50_CCL2_rec.Notes]);
p = addparameter(model,'EC50_ArgI_Treg',params.EC50_ArgI_Treg.Value,'ValueUnits',params.EC50_ArgI_Treg.Units);
set(p,'Notes',['Half-maximal ArgI level of Treg expansion ' params.EC50_ArgI_Treg.Notes]);

p = addparameter(model,'MDSC_max',params.MDSC_max.Value,'ValueUnits',params.MDSC_max.Units);
set(p,'Notes',['Maximal MDSC density in the tumour ' params.MDSC_max.Notes]);

Treg_max = addparameter(model,'Treg_max',params.Treg_max.Value,'ValueUnits',params.Treg_max.Units);
set(Treg_max,'Notes',['Maximal FoxP3+ T cell density in the tumor']);

p = addparameter(model,'IC50_ENT_CCL2',params.IC50_ENT_CCL2.Value,'ValueUnits',params.IC50_ENT_CCL2.Units);
set(p,'Notes',['half-maximal ENT concentration for CCL2 inhibition ' params.IC50_ENT_CCL2.Notes]);
k_brec_MDSC = addparameter(model,'k_brec_MDSC',params.k_brec_MDSC.Value,'ValueUnits',params.k_brec_MDSC.Units);
set(k_brec_MDSC,'Notes',['Baseline rate of MDSC migration into the tumor' params.k_brec_MDSC.Notes]);
p = addparameter(model,'IC50_ENT_ArgI',params.IC50_ENT_ArgI.Value,'ValueUnits',params.IC50_ENT_ArgI.Units);
set(p,'Notes',['half-maximal ENT concentration for Arg I inhibition ' params.IC50_ENT_ArgI.Notes]);

% Add Reactions
% MDSC Recruitment
reaction = addreaction(model,'null -> V_T.MDSC');
set(reaction,'ReactionRate','k_rec_MDSC*(MDSC_max*V_T-V_T.MDSC)*(CCL2/(EC50_CCL2_rec+CCL2))');
set(reaction,'Notes','MDSC recruitment into the tumor compartment');
% MDSC Baseline Migration
reaction = addreaction(model,'null -> V_T.MDSC');
set(reaction,'ReactionRate','k_brec_MDSC*(MDSC_max*V_T-V_T.MDSC)');
set(reaction,'Notes','Baseline MDSC Migration into the tumor compartment');
% MDSC Death
reaction = addreaction(model,'V_T.MDSC -> null');
set(reaction,'ReactionRate','kd_MDSC*V_T.MDSC');
set(reaction,'Notes','MDSC death in the tumor compartment');

% CCL2 Degradation
reaction = addreaction(model,'V_T.CCL2 -> null');
set(reaction,'ReactionRate','k_deg_CCL2*V_T.CCL2');
set(reaction,'Notes','CCL2 degradation');
% NO Degradation
reaction = addreaction(model,'V_T.NO -> null');
set(reaction,'ReactionRate','k_deg_NO*V_T.NO');
set(reaction,'Notes','NO degradation');
% ArgI Degradation
reaction = addreaction(model,'V_T.ArgI -> null');
set(reaction,'ReactionRate','k_deg_ArgI*V_T.ArgI');
set(reaction,'Notes','ArgI degradation');

% CCL2 secretion by MDSCs and Cancer cells
reaction = addreaction(model,'null -> V_T.CCL2');
set(reaction,'ReactionRate',['k_sec_CCL2*V_T.C1*(1-V_T.ENT/(V_T.ENT+IC50_ENT_CCL2))']);
set(reaction,'Notes','CCL2 secretion by MDSCs and cancer cells');
% NO Secretion by MDSC
reaction = addreaction(model,'null -> V_T.NO');
set(reaction,'ReactionRate','k_sec_NO*V_T.MDSC*(1-V_T.ENT/(V_T.ENT+IC50_ENT_NO))');
set(reaction,'Notes','NO secretion from MDSC');
% ArgI Secretion by MDSC
reaction = addreaction(model,'null -> V_T.ArgI');
set(reaction,'ReactionRate','k_sec_ArgI*V_T.MDSC*(1-V_T.ENT/(V_T.ENT+IC50_ENT_ArgI))');
set(reaction,'Notes','ArgI secretion from MDSC');

% ArgI-induced Treg Expension
reaction = addreaction(model,['null -> V_T.T0']);
set(reaction,'ReactionRate',['ki_Treg*V_T.T0*(1-V_T.T0/(Treg_max*V_T))*ArgI/(EC50_ArgI_Treg+ArgI)*(1-V_T.ENT/(V_T.ENT+IC50_ENT_ArgI))']);
set(reaction,'Notes','ArgI-induced Treg Expension');

% Update Hill Function
addrule(model,['H_MDSC_C1 = 1-(1-NO/(IC50_NO_CTL+NO))*(1-ArgI/(IC50_ArgI_CTL+ArgI))*(1-V_T.ENT/(V_T.ENT+IC50_ENT_ArgI))'],'repeatedAssignment');
addrule(model,['H_ENT_C1 = V_T.ENT/(V_T.ENT+IC50_ENT_C)'],'repeatedAssignment');
