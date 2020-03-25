% Checkpoint Module
%
% Models PD1 Interactions
%
% Inputs: model       -- simbio model object with four compartments
%         params      -- object containing the default parameters
%         Tname       -- name of the T cell forming the checkpoint synapse
%         Cname       -- name of the cancer or APC cell forming the
%                        checkpoint synapse
%         nivo_params -- object containing the nivo PK parameters
%         durv_params -- object containing the durv PK parameters
%         ipi_params  -- object containing the ipi PK parameters
%
% Outputs: model -- simbio model object with new PD1 module
%
% Note: This only works for Ti (i >= 1) interaction with APC and Cj. We
% would need to add a check for Tregs if we would like to generalize it to checkpoint
% model of Treg.
%
% Created: Feb 14, 2019 (Mohammad Jafarnejad & Sondra Rahmeh)
% Last Modified: Oct 3, 2019 (HW)

function model = checkpoint_module(model,params,Tname,Cname,nivo_params,durv_params,ipi_params)

% select the right compartment based on cancer or APC
if Cname(1)=='C'
    compDrug = model.Compartment(3);
    gamma = 'gamma_T';
elseif Cname(1)=='A'
    compDrug = model.Compartment(4);
    gamma = 'gamma_LN';
end

% Add the synapse compartment
comp = addcompartment(model,['syn_',Tname,'_',Cname],params.A_syn.Value,'CapacityUnits',params.A_syn.Units);
    set(comp,'Notes',['synapse comparment between ',Tname,' and ',Cname,' ', params.A_syn.Notes]);

% Determine if checkpoint sizes have been defined before in antigen module
first_call = true;

try % see if synapse exist
    p = addparameter(model,'A_syn' ,params.A_syn.Value ,'ValueUnits',params.A_syn.Units);
    set(p,'Notes',['Surface area of the synapse ' params.A_syn.Notes]);
catch
    first_call = false;
end
if first_call
% Add surface areas
p = addparameter(model,'A_Tcell' ,params.A_Tcell.Value ,'ValueUnits',params.A_Tcell.Units);
    set(p,'Notes',['Surface area of the T cell ' params.A_Tcell.Notes]);
p = addparameter(model,'A_cell' ,params.A_cell.Value ,'ValueUnits',params.A_cell.Units);
    set(p,'Notes',['Surface area of the Cancer cell ' params.A_cell.Notes]);
p = addparameter(model,'A_APC' ,params.A_APC.Value ,'ValueUnits',params.A_APC.Units);
    set(p,'Notes',['Surface area of the APC ' params.A_APC.Notes]);
end


% Determine if first call
first_call = true;
try % see if synapse exist
kon = addparameter(model,'kon_PD1_PDL1',params.kon_PD1_PDL1.Value,'ValueUnits',params.kon_PD1_PDL1.Units);
    set(kon,'Notes',['kon of PD1-PDL1 binding ' params.kon_PD1_PDL1.Notes]);
catch
    first_call = false;
end
if first_call
% Add Pharmacokinetics
model = pk_module(model,'nivo',nivo_params);
model = pk_module(model,'durv',durv_params);
model = pk_module(model,'ipi' ,ipi_params);

% Add kon Values
kon = addparameter(model,'kon_PD1_PDL2',params.kon_PD1_PDL2.Value,'ValueUnits',params.kon_PD1_PDL2.Units);
    set(kon,'Notes',['kon of PD1-PDL2 binding ' params.kon_PD1_PDL2.Notes]);
kon = addparameter(model,'kon_PD1_nivo',params.kon_PD1_nivo.Value,'ValueUnits',params.kon_PD1_nivo.Units);
    set(kon,'Notes',['kon of PD1-nivolumab binding ' params.kon_PD1_nivo.Notes]);
kon = addparameter(model,'kon_PDL1_durv',params.kon_PDL1_durv.Value,'ValueUnits',params.kon_PDL1_durv.Units);
    set(kon,'Notes',['kon of PDL1-durvalumab binding ' params.kon_PDL1_durv.Notes]);
kon = addparameter(model,'kon_CD28_CD80',params.kon_CD28_CD80.Value,'ValueUnits',params.kon_CD28_CD80.Units);
    set(kon,'Notes',['kon of CD28-CD80 binding ' params.kon_CD28_CD80.Notes]);
kon = addparameter(model,'kon_CD28_CD86',params.kon_CD28_CD86.Value,'ValueUnits',params.kon_CD28_CD86.Units);
    set(kon,'Notes',['kon of CD28-CD86 binding ' params.kon_CD28_CD86.Notes]);
kon = addparameter(model,'kon_CTLA4_CD80',params.kon_CTLA4_CD80.Value,'ValueUnits',params.kon_CTLA4_CD80.Units);
    set(kon,'Notes',['kon of CTLA4-CD80 binding ' params.kon_CTLA4_CD80.Notes]);
kon = addparameter(model,'kon_CTLA4_CD86',params.kon_CTLA4_CD86.Value,'ValueUnits',params.kon_CTLA4_CD86.Units);
    set(kon,'Notes',['kon of CTLA4-CD86 binding ' params.kon_CTLA4_CD86.Notes]);
kon = addparameter(model,'kon_CD80_PDL1',params.kon_CD80_PDL1.Value,'ValueUnits',params.kon_CD80_PDL1.Units);
    set(kon,'Notes',['kon of CD80-PDL1 binding ' params.kon_CD80_PDL1.Notes]);
kon = addparameter(model,'kon_CTLA4_ipi',params.kon_CTLA4_ipi.Value,'ValueUnits',params.kon_CTLA4_ipi.Units);
    set(kon,'Notes',['kon of CTLA4-ipilimumab binding ' params.kon_CTLA4_ipi.Notes]);

% Add koff Values
koff = addparameter(model,'koff_PD1_PDL1' ,params.koff_PD1_PDL1.Value ,'ValueUnits',params.koff_PD1_PDL1.Units);
    set(koff,'Notes',['koff of PD1-PDL1 binding ' params.koff_PD1_PDL1.Notes]);
koff = addparameter(model,'koff_PD1_PDL2' ,params.koff_PD1_PDL2.Value ,'ValueUnits',params.koff_PD1_PDL2.Units);
    set(koff,'Notes',['koff of PD1-PDL2 binding ' params.koff_PD1_PDL2.Notes]);
koff = addparameter(model,'koff_PD1_nivo' ,params.koff_PD1_nivo.Value ,'ValueUnits',params.koff_PD1_nivo.Units);
    set(koff,'Notes',['koff of PD1-nivolumab binding ' params.koff_PD1_nivo.Notes]);
koff = addparameter(model,'koff_PDL1_durv',params.koff_PDL1_durv.Value,'ValueUnits',params.koff_PDL1_durv.Units);
    set(koff,'Notes',['koff of PDL1-durvalumab binding ' params.koff_PDL1_durv.Notes]);
koff = addparameter(model,'koff_CD28_CD80' ,params.koff_CD28_CD80.Value ,'ValueUnits',params.koff_CD28_CD80.Units);
    set(koff,'Notes',['koff of CD28-CD80 binding ' params.koff_CD28_CD80.Notes]);
koff = addparameter(model,'koff_CD28_CD86' ,params.koff_CD28_CD86.Value ,'ValueUnits',params.koff_CD28_CD86.Units);
    set(koff,'Notes',['koff of CD28-CD86 binding ' params.koff_CD28_CD86.Notes]);
koff = addparameter(model,'koff_CTLA4_CD80' ,params.koff_CTLA4_CD80.Value ,'ValueUnits',params.koff_CTLA4_CD80.Units);
    set(koff,'Notes',['koff of CTLA4-CD80 binding ' params.koff_CTLA4_CD80.Notes]);
koff = addparameter(model,'koff_CTLA4_CD86' ,params.koff_CTLA4_CD86.Value ,'ValueUnits',params.koff_CTLA4_CD86.Units);
    set(koff,'Notes',['koff of CTLA4-CD86 binding ' params.koff_CTLA4_CD86.Notes]);
koff = addparameter(model,'koff_CD80_PDL1' ,params.koff_CD80_PDL1.Value ,'ValueUnits',params.koff_CD80_PDL1.Units);
    set(koff,'Notes',['koff of CD80-PDL1 binding ' params.koff_CD80_PDL1.Notes]);
koff = addparameter(model,'koff_CTLA4_ipi',params.koff_CTLA4_ipi.Value,'ValueUnits',params.koff_CTLA4_ipi.Units);
    set(koff,'Notes',['koff of CTLA4-ipilimumab binding ' params.koff_CTLA4_ipi.Notes]);

% Bivalent anibody parameters
p = addparameter(model,'Chi_PD1_nivo' ,params.Chi_PD1_nivo.Value ,'ValueUnits',params.Chi_PD1_nivo.Units);
    set(p,'Notes',['Antibody cross-arm binding efficiency ' params.Chi_PD1_nivo.Notes]);
p = addparameter(model,'Chi_PDL1_durv' ,params.Chi_PDL1_durv.Value ,'ValueUnits',params.Chi_PDL1_durv.Units);
    set(p,'Notes',['Antibody cross-arm binding efficiency ' params.Chi_PDL1_durv.Notes]);
p = addparameter(model,'Chi_CTLA4_ipi' ,params.Chi_CTLA4_ipi.Value ,'ValueUnits',params.Chi_CTLA4_ipi.Units);
    set(p,'Notes',['Antibody cross-arm binding efficiency ' params.Chi_CTLA4_ipi.Notes]);

% PD1-related Hill parameters
p = addparameter(model,'PD1_50',params.PD1_50.Value,'ValueUnits',params.PD1_50.Units);
    set(p,'Notes',['PD1/PDL1 concentration for half-maximal T cell inactivation ' params.PD1_50.Notes]);
p = addparameter(model,'n_PD1',params.n_PD1.Value,'ValueUnits',params.n_PD1.Units);
    set(p,'Notes',['Hill coefficient for PD1/PDL1 half-maximal T cell inactivation ' params.n_PD1.Notes]);
p = addparameter(model,'CD28_CD8X_50',params.CD28_CD8X_50.Value,'ValueUnits',params.CD28_CD8X_50.Units);
    set(p,'Notes',['CD28-CD80/CD28-CD86 concentration for half-maximal T cell co-estimulation ' params.CD28_CD8X_50.Notes]);
p = addparameter(model,'n_CD28_CD8X',params.n_CD28_CD8X.Value,'ValueUnits',params.n_CD28_CD8X.Units);
    set(p,'Notes',['Hill coefficient for CD28-CD80/CD28-CD86 half-maximal T cell co-estimulation ' params.n_CD28_CD8X.Notes]);

end

% Checkpoint Expressions
% Check if T cell has defined before
first_Tcell_call = true;
try
    p = addparameter(model,[Tname,'_PD1_total'],params.([Tname,'_PD1']).Value,'ValueUnits',params.([Tname,'_PD1']).Units,'ConstantValue',false);
catch
    first_Tcell_call = false;
end
if first_Tcell_call
        set(p,'Notes',['concentration of PD1 on ',Tname,' cells ' params.([Tname,'_PD1']).Notes]);
    p = addparameter(model,[Tname,'_CD28_total'],params.([Tname,'_CD28']).Value,'ValueUnits',params.([Tname,'_CD28']).Units,'ConstantValue',false);
        set(p,'Notes',['concentration of CD28 on ',Tname,' cells ' params.([Tname,'_CD28']).Notes]);
    p = addparameter(model,[Tname,'_CTLA4_syn'],params.([Tname,'_CTLA4']).Value,'ValueUnits',params.([Tname,'_CTLA4']).Units,'ConstantValue',false);
        set(p,'Notes',['concentration of CTLA4 on ',Tname,' cells ' params.([Tname,'_CTLA4']).Notes]);
    p = addparameter(model,[Tname,'_PDL1_total'],params.([Tname,'_PDL1']).Value,'ValueUnits',params.([Tname,'_PDL1']).Units,'ConstantValue',false);
        set(p,'Notes',['concentration of PDL1 on ',Tname,' cells ' params.([Tname,'_PDL1']).Notes]);
end
% Check if Cancer or APC has defined before
first_Ccell_call = true;
try
    p = addparameter(model,[Cname,'_PDL1_total'],params.([Cname,'_PDL1']).Value,'ValueUnits',params.([Cname,'_PDL1']).Units,'ConstantValue',false);
catch
    first_Ccell_call = false;
end
if first_Ccell_call
        set(p,'Notes',['number of PDL1 molecules per ',Cname,' cell ' params.([Cname,'_PDL1']).Notes]);
    p = addparameter(model,[Cname,'_PDL2_total'],params.([Cname,'_PDL2']).Value,'ValueUnits',params.([Cname,'_PDL2']).Units,'ConstantValue',false);
        set(p,'Notes',['number of PDL2 molecules per ',Cname,' cell ' params.([Cname,'_PDL2']).Notes]);
    p = addparameter(model,[Cname,'_CD80_total'],params.([Cname,'_CD80']).Value,'ValueUnits',params.([Cname,'_CD80']).Units,'ConstantValue',false);
        set(p,'Notes',['number of CD80 molecules per ',Cname,' cell ' params.([Cname,'_CD80']).Notes]);
    p = addparameter(model,[Cname,'_CD86_total'],params.([Cname,'_CD86']).Value,'ValueUnits',params.([Cname,'_CD86']).Units,'ConstantValue',false);
        set(p,'Notes',['number of CD86 molecules per ',Cname,' cell ' params.([Cname,'_CD86']).Notes]);
end

% Add Species
x = addspecies(comp,'PD1_PDL1',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of PD1-PDL1 complex');
x = addspecies(comp,'PD1_PDL2',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of PD1-PDL2 complex');
x = addspecies(comp,'PD1',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of PD1 in synapse');
x = addspecies(comp,'PDL1',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of PDL1 in synapse');
x = addspecies(comp,'PDL2',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of PDL2 in synapse');
x = addspecies(comp,'PD1_nivo',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of PD1-nivolumab complex');
x = addspecies(comp,'PD1_nivo_PD1',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of PD1-nivolumab-PD1 complex');
x = addspecies(comp,'PDL1_durv',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of PDL1-durvalumab complex');
x = addspecies(comp,'PDL1_durv_PDL1',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of PDL1-durvalumab-PDL1 complex');
x = addspecies(comp,'TPDL1',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of PDL1 in synapse of T cell');
x = addspecies(comp,'TPDL1_durv',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of TPDL1-durvalumab complex');
x = addspecies(comp,'TPDL1_durv_TPDL1',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of TPDL1-durvalumab-TPDL1 complex');

x = addspecies(comp,'CD28_CD80',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of CD28-CD80 complex');
x = addspecies(comp,'CD28_CD80_CD28',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of CD28-CD80-CD28 complex');
x = addspecies(comp,'CD28_CD86',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of CD28-CD86 complex');
x = addspecies(comp,'CD80_CTLA4',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of CD80-CTLA4 complex');
x = addspecies(comp,'CD80_CTLA4_CD80',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of CD80-CTLA4-CD80 complex');
x = addspecies(comp,'CTLA4_CD80_CTLA4',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of CTLA4-CD80-CTLA4 complex');
x = addspecies(comp,'CD80_CTLA4_CD80_CTLA4',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of CD80-CTLA4-CD80-CTLA4 complex');
x = addspecies(comp,'CD86_CTLA4',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of CD86-CTLA4 complex');
x = addspecies(comp,'CD86_CTLA4_CD86',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of CD86-CTLA4-CD86 complex');
x = addspecies(comp,'TPDL1_CD80',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of TPDL1-CD80 complex');
x = addspecies(comp,'TPDL1_CD80_TPDL1',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of TPDL1-CD80-TPDL1 complex');
x = addspecies(comp,'CD28',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of CD28 in synapse');
x = addspecies(comp,'CTLA4',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of CTLA4 in synapse');
x = addspecies(comp,'CD80',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of CD80 in synapse');
x = addspecies(comp,'CD86',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of CD86 in synapse');
x = addspecies(comp,'CTLA4_ipi',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of CTLA4-ipilimumab complex');
x = addspecies(comp,'CTLA4_ipi_CTLA4',0,'InitialAmountUnits','molecule/micrometer^2');
    set(x,'Notes','concentration of CTLA4-ipilimumab-CTLA4 complex');

% Update Input Parameters
addrule(model,[comp.Name,'.PD1',' = '  ,Tname,'_PD1_total /A_Tcell' ] ,'initialAssignment');
addrule(model,[comp.Name,'.CD28',' = ' ,Tname,'_CD28_total /A_Tcell'] ,'initialAssignment');
addrule(model,[comp.Name,'.CTLA4',' = ',Tname,'_CTLA4_syn /A_syn'   ] ,'initialAssignment');
addrule(model,[comp.Name,'.TPDL1',' = ',Tname,'_PDL1_total /A_Tcell'] ,'initialAssignment');
if Cname(1)=='C'
    addrule(model,[comp.Name,'.PDL1 = ',Cname,'_PDL1_total /A_cell'] ,'initialAssignment');
    addrule(model,[comp.Name,'.PDL2 = ',Cname,'_PDL2_total /A_cell'] ,'initialAssignment');
    addrule(model,[comp.Name,'.CD80 = ',Cname,'_CD80_total /A_cell'] ,'initialAssignment');
    addrule(model,[comp.Name,'.CD86 = ',Cname,'_CD86_total /A_cell'] ,'initialAssignment');
elseif Cname(1)=='A'
    addrule(model,[comp.Name,'.PDL1 = ',Cname,'_PDL1_total /A_APC'] ,'initialAssignment');
    addrule(model,[comp.Name,'.PDL2 = ',Cname,'_PDL2_total /A_APC'] ,'initialAssignment');
    addrule(model,[comp.Name,'.CD80 = ',Cname,'_CD80_total /A_APC'] ,'initialAssignment');
    addrule(model,[comp.Name,'.CD86 = ',Cname,'_CD86_total /A_APC'] ,'initialAssignment');
end


% Dynamics of PD1/PDL1/PDL2/nivo/durva
 R = addreaction(model,[comp.Name,'.PD1 + ',comp.Name,'.PDL1 <-> ',comp.Name,'.PD1_PDL1']);
    set (R, 'ReactionRate', ['kon_PD1_PDL1*(',comp.Name,'.PD1)*(',comp.Name,'.PDL1)  -  koff_PD1_PDL1*',comp.Name,'.PD1_PDL1']);
    set (R, 'Notes'       , 'binding and unbinding of PD1 PDL1 in synapse');
 R = addreaction(model,[comp.Name,'.PD1 + ',comp.Name,'.PDL2 <-> ',comp.Name,'.PD1_PDL2']);
    set (R, 'ReactionRate', ['kon_PD1_PDL2*(',comp.Name,'.PD1)*(',comp.Name,'.PDL2)  -  koff_PD1_PDL2*',comp.Name,'.PD1_PDL2']);
    set (R, 'Notes'       , 'binding and unbinding of PD1 PDL2 in synapse');
 R = addreaction(model,[comp.Name,'.PD1 <-> ',comp.Name,'.PD1_nivo']);
    set (R, 'ReactionRate', ['2*kon_PD1_nivo*(',comp.Name,'.PD1 * ',compDrug.Name,'.nivo/',gamma,'_nivo) -  koff_PD1_nivo*',comp.Name,'.PD1_nivo']);
    set (R, 'Notes'       , ['binding and unbinding of PD1 to Nivo on ',Tname,' surface in synapse']);
 R = addreaction(model,[comp.Name,'.PD1_nivo + ',comp.Name,'.PD1 <-> ',comp.Name,'.PD1_nivo_PD1']);
    set (R, 'ReactionRate', ['Chi_PD1_nivo*kon_PD1_nivo*(',comp.Name,'.PD1 * ',comp.Name,'.PD1_nivo) -  2*koff_PD1_nivo*',comp.Name,'.PD1_nivo_PD1']);
    set (R, 'Notes'       , ['binding and unbinding of PD1 to PD1-Nivo on ',Tname,' surface in synapse']);
 R = addreaction(model,[comp.Name,'.PDL1 <-> ',comp.Name,'.PDL1_durv']);
    set (R, 'ReactionRate', ['2*kon_PDL1_durv*(',comp.Name,'.PDL1 * ',compDrug.Name,'.durv/',gamma,'_durv) -  koff_PDL1_durv*',comp.Name,'.PDL1_durv']);
    set (R, 'Notes'       , ['binding and unbinding of PDL1 to Durv on ',Cname,' surface in synapse']);
 R = addreaction(model,[comp.Name,'.PDL1_durv + ',comp.Name,'.PDL1 <-> ',comp.Name,'.PDL1_durv_PDL1']);
    set (R, 'ReactionRate', ['Chi_PDL1_durv*kon_PDL1_durv*(',comp.Name,'.PDL1 * ',comp.Name,'.PDL1_durv) -  2*koff_PDL1_durv*',comp.Name,'.PDL1_durv_PDL1']);
    set (R, 'Notes'       , ['binding and unbinding of PDL1 to PDL1-Durv on ',Cname,' surface in synapse']);

% Dynamics of CD28/CTLA4/CD80/CD86/ipi/durv
% CD28-CD80
 R = addreaction(model,[comp.Name,'.CD28 + ',comp.Name,'.CD80 <-> ',comp.Name,'.CD28_CD80']);
    set (R, 'ReactionRate', ['2*kon_CD28_CD80*(',comp.Name,'.CD28)*(',comp.Name,'.CD80)  -  koff_CD28_CD80*',comp.Name,'.CD28_CD80']);
    set (R, 'Notes'       , 'binding and unbinding of CD28 and CD80 in synapse');
 R = addreaction(model,[comp.Name,'.CD28_CD80 + ',comp.Name,'.CD28 <-> ',comp.Name,'.CD28_CD80_CD28']);
    set (R, 'ReactionRate', ['kon_CD28_CD80*(',comp.Name,'.CD28)*(',comp.Name,'.CD28_CD80)  -  2*koff_CD28_CD80*',comp.Name,'.CD28_CD80_CD28']);
    set (R, 'Notes'       , 'binding and unbinding of CD28-CD80 and CD28 in synapse');
% CD28-CD86
 R = addreaction(model,[comp.Name,'.CD28 + ',comp.Name,'.CD86 <-> ',comp.Name,'.CD28_CD86']);
    set (R, 'ReactionRate', ['kon_CD28_CD86*(',comp.Name,'.CD28)*(',comp.Name,'.CD86)  -  koff_CD28_CD86*',comp.Name,'.CD28_CD86']);
    set (R, 'Notes'       , 'binding and unbinding of CD28 and CD86 in synapse');
% CTLA4-CD80
 R = addreaction(model,[comp.Name,'.CTLA4 + ',comp.Name,'.CD80 <-> ',comp.Name,'.CD80_CTLA4']);
    set (R, 'ReactionRate', ['4*kon_CTLA4_CD80*(',comp.Name,'.CTLA4)*(',comp.Name,'.CD80)  -  koff_CTLA4_CD80*',comp.Name,'.CD80_CTLA4']);
    set (R, 'Notes'       , 'binding and unbinding of CTLA4 and CD80 in synapse');
 R = addreaction(model,[comp.Name,'.CTLA4 + ',comp.Name,'.CD80_CTLA4 <-> ',comp.Name,'.CTLA4_CD80_CTLA4']);
    set (R, 'ReactionRate', ['kon_CTLA4_CD80*(',comp.Name,'.CTLA4)*(',comp.Name,'.CD80_CTLA4)  -  2*koff_CTLA4_CD80*',comp.Name,'.CTLA4_CD80_CTLA4']);
    set (R, 'Notes'       , 'binding and unbinding of CTLA4 and CD80-CTLA4 in synapse');
 R = addreaction(model,[comp.Name,'.CD80 + ',comp.Name,'.CTLA4_CD80_CTLA4 <-> ',comp.Name,'.CD80_CTLA4_CD80_CTLA4']);
    set (R, 'ReactionRate', ['kon_CTLA4_CD80*(',comp.Name,'.CD80)*(',comp.Name,'.CTLA4_CD80_CTLA4)  -  koff_CTLA4_CD80*',comp.Name,'.CD80_CTLA4_CD80_CTLA4']);
    set (R, 'Notes'       , 'binding and unbinding of CD80 and CTLA4-CD80-CTLA4 in synapse');
 R = addreaction(model,[comp.Name,'.CD80_CTLA4 + ',comp.Name,'.CD80 <-> ',comp.Name,'.CD80_CTLA4_CD80']);
    set (R, 'ReactionRate', ['kon_CTLA4_CD80*(',comp.Name,'.CD80_CTLA4)*(',comp.Name,'.CD80)  -  2*koff_CTLA4_CD80*',comp.Name,'.CD80_CTLA4_CD80']);
    set (R, 'Notes'       , 'binding and unbinding of CD80-CTLA4 and CD80 in synapse');
 R = addreaction(model,[comp.Name,'.CTLA4 + ',comp.Name,'.CD80_CTLA4_CD80 <-> ',comp.Name,'.CD80_CTLA4_CD80_CTLA4']);
    set (R, 'ReactionRate', ['kon_CTLA4_CD80*(',comp.Name,'.CTLA4)*(',comp.Name,'.CD80_CTLA4_CD80)  -  koff_CTLA4_CD80*',comp.Name,'.CD80_CTLA4_CD80_CTLA4']);
    set (R, 'Notes'       , 'binding and unbinding of CTLA4 and CD80-CTLA4-CD80 in synapse');
% CTLA4-CD86
 R = addreaction(model,[comp.Name,'.CTLA4 + ',comp.Name,'.CD86 <-> ',comp.Name,'.CD86_CTLA4']);
    set (R, 'ReactionRate', ['2*kon_CTLA4_CD86*(',comp.Name,'.CTLA4)*(',comp.Name,'.CD86)  -  koff_CTLA4_CD86*',comp.Name,'.CD86_CTLA4']);
    set (R, 'Notes'       , 'binding and unbinding of CTLA4 and CD86 in synapse');
 R = addreaction(model,[comp.Name,'.CD86_CTLA4 + ',comp.Name,'.CD86 <-> ',comp.Name,'.CD86_CTLA4_CD86']);
    set (R, 'ReactionRate', ['kon_CTLA4_CD86*(',comp.Name,'.CD86_CTLA4)*(',comp.Name,'.CD86)  -  2*koff_CTLA4_CD86*',comp.Name,'.CD86_CTLA4_CD86']);
    set (R, 'Notes'       , 'binding and unbinding of CD86-CTLA4 and CD86 in synapse');
% CTLA4-ipi
 R = addreaction(model,[comp.Name,'.CTLA4 <-> ',comp.Name,'.CTLA4_ipi']);
    set (R, 'ReactionRate', ['4*kon_CTLA4_ipi*(',comp.Name,'.CTLA4 * ',compDrug.Name,'.ipi/',gamma,'_ipi) -  koff_CTLA4_ipi*',comp.Name,'.CTLA4_ipi']);
    set (R, 'Notes'       , ['binding and unbinding of CTLA4 to Ipi on ',Tname,' surface in synapse']);
 R = addreaction(model,[comp.Name,'.CTLA4_ipi + ',comp.Name,'.CTLA4 <-> ',comp.Name,'.CTLA4_ipi_CTLA4']);
    set (R, 'ReactionRate', ['Chi_CTLA4_ipi*kon_CTLA4_ipi*(',comp.Name,'.CTLA4 * ',comp.Name,'.CTLA4_ipi) -  2*koff_CTLA4_ipi*',comp.Name,'.CTLA4_ipi_CTLA4']);
    set (R, 'Notes'       , ['binding and unbinding of CTLA4 to Ipi on ',Tname,' surface in synapse']);
% TPDL1-CD80
 R = addreaction(model,[comp.Name,'.CD80 + ',comp.Name,'.TPDL1 <-> ',comp.Name,'.TPDL1_CD80']);
    set (R, 'ReactionRate', ['2*kon_CD80_PDL1*(',comp.Name,'.CD80)*(',comp.Name,'.TPDL1)  -  koff_CD80_PDL1*',comp.Name,'.TPDL1_CD80']);
    set (R, 'Notes'       , 'binding and unbinding of CD80 and PDL1 in synapse');
 R = addreaction(model,[comp.Name,'.TPDL1_CD80 + ',comp.Name,'.TPDL1 <-> ',comp.Name,'.TPDL1_CD80_TPDL1']);
    set (R, 'ReactionRate', ['kon_CD80_PDL1*(',comp.Name,'.TPDL1_CD80)*(',comp.Name,'.TPDL1)  - 2*koff_CD80_PDL1*',comp.Name,'.TPDL1_CD80_TPDL1']);
    set (R, 'Notes'       , 'binding and unbinding of PDL1-CD80 and PDL1 in synapse');
% TPDL1-durv
 R = addreaction(model,[comp.Name,'.TPDL1 <-> ',comp.Name,'.TPDL1_durv']);
    set (R, 'ReactionRate', ['2*kon_PDL1_durv*(',comp.Name,'.TPDL1 * ',compDrug.Name,'.durv/',gamma,'_durv) -  koff_PDL1_durv*',comp.Name,'.TPDL1_durv']);
    set (R, 'Notes'       , ['binding and unbinding of PDL1 to Durv on ',Cname,' surface in synapse']);
 R = addreaction(model,[comp.Name,'.TPDL1_durv + ',comp.Name,'.TPDL1 <-> ',comp.Name,'.TPDL1_durv_TPDL1']);
    set (R, 'ReactionRate', ['Chi_PDL1_durv*kon_PDL1_durv*(',comp.Name,'.TPDL1 * ',comp.Name,'.TPDL1_durv) -  2*koff_PDL1_durv*',comp.Name,'.TPDL1_durv_TPDL1']);
    set (R, 'Notes'       , ['binding and unbinding of PDL1 to PDL1-Durv on ',Cname,' surface in synapse']);

% Update PD1 Hill Function
addrule(model,['H_PD1_',Cname,' = ((',comp.Name,'.PD1_PDL1+',comp.Name,'.PD1_PDL2)/PD1_50)^n_PD1/(((',comp.Name,'.PD1_PDL1+',comp.Name,'.PD1_PDL2)/PD1_50)^n_PD1 + 1)'],'repeatedAssignment');
addrule(model,['H_CD28_',Cname,' = ((',comp.Name,'.CD28_CD80 + ',comp.Name,'.CD28_CD86 + 2*',comp.Name,'.CD28_CD80_CD28)/CD28_CD8X_50)^n_CD28_CD8X/(((',comp.Name,'.CD28_CD80 + ',comp.Name,'.CD28_CD86 + 2*',comp.Name,'.CD28_CD80_CD28)/CD28_CD8X_50)^n_CD28_CD8X + 1)'],'repeatedAssignment');
