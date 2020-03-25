% SimBiology Plot Progression-free survival for PSA cases 
% It assumes that only reason for progression to be 20% increase in the 
% lesion size
%
% Inputs: simDataPSA     -- Object containing the simbiology model outputs
%                            for all batch simulations 
%         simDataPSApost -- Object containing the post processed simbiology  
%                           model outputs for all batch simulations 
%         params_out     -- object containing model outputs with RCEIST and
%                           Response status
%         
% Created: May 06, 2019 (Mohammad Jafarnejad)
% Last Modified: May 06, 2019 (MJ) 

function PSA_plot_KaplanMeier(simDataPSA,simDataPSApost,params_out)

index = params_out.iPatientPlaus;
time = simDataPSA(index(1)).simData.Time/30;

figure; hold on; box on;

ecdf(params_out.tPFS/30, 'Function', 'survivor','Bounds','on')

xlabel('Time (month)','Fontsize',12); 
ylabel('PFS','Fontsize',12); 
% ylim([-100 150])
xlim([0  max(time)])
set(gca,'Fontsize',14)