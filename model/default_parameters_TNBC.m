% Function to generate model parameters in breast cancer
%
% Output: params -- object containing parameters
%                   -> each parameter has Value, Units and Notes properties.
%
% Created: Dec 27, 2018 (Hanwen Wang)
% Last Modified: Nov 19, 2019 (HW)

function params = default_parameters_TNBC

% Define Cell Dimension
params.cell.Value = 1;
params.cell.Units = 'cell';

% Avogadro's Number
params.N_avg.Value = 6.0221409e23;
params.N_avg.Units = 'molecule/mole';
params.N_avg.Notes = '(Avogadro 1811)';

% Compartment Volume Parameters
% Central Compartment Volume
params.V_C.Value = 6.0;
params.V_C.Units = 'litre';
params.V_C.Notes = '(assumed based on patient weight)';
% Peripheral Compartment Volume
params.V_P.Value = 61.321;
params.V_P.Units = 'litre';
params.V_P.Notes = '(assumed based on patient weight)';
% Cancer-Free Tumour Volume
params.V_Tmin.Value = 1e-6;
params.V_Tmin.Units = 'milliliter';
params.V_Tmin.Notes = '(estimated)';
% Number of Lymph Nodes
params.nLNs.Value = 17;
params.nLNs.Units = 'dimensionless';
params.nLNs.Notes = '(estimated)';
% Lymph Node Diameter
params.D_LN.Value = 5;
params.D_LN.Units = 'millimeter';
params.D_LN.Notes = '(Schmidt 2007, PMID: 17724531)';

% Blood Volume Fractions
% Peripheral
params.gamma_P.Value = 0.0067;
params.gamma_P.Units = 'dimensionless';
params.gamma_P.Notes = '(Zhu 1996, PMID: 8706023)';
% Tumour
params.gamma_T.Value = 0.0067; % 0.0588
params.gamma_T.Units = 'dimensionless';
params.gamma_T.Notes = '(Wang 1998, PMID: 9727942; MacGabhann 2006, PMID: 17196035)';

% Cancer Parameters
% Initial Tumour Diameter
params.initial_tumour_diameter.Value = 0.1;
params.initial_tumour_diameter.Units = 'centimeter';
params.initial_tumour_diameter.Notes = '(varied)';
% Cancer Cell Diameter
params.D_cell.Value = 17;
params.D_cell.Units = 'micrometer';
params.D_cell.Notes = '(Abramczyk 2015, PMID: 25730442)';
% Cancer Cell Density
params.rho_cell.Value = 2.06e8; % 1.67e8 - 2.06e8
params.rho_cell.Units = 'cell/milliliter';
params.rho_cell.Notes = '(Del Monte 2009, PMID: 19176997; Barnes 2016 PMID: 26332194)';
% Maximum Tumour Diameter
params.D_Tmax.Value = 20;
params.D_Tmax.Units = 'centimeter';
params.D_Tmax.Notes = '(Chen 2014, PMID: 25184733)';
% Growth Rate
params.k_C_growth.Value = 0.00673;
params.k_C_growth.Units = '1/day';
params.k_C_growth.Notes = '(Ryu 2014, PMID: 24895040)';
% Death Rate
params.k_C_death.Value = 0.0001;
params.k_C_death.Units = '1/day';
params.k_C_death.Notes = '(Palsson 2013, PMID: 24074340)';
% Death Rate Due to T Cells
params.k_C_Tcell.Value = 2;
params.k_C_Tcell.Units = '1/day';
params.k_C_Tcell.Notes = '(estimated)';
% Tumour Vascular Volume Fraction
params.gamma_v.Value = 0.0067;
params.gamma_v.Units = 'dimensionless';
params.gamma_v.Notes = '(MacGabhann 2006, PMID: 17196035)';
% Dead Cell Clearance Rate
params.k_cell_clear.Value = 0.1;
params.k_cell_clear.Units = '1/day';
params.k_cell_clear.Notes = '(estimated)';

% T Cell Parameters
% Rate of T Cell Exhaustion by Cancer Cells
params.k_Tcell.Value = 0.1;
params.k_Tcell.Units = '1/day';
params.k_Tcell.Notes = '(estimated)';
% Rate of T Cell Death by Tregs
params.k_Treg.Value = 2;
params.k_Treg.Units = '1/day';
params.k_Treg.Notes = '(estimated)';
% T Cell Diameter
params.D_Tcell.Value = 6.94;
params.D_Tcell.Units = 'micrometer';
params.D_Tcell.Notes = '(Chapman 1981, PMID: 6975780)';
% Number of T Cell Clones
% CD8+
params.n_clones_CD8.Value = 100;
params.n_clones_CD8.Units = 'dimensionless';
params.n_clones_CD8.Notes = '(estimated)';
% CD4+
params.n_clones_CD4.Value = 100;
params.n_clones_CD4.Units = 'dimensionless';
params.n_clones_CD4.Notes = '(estimated)';
% T Cell Diversity
% CD8+
params.nT_div_CD8.Value = 1.11e6;
params.nT_div_CD8.Units = 'dimensionless';
params.nT_div_CD8.Notes = '(Robins 2009, PMID: 19706884)';
% CD4+
params.nT_div_CD4.Value = 1.16e6;
params.nT_div_CD4.Units = 'dimensionless';
params.nT_div_CD4.Notes = '(Robins 2009, PMID: 19706884)';
% Natural Treg in blood
% params.nTreg_C.Value = 2.5e8;
% params.nTreg_C.Units = 'cell';
% params.nTreg_C.Notes = '(Churlaud 2015)';
% Naive CD8+ T Cell Density in Blood
params.rho_nTCD8.Value = 5.05e5;
params.rho_nTCD8.Units = 'cell/milliliter';
params.rho_nTCD8.Notes = '(Autissier 2010, PMID: 20099249)';
% Naive CD4+ T Cell Density in Blood
params.rho_nTCD4.Value = 8.60e5;
params.rho_nTCD4.Units = 'cell/milliliter';
params.rho_nTCD4.Notes = '(Autissier 2010, PMID: 20099249)';
% Naive T Cell Lymph Node Entry Rate
params.q_in.Value = 0.07;
params.q_in.Units = '1/day/milliliter';
params.q_in.Notes = 'estimated based on 12-hr dwell time of T cells in the LN (Mandl 2012, PMID: 23071319) and assuming 600 LN in the body (Ferrer 1998, PMID: 9803196)';
% Naive T Cell Lymph Node Exit Rate
params.q_out.Value = 1.13;
params.q_out.Units = '1/day';
params.q_out.Notes = '(Mandl 2012, PMID: 23071319)';
% Thymic output of naive CD4 T Cells into the blood
% params.Q_CD4_thym.Value = 6.8e7;
% params.Q_CD4_thym.Units = 'cell/day';
% params.Q_CD4_thym.Notes = '(Bains 2009)';
% Rate of naive T cell proliferation
% params.k_nT_pro_CD4.Value = 3.2e8;
% params.k_nT_pro_CD4.Units = 'cell/day';
% params.k_nT_pro_CD4.Notes = '(Braber 2012)';
% Thymic output of naive CD8 T Cells into the blood
% params.Q_CD8_thym.Value = 3.2e7;
% params.Q_CD8_thym.Units = 'cell/day';
% params.Q_CD8_thym.Notes = '(Bains 2009)';
% Rate of naive T cell proliferation
% params.k_nT_pro_CD8.Value = 3.2e8;
% params.k_nT_pro_CD8.Units = 'cell/day';
% params.k_nT_pro_CD8.Notes = '(Braber 2012)';
% nNaive T cell density for half-maximal peripheral proliferation
% params.K_nT_pro.Value = 1e9;
% params.K_nT_pro.Units = 'cell';
% params.K_nT_pro.Notes = '(Braber 2012)';
% Rate of naive T cell death
% params.k_nT_death.Value = 0.002;
% params.k_nT_death.Units = '1/day';
% params.k_nT_death.Notes = '(Braber 2012)';
% Maximum Rate of T Cell Activation by mAPCs
params.k_nTCD8.Value = 20;
params.k_nTCD8.Units = '1/day';
params.k_nTCD8.Notes = '(De Boer and Perelson 1995, PMID: 7475092)';
% Maximum Rate of Treg Activation by APCs
params.k_nTCD4.Value = 20;
params.k_nTCD4.Units = '1/day';
params.k_nTCD4.Notes = '(De Boer and Perelson 1995, PMID: 7475092)';
% Rate of T Cell Proliferation
% CD8+
params.k_pro_CD8.Value = 1.0;
params.k_pro_CD8.Units = '1/day';
params.k_pro_CD8.Notes = '(Marchingo 2014, PMID: 25430770)';
% CD4+
params.k_pro_CD4.Value = 1.0;
params.k_pro_CD4.Units = '1/day';
params.k_pro_CD4.Notes = '(Marchingo 2014, PMID: 25430770)';
% Rate of Teff Cell Decay
params.k_Teff_death.Value = 0.01;
params.k_Teff_death.Units = '1/day';
params.k_Teff_death.Notes = '(De Boer and Perelson 1995, PMID: 7475092)';
% Rate of Treg Cell Decay
params.k_Treg_death.Value = 0.01;
params.k_Treg_death.Units = '1/day';
params.k_Treg_death.Notes = '(De Boer and Perelson 1995, PMID: 7475092)';
% Teff Rate of Transmigration
params.k_Teff_mig.Value = 1.0e-12;
params.k_Teff_mig.Units = '1/minute/cell';
params.k_Teff_mig.Notes = '(Zhu 1996, PMID: 8706023)';
% Treg Rate of Transmigration
params.k_Treg_mig.Value = 1.0e-12;
params.k_Treg_mig.Units = '1/minute/cell';
params.k_Treg_mig.Notes = '(Zhu 1996, PMID: 8706023)';
% T cell Adhesion Density
params.rho_adh.Value = 5e8; % 5e8-1e9
params.rho_adh.Units = 'cell/centimeter^3';
params.rho_adh.Notes = '(Zhu 1996, PMID: 8706023)';
% Teff Transport P->C
params.q_Teff_P_out.Value = 1.0;
params.q_Teff_P_out.Units = '1/day';
params.q_Teff_P_out.Notes = '(Zhu 1996, PMID: 8706023)';
% Treg Transport P->C
params.q_Treg_P_out.Value = 0.015;
params.q_Treg_P_out.Units = '1/day';
params.q_Treg_P_out.Notes = '(Zhu 1996, PMID: 8706023)';
% Teff Transport LN->C
params.q_Teff_LN_out.Value = 24.0;
params.q_Teff_LN_out.Units = '1/day';
params.q_Teff_LN_out.Notes = '(De Boer and Perelson 1995, PMID: 7475092)';
% Treg Transport LN->C
params.q_Treg_LN_out.Value = 24.0;
params.q_Treg_LN_out.Units = '1/day';
params.q_Treg_LN_out.Notes = '(De Boer and Perelson 1995, PMID: 7475092)';

% Properties for CTLA4-mediated Treg depletion (ADCC)
% CTLA4-Ipi Concentration for Half-Maximal Treg death
params.Treg_CTLA4_50.Value = 1000;
params.Treg_CTLA4_50.Units = 'molecule';
params.Treg_CTLA4_50.Notes = '(estimated)';
% Hill Coefficient for CTLA4-Ipi
params.n_Treg_CTLA4.Value = 2;
params.n_Treg_CTLA4.Units = 'dimensionless';
params.n_Treg_CTLA4.Notes = '(estimated)';
% CTLA4 Expression on Tregs
params.Treg_CTLA4_tot.Value = 5000;
params.Treg_CTLA4_tot.Units = 'molecule';
params.Treg_CTLA4_tot.Notes = '(Jansson 2005, PMID: 16034096)';
% Ipi ADCC (antibody-dependent cellular cytotoxicity) rate of Treg
params.k_CTLA4_ADCC.Value = 0.1;
params.k_CTLA4_ADCC.Units = '1/day';
params.k_CTLA4_ADCC.Notes = '(Richards 2008, PMID: 18723496)';
% IgG1-FcRIIIa V158 kon
% params.kon_IgG1_FcR.Value =  8.2e3;
% params.kon_IgG1_FcR.Units = '1/(molarity*second)';
% params.kon_IgG1_FcR.Notes = '(Li 2007, PMID: 17202140)';
% IgG1-FcRIIIa V158 Kd
% params.kd_IgG1_FcR.Value = 0.28; % 0.28 - 0.5 uM
% params.kd_IgG1_FcR.Units = 'micromolarity';
% params.kd_IgG1_FcR.Notes = '(Bruhns 2009, PMID: 19018092; Richards 2008, PMID: 18723496)';
% RcRIIIa Expression on Tregs
% params.FcRIIIa_tot.Value = 2.4e5; % 2.51e6 - 3.55e6 - 3.98e6
% params.FcRIIIa_tot.Units = 'molecule';
% params.FcRIIIa_tot.Notes = '(Richards 2008, PMID: 18723496; Robinett 2018, PMID: 29960887)';

% IL2 Parameters
% Degradation Rate
params.k_IL2_deg.Value = 0.2;
params.k_IL2_deg.Units = '1/minute';
params.k_IL2_deg.Notes = '(Lotze 1985, PMID: 3871099)';
% Maximum Consumption Rate by T Cells
params.k_IL2_cons.Value = 6.0e-6;
params.k_IL2_cons.Units = 'nanomole/cell/hour';
params.k_IL2_cons.Notes = '(Lotze 1985, PMID: 3871099)';
% Secretion Rate from Activated T Cells
params.k_IL2_sec.Value = 6.0e-6*5;
params.k_IL2_sec.Units = 'nanomole/cell/hour';
params.k_IL2_sec.Notes = '(Han 2012, PMID: 22160692; Thurley 2015, PMID: 25923703; Liu 2001)';
% IL2 Concentration for Half-Maximal T Cell Proliferation
params.IL2_50.Value = 0.32;
params.IL2_50.Units = 'nanomolarity';
params.IL2_50.Notes = '(Marchingo 2014, PMID: 25430770)';
% IL2 Concentration for Half-Maximal Treg Proliferation
params.IL2_50_Treg.Value = 0.0032;
params.IL2_50_Treg.Units = 'nanomolarity';
params.IL2_50_Treg.Notes = '(Wang and Smith 1987, PMID: 3116143)';
% Baseline Number of Activated T Cell Generations
params.N0.Value = 2;
params.N0.Units = 'dimensionless';
params.N0.Notes = '(Marchingo 2014, PMID: 25430770)';
% Baseline Number of Activated T Cell Generations for co-stimulation
params.N_costim.Value = 3;
params.N_costim.Units = 'dimensionless';
params.N_costim.Notes = '(Marchingo 2014, PMID: 25430770)';
% Additional Number of Activated T Cell Generations Due to IL2
params.N_IL2.Value = 11;
params.N_IL2.Units = 'dimensionless';
params.N_IL2.Notes = '(Marchingo 2014, PMID: 25430770)';

% APC Module
% Rate of APC Maturation
params.k_APC_mat.Value = 1.5;
params.k_APC_mat.Units = '1/day';
params.k_APC_mat.Notes = '(Chen 2014, PMID: 25184733)';
% Rate of APC Migration
params.k_APC_mig.Value = 4.0;
params.k_APC_mig.Units = '1/day';
params.k_APC_mig.Notes = '(Russo Halin 2016, PMID: 26876174)';
% Rate of APC Death
params.k_APC_death.Value = 0.01;
params.k_APC_death.Units = '1/day';
params.k_APC_death.Notes = '(Marino and Kirschner 2004, PMID: 15038983)';
% Rate of mAPC Death
params.k_mAPC_death.Value = 0.02;
params.k_mAPC_death.Units = '1/day';
params.k_mAPC_death.Notes = '(Marino and Kirschner 2004, PMID: 15038983)';
% APC Density in Tumour
params.APC0_T.Value = 4.0e5;
params.APC0_T.Units = 'cell/milliliter';
params.APC0_T.Notes = '(Lavin 2017, PMID: 28475900)';
% APC Density in LN
params.APC0_LN.Value = 1.2e6;
params.APC0_LN.Units = 'cell/milliliter';
params.APC0_LN.Notes = '(Catron 2004, PMID: 15357945)';
% Cytokine Time Constant
params.k_c.Value = 2.0;
params.k_c.Units = '1/day';
params.k_c.Notes = '(Chen 2014, PMID: 25184733)';
% Baseline Cytokine Concentration
params.c0.Value = 1.0e-9;
params.c0.Units = 'molarity';
params.c0.Notes = '(Chen 2014, PMID: 25184733)';
% Cytokine Concentration for Half-Maximal APC Maturation
params.c50.Value = 1.0e-9;
params.c50.Units = 'molarity';
params.c50.Notes = '(Chen 2014, PMID: 25184733)';
% Concentration of Cytokines Released by Cancer Cell Death
params.DAMPs.Value = 1.34e-14;
params.DAMPs.Units = 'mole/cell';
params.DAMPs.Notes = '(Milo 2013, PMID: 24114984, Ponomarenko 2016, PMID: 27298622)';
% Maximum Number of T Cells an APC can Interact with
params.n_sites_APC.Value = 10;
params.n_sites_APC.Units = 'dimensionless';
params.n_sites_APC.Notes = '(De Boer and Perelson 1995, PMID: 7475092)';

% Antigen Module Parameters
% Number of MHC Molecule Types
params.N_MHC.Value = 1;
params.N_MHC.Units = 'dimensionless';
params.N_MHC.Notes = '';
% Total Amount of MHC
% params.n_MHC_T.Value = 1e-19*10;
params.n_MHC_T.Value = 2e5*10;
params.n_MHC_T.Units = 'molecule';
params.n_MHC_T.Notes = '(Chen 2014, PMID: 25184733)';
% Rate of MHC Internalization
params.kin.Value = 14.4;
params.kin.Units = '1/day';
params.kin.Notes = '(Chen 2014, PMID: 25184733)';
% Rate of MHC Externalization
params.kout.Value = 28.8;
params.kout.Units = '1/day';
params.kout.Notes = '(Chen 2014, PMID: 25184733)';
% Number of Endosomal Vesicles per Cell
params.N_endo.Value = 10;
params.N_endo.Units = 'dimensionless';
params.N_endo.Notes = '(Agrawal and Linderman 1996, PMID: 8944895)';
% Endosomal Volume
params.V_endo.Value = 4.0e-17;
params.V_endo.Units = 'liter';
params.V_endo.Notes = '(Agrawal and Linderman 1996, PMID: 8944895)';
% Endosomal Surface Area
params.A_endo.Value = 1.5;
params.A_endo.Units = 'micrometer^2';
params.A_endo.Notes = '(Agrawal and Linderman 1996, PMID: 8944895)';
% Endosomal Surface Area
params.A_s.Value = 900.0;
params.A_s.Units = 'micrometer^2';
params.A_s.Notes = '(Agrawal and Linderman 1996, PMID: 8944895)';
% Rate of Antigen Uptake
params.k_up.Value = 14.4;
params.k_up.Units = '1/day/cell';
params.k_up.Notes = '(Chen 2014, PMID: 25184733)';
% Rate of Extracellular Antigen Degradation
params.k_xP_deg.Value = 2.0;
params.k_xP_deg.Units = '1/day';
params.k_xP_deg.Notes = '(Palsson 2013, PMID: 24074340)';
% Rate of Endosomal Antigen Degradation
params.k_P_deg.Value = 17.28;
params.k_P_deg.Units = '1/day';
params.k_P_deg.Notes = '(Chen 2014, PMID: 25184733)';
% Rate of Endosomal Epitope Degradation
params.k_p_deg.Value = 144.0;
params.k_p_deg.Units = '1/day';
params.k_p_deg.Notes = '(Chen 2014, PMID: 25184733)';
% Rate of Antigen Binding
params.k_on.Value = 1.44e5; % 8.64e9
params.k_on.Units = '1/day/molarity';
params.k_on.Notes = '(Agrawal and Linderman 1996, PMID: 8944895)';
% Default Kd
params.kd.Value = 40.0;
params.kd.Units = 'nanomolarity';
params.kd.Notes = '(estimated)';
% Number of Epitope Molecules for Half-Maximal T Cell Activation
params.N_p_50.Value = 0.1/100;
params.N_p_50.Units = 'molecule';
params.N_p_50.Notes = '(Kimachi 1997, PMID: 9464819)';

% TCR signal - kinetic proofreading with limited signaling
% Number of TCR molecules on naive T cells
params.TCR_tot.Value = 15708;
params.TCR_tot.Units = 'molecule';
params.TCR_tot.Notes = '(Lever 2014, PMID: 25145757)';
% Rate of modification of TCRs
params.k_TCR_p.Value = 1;
params.k_TCR_p.Units = '1/second';
params.k_TCR_p.Notes = '(Lever 2014, PMID: 25145757)';
% Unbinding rate of ag/MHC to TCR
params.k_TCR_off.Value = 1;
params.k_TCR_off.Units = '1/second';
params.k_TCR_off.Notes = '(Lever 2014, PMID: 25145757)';
% binding rate of ag/MHC to TCR
params.k_TCR_on.Value = 1e-0; %3.1831e-5;
params.k_TCR_on.Units = '1/(second*molecule/micrometer^2)';
params.k_TCR_on.Notes = '(Lever 2014, PMID: 25145757)';
% Rate of modification of TCR that leads to non-signaling
params.phi_TCR.Value = 0.09;
params.phi_TCR.Units = '1/second';
params.phi_TCR.Notes = '(Lever 2014, PMID: 25145757)';
% Number of intermediate steps
params.N_TCR.Value = 10;
params.N_TCR.Units = 'dimensionless';
params.N_TCR.Notes = '(Lever 2014, PMID: 25145757)';

% Checkpoint Module Parameters
% Surface area of the synapse
params.A_syn.Value = 37.8;
params.A_syn.Units = 'micrometer^2';
params.A_syn.Notes = '(Jansson 2005, PMID: 16034096)';
% The synapse gap distance (kd 2D = kd3D*d_syn)
params.d_syn.Value = 3.0;
params.d_syn.Units = 'nanometer';
params.d_syn.Notes = '(Jansson 2005, PMID: 16034096)';
% PD1/PDL1 Parameters
% PD1-PDL1 kd
params.kd_PD1_PDL1.Value = 8.2;
params.kd_PD1_PDL1.Units = 'micromolarity';
params.kd_PD1_PDL1.Notes = '(Cheng 2013, PMID: 23417675)';
% PD1-PDL1 kon
params.kon_PD1_PDL1.Value = 0.175;
params.kon_PD1_PDL1.Units = '1/(micromolarity*second)';
params.kon_PD1_PDL1.Notes = '(Cheng 2013, PMID: 23417675)';
% PD1-PDL2 kd
params.kd_PD1_PDL2.Value = 2.3;
params.kd_PD1_PDL2.Units = 'micromolarity';
params.kd_PD1_PDL2.Notes = '(Cheng 2013, PMID: 23417675)';
% PD1-PDL2 kon
params.kon_PD1_PDL2.Value = 0.23;
params.kon_PD1_PDL2.Units = '1/(micromolarity*second)';
params.kon_PD1_PDL2.Notes = '(Cheng 2013, PMID: 23417675)';
% PD1-nivolumab kd
params.kd_PD1_nivo.Value = 2.60;
params.kd_PD1_nivo.Units = 'nanomolarity';
params.kd_PD1_nivo.Notes = '(Wang 2014, PMID: 24872026)';
% PD1-nivolumab kon
params.kon_PD1_nivo.Value = 1.3e6;
params.kon_PD1_nivo.Units = '1/(molarity*second)';
params.kon_PD1_nivo.Notes = '(Wang 2014, PMID: 24872026)';
% PD1-nivolumab Chi (antibody cross-arm binding strength)
params.Chi_PD1_nivo.Value = 10;
params.Chi_PD1_nivo.Units = 'dimensionless';
params.Chi_PD1_nivo.Notes = '(Estimated based on Wang 2014, PMID: 24872026)';
% PDL1-durvalumab kd
params.kd_PDL1_durv.Value = 6.65e1;
params.kd_PDL1_durv.Units = 'nanomolarity';
params.kd_PDL1_durv.Notes = '(Wang 2014, PMID: 24872026)';
% PDL1-durvalumab kon
params.kon_PDL1_durv.Value = 4.3e5;
params.kon_PDL1_durv.Units = '1/(molarity*second)';
params.kon_PDL1_durv.Notes = '(Wang 2014, PMID: 24872026)';
% PDL1-durvalumab Chi (antibody cross-arm binding strength)
params.Chi_PDL1_durv.Value = 100;
params.Chi_PDL1_durv.Units = 'dimensionless';
params.Chi_PDL1_durv.Notes = '(estimated)';
% PD1 Expression on T Cells
params.T8_PD1.Value = 3.0e3*20;
params.T8_PD1.Units = 'molecule';
params.T8_PD1.Notes = '(Cheng 2014, PMID: 23417675)';
% PDL1 Expression on T Cells
params.T8_PDL1.Value = 8.0e4*20;
params.T8_PDL1.Units = 'molecule';
params.T8_PDL1.Notes = '(Cheng 2014, PMID: 23417675)';
% PDL1 Expression on Cancer Cells
params.C_PDL1.Value = 8.0e4*20;
params.C_PDL1.Units = 'molecule';
params.C_PDL1.Notes = '(Cheng 2014, PMID: 23417675)';
% PDL2 Expression on Cancer Cells
params.C_PDL2.Value = 2.0e3;
params.C_PDL2.Units = 'molecule';
params.C_PDL2.Notes = '(Cheng 2014, PMID: 23417675)';
% PDL1 Expression on APCs
params.APC_PDL1.Value = 8.0e4*20;
params.APC_PDL1.Units = 'molecule';
params.APC_PDL1.Notes = '(Cheng 2014, PMID: 23417675)';
% PDL2 Expression on APCs
params.APC_PDL2.Value = 2.0e3;
params.APC_PDL2.Units = 'molecule';
params.APC_PDL2.Notes = '(Cheng 2014, PMID: 23417675)';
% PD1/PDL1 Concentration for Half-Maximal T Cell Killing
params.PD1_50.Value = 6/1;
params.PD1_50.Units = 'molecule/micrometer^2';
params.PD1_50.Notes = '(estimated)';
% Hill Coefficient for PD1/PDL1
params.n_PD1.Value = 2*1;
params.n_PD1.Units = 'dimensionless';
params.n_PD1.Notes = '(estimated)';

% CD28/CTLA4/CD80/CD86 Parameters
% CD28-CD80 kd
params.kd_CD28_CD80.Value = 4.0;
params.kd_CD28_CD80.Units = 'micromolarity';
params.kd_CD28_CD80.Notes = '(Jansson 2005, PMID: 16034096)';
% CD28-CD80 kon
params.kon_CD28_CD80.Value = 0.4;
params.kon_CD28_CD80.Units = '1/(micromolarity*second)';
params.kon_CD28_CD80.Notes = '(Jansson 2005, PMID: 16034096)';
% CD28-CD86 kd
params.kd_CD28_CD86.Value = 20.0;
params.kd_CD28_CD86.Units = 'micromolarity';
params.kd_CD28_CD86.Notes = '(Jansson 2005, PMID: 16034096)';
% CD28-CD86 kon
params.kon_CD28_CD86.Value = 1.4;
params.kon_CD28_CD86.Units = '1/(micromolarity*second)';
params.kon_CD28_CD86.Notes = '(Jansson 2005, PMID: 16034096)';
% CTLA4-CD80 kd
params.kd_CTLA4_CD80.Value = 0.2;
params.kd_CTLA4_CD80.Units = 'micromolarity';
params.kd_CTLA4_CD80.Notes = '(Jansson 2005, PMID: 16034096)';
% CTLA4-CD80 kon
params.kon_CTLA4_CD80.Value = 2.2;
params.kon_CTLA4_CD80.Units = '1/(micromolarity*second)';
params.kon_CTLA4_CD80.Notes = '(Jansson 2005, PMID: 16034096)';
% CTLA4-CD86 kd
params.kd_CTLA4_CD86.Value = 2.6;
params.kd_CTLA4_CD86.Units = 'micromolarity';
params.kd_CTLA4_CD86.Notes = '(Jansson 2005, PMID: 16034096)';
% CTLA4-CD86 kon
params.kon_CTLA4_CD86.Value = 2.0;
params.kon_CTLA4_CD86.Units = '1/(micromolarity*second)';
params.kon_CTLA4_CD86.Notes = '(Jansson 2005, PMID: 16034096)';
% CD80-PDL1 kd
params.kd_CD80_PDL1.Value = 1.9;
params.kd_CD80_PDL1.Units = 'micromolarity';
params.kd_CD80_PDL1.Notes = '(Jansson 2005, PMID: 16034096)';
% CD80-PDL1 kon
params.kon_CD80_PDL1.Value = 3.16;
params.kon_CD80_PDL1.Units = '1/(micromolarity*second)';
params.kon_CD80_PDL1.Notes = '(Jansson 2005, PMID: 16034096)';
% CTLA4-ipilimumab kd
params.kd_CTLA4_ipi.Value = 18.2;
params.kd_CTLA4_ipi.Units = 'nanomolarity';
params.kd_CTLA4_ipi.Notes = '(Wang 2014, PMID: 24872026)';
% CTLA4-ipilimumab kon
params.kon_CTLA4_ipi.Value = 3.83e5;
params.kon_CTLA4_ipi.Units = '1/(molarity*second)';
params.kon_CTLA4_ipi.Notes = '(Wang 2014, PMID: 24872026)';
% CTLA4-ipilimumab Chi (antibody cross-arm binding strength)
params.Chi_CTLA4_ipi.Value = 10;
params.Chi_CTLA4_ipi.Units = 'dimensionless';
params.Chi_CTLA4_ipi.Notes = '(Estimated)';
% CD28 Expression on T Cells
params.T8_CD28.Value = 9200*20;
params.T8_CD28.Units = 'molecule';
params.T8_CD28.Notes = '(Jansson 2005, PMID: 16034096)';
% CTLA4 Expression in T Cell synapse
params.T8_CTLA4.Value = 400;
params.T8_CTLA4.Units = 'molecule';
params.T8_CTLA4.Notes = '(Jansson 2005, PMID: 16034096)';
% CD80 Expression on Cancer Cells
params.C_CD80.Value = 2000*20;
params.C_CD80.Units = 'molecule';
params.C_CD80.Notes = '(Jansson 2005, PMID: 16034096)';
% CD86 Expression on Cancer Cells
params.C_CD86.Value = 43000*20;
params.C_CD86.Units = 'molecule';
params.C_CD86.Notes = '(Jansson 2005, PMID: 16034096)';
% CD80 Expression on APCs
params.APC_CD80.Value = 2000*20;
params.APC_CD80.Units = 'molecule';
params.APC_CD80.Notes = '(Jansson 2005, PMID: 16034096)';
% CD86 Expression on APCs
params.APC_CD86.Value = 43000*20;
params.APC_CD86.Units = 'molecule';
params.APC_CD86.Notes = '(Jansson 2005, PMID: 16034096)';
% CD28/CD80/CD86 Concentration for Half-Maximal T Cell Killing
params.CD28_CD8X_50.Value = 200;
params.CD28_CD8X_50.Units = 'molecule/micrometer^2';
params.CD28_CD8X_50.Notes = '(estimated)';
% Hill Coefficient for CD28/CD80/CD86
params.n_CD28_CD8X.Value = 2;
params.n_CD28_CD8X.Units = 'dimensionless';
params.n_CD28_CD8X.Notes = '(estimated)';

% Antibody Transport Properties
% Permeability
% Central <-> Peripheral
params.Dk_P.Value = 3.0e-8;
params.Dk_P.Units = 'centimeter/second';
params.Dk_P.Notes = '(Finley 2012)';
% Central <-> Tumour
params.Dk_T.Value = 3.0e-7;
params.Dk_T.Units = 'centimeter/second';
params.Dk_T.Notes = '(Finley 2012)';
% Central <-> LN
params.Dk_LN.Value = 3.0e-8;
params.Dk_LN.Units = 'centimeter/second';
params.Dk_LN.Notes = '(Padera 2017)';
% Surface Area Density
% Peripheral
params.SA_P.Value = 105000.0;
params.SA_P.Units = 'centimeter^2/liter';
params.SA_P.Notes = '(Finley 2012)';
% Tumour
params.SA_T.Value = 105000.0;
params.SA_T.Units = 'centimeter^2/liter';
params.SA_T.Notes = '(Finley 2012)';
% LN
params.SA_LN.Value = 105000.0;
params.SA_LN.Units = 'centimeter^2/liter';
params.SA_LN.Notes = '(Finley 2012)';
% Lymphatic Drainage
params.Q_LD.Value = 0.0015;
params.Q_LD.Units = '1/minute';
params.Q_LD.Notes = '(Zhu 1996, PMID: 8706023)';

% MDSC recruitment rate
params.k_rec_MDSC.Value = 1.2;
params.k_rec_MDSC.Units = '1/day';
params.k_rec_MDSC.Notes = '(Lai 2018, PMID: 29735668; Huang 2006, PMID: 17257744)';
% Baseline MDSC migration rate
params.k_brec_MDSC.Value = 0.0021;
params.k_brec_MDSC.Units = '1/day';
params.k_brec_MDSC.Notes = '(Huang 2006, PMID: 17257744)';
% rate of MDSC death
params.kd_MDSC.Value = 0.015;
params.kd_MDSC.Units = '1/day';
params.kd_MDSC.Notes = '(Lai 2018, PMID: 29735668)';
% cancer death rate by entinostat
% params.kd_C_ENT.Value = 2.2;
% params.kd_C_ENT.Units = '1/day';
% params.kd_C_ENT.Notes = '(Lee 2001, PMID: 11221885)';
% half-maximal ENT concentration for anti-proliferative effect on tumor cells
params.IC50_ENT_C.Value = 3.74e-7;
params.IC50_ENT_C.Units = 'molarity';
params.IC50_ENT_C.Notes = '(Bouchain 2002, PMID: 12593661; Lee 2001, PMID: 11221885)';
% half-life of IL-10: 1.1 - 2.6 day Mueller 2009, PMID: 18818669

% rate of MCP-1 degradtion
params.k_deg_CCL2.Value = 0.06;
params.k_deg_CCL2.Units = '1/hour';
params.k_deg_CCL2.Notes = '(Tanimoto 2007, PMID: 18089573)';
% rate of NO degradtion
params.k_deg_NO.Value = 135;
params.k_deg_NO.Units = '1/day';
params.k_deg_NO.Notes = '(Hakim 1996, PMID: 8953625)';
% rate of ArgI degradtion
params.k_deg_ArgI.Value = 0.173;
params.k_deg_ArgI.Units = '1/day';
params.k_deg_ArgI.Notes = '(Schimke 1964, PMID: 14257612)';
% rate of MCP-1 secretion
params.k_sec_CCL2.Value = 14.2e-11; % normal: 1.065e-11; TNBC: (14.2 +/- 6)*10^-11
params.k_sec_CCL2.Units = 'nanomole/cell/day';
params.k_sec_CCL2.Notes = '(Huang 2007, PMID: 17257744; Dutta, PMID: 29594759)';
% rate of NO secretion
params.k_sec_NO.Value = 4.8e-7;
params.k_sec_NO.Units = 'nanomole/cell/day';
params.k_sec_NO.Notes = '(Serafini 2008, PMID: 18593947)';
% rate of ArgI secretion
params.k_sec_ArgI.Value = 1.4e-2;
params.k_sec_ArgI.Units = '(mU*microliter)/cell/day';
params.k_sec_ArgI.Notes = '(Serafini 2008, PMID: 18593947)';
% half-maximal ENT concentration for NO inhibition
params.IC50_ENT_NO.Value = .56e-9; % <1 nM
params.IC50_ENT_NO.Units = 'molarity';
params.IC50_ENT_NO.Notes = '(Choo 2010, PMID: 20421217)';
% half-maximal ENT concentration for MCP-1 inhibition
params.IC50_ENT_CCL2.Value = 1.2e-9; % <2 nM
params.IC50_ENT_CCL2.Units = 'molarity';
params.IC50_ENT_CCL2.Notes = '(Choo 2013, PMID: 24241152)';
% half-maximal ENT concentration for Arg I inhibition
params.IC50_ENT_ArgI.Value = 5e-7;
params.IC50_ENT_ArgI.Units = 'molarity';
params.IC50_ENT_ArgI.Notes = '(Orillian 2017, PMID: 28698201)';

% rate of ArgI-induced Treg expension
params.ki_Treg.Value = 2.7;
params.ki_Treg.Units = '1/day';
params.ki_Treg.Notes = '(Serafini 2008, PMID: 18593947)';
% rate of ArgI/NO-induced T cell death Park 2018, PMID: 29491381
% half-maximal ArgI concentration for CTL inhibition
params.IC50_ArgI_CTL.Value = 61.7;
params.IC50_ArgI_CTL.Units = 'mU';
params.IC50_ArgI_CTL.Notes = '(Serafini 2008, PMID: 18593947)';
% half-maximal NO concentration for CTL inhibition
params.IC50_NO_CTL.Value = .75e-9;
params.IC50_NO_CTL.Units = 'molarity';
params.IC50_NO_CTL.Notes = '(Serafini 2008, PMID: 18593947)';
% half-maximal CCL2 concentration for MDSC recruitment
params.EC50_CCL2_rec.Value = 5e-10;
params.EC50_CCL2_rec.Units = 'molarity';
params.EC50_CCL2_rec.Notes = '(Ernst 1994, PMID: 8144933)';
% half-maximal ArgI concentration for Treg expension
params.EC50_ArgI_Treg.Value = 22.1;
params.EC50_ArgI_Treg.Units = 'mU';
params.EC50_ArgI_Treg.Notes = '(estimated; Serafini 2008, PMID: 18593947)';
% Maximal MDSC level
params.MDSC_max.Value = 1.637e5;
params.MDSC_max.Units = 'cell/milliliter';
params.MDSC_max.Notes = '(estimated)';
% Maximal Treg density in tumor
params.Treg_max.Value = 955;
params.Treg_max.Units = 'cell/milliliter';
params.Treg_max.Notes = '(Bates 2006, PMID: 17135638)';
