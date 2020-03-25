% SimBiology Plot tumor size for PSA cases and RECIST criteria
%
% Inputs: simDataPSA     -- Object containing the simbiology model outputs
%                            for all batch simulations 
%         simDataPSApost -- Object containing the post processed simbiology  
%                           model outputs for all batch simulations 
%         params_out     -- object containing model outputs with RCEIST and
%                           Response status
%         
% Created: Feb 17, 2019 (Mohammad Jafarnejad)
% Last Modified: Mar 15, 2019 (MJ) 

function PSA_plot_RECIST(simDataPSA,simDataPSApost,params_out)

% n_PSA = length(params_out.RECIST(params_out.iPlausSim));
n_PSA = length(params_out.iPatientPlaus);
index = params_out.iPatientPlaus;

figure; hold on; box on;

j = [find(strcmp(simDataPSApost(index(1)).simData.DataNames,'D_T_perc') )];

for i =1:n_PSA
    plot(simDataPSA(index(i)).simData.Time/30, ...
         simDataPSApost(index(i)).simData.Data(:,j) ,'DisplayName',num2str(index(i)), 'LineWidth', 2)
end
time = simDataPSA(index(1)).simData.Time/30;
plot([0 max(time)*1.25], [+20 +20] , '--k' ) 
plot([0 max(time)*1.25], [-30 -30] , '--k' ) 
hx = text(max(time)*1.10, 60,'PD');
hx = text(max(time)*1.10,  0,'SD');
hx = text(max(time)*1.05,-60,'PR/CR');
xlabel('Time (month)','Fontsize',12); 
ylabel('Percent tumor size change (\%)','Fontsize',12); 
ylim([-100 100])
xlim([0  max(time)*1.25])
set(gca,'Fontsize',14)