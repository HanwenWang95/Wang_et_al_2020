% Function to generate cancer module parameters from default physical parameters
%
% Inputs: params_in  -- object containing the default parameters
%                       - k_rec_MDSC--MDSC recruitment rate by MCP-1
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
%                      - Treg_max--Total cell Treg_maxacity
% Output: params_out -- object containing parameters
%                       - k_rec_MDSC--MDSC recruitment rate by MCP-1
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
%                      - Treg_max--Total cell Treg_maxacity
%
% Created: Jan 5, 2018 (Hanwen Wang)
% Last Modified: Aug 13, 2019 (HW)

function params_out = MDSC_parameters(params_in)

% MDSC recruitment rate by MCP-1
params_out.k_rec_MDSC = params_in.k_rec_MDSC;
% Baseline MDSC recruitment rate
params_out.k_brec_MDSC = params_in.k_brec_MDSC;
% rate of MDSC death
params_out.kd_MDSC = params_in.kd_MDSC;

% Degradation rate of MCP-1
params_out.k_deg_CCL2 = params_in.k_deg_CCL2;
% Degradation rate of NO
params_out.k_deg_NO = params_in.k_deg_NO;
% Degradation rate of Arg I
params_out.k_deg_ArgI = params_in.k_deg_ArgI;

% Secretion rate of MCP-1
params_out.k_sec_CCL2 = params_in.k_sec_CCL2;
% Secretion rate of NO
params_out.k_sec_NO = params_in.k_sec_NO;
% Secretion rate of Arg I
params_out.k_sec_ArgI = params_in.k_sec_ArgI;

% Effective concentration of entinostat on inhibition of cancer proliferation
params_out.IC50_ENT_C = params_in.IC50_ENT_C;
% Effective concentration of entinostat on inhibition of NO production
params_out.IC50_ENT_NO = params_in.IC50_ENT_NO;
% Effective concentration of entinostat on inhibition of Arg I production
params_out.IC50_ENT_ArgI = params_in.IC50_ENT_C;
% Effective concentration of entinostat on inhibition of MCP-1 production
params_out.IC50_ENT_CCL2 = params_in.IC50_ENT_CCL2;
% Treg expansion rate
params_out.ki_Treg = params_in.ki_Treg;
% Effective concentration of Arg I on inhibition of CTL activity
params_out.IC50_ArgI_CTL = params_in.IC50_ArgI_CTL;
% Effective concentration of NO on inhibition of CTL activity
params_out.IC50_NO_CTL = params_in.IC50_NO_CTL;
% Effective concentration of MCP-1 on recruitment of MDSC
params_out.EC50_CCL2_rec = params_in.EC50_CCL2_rec;
% Effective concentration of Arg I on Treg expansion
params_out.EC50_ArgI_Treg = params_in.EC50_ArgI_Treg;
% Maximal MDSC available to recruit
params_out.MDSC_max = params_in.MDSC_max;
% Maximal Treg density in tumor
params_out.Treg_max = params_in.Treg_max;
