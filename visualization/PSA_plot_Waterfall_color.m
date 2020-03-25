% Produce waterfall plot for percent change in tumor size for a parameter
%
% Inputs: simDataPSApost -- Object containing the post processed simbiology  
%                           model outputs for all batch simulations 
%         params_in      -- Object containing the input parameters 
%         param          -- name of the parameter used for color coding
%
% Created: Mar 21, 2019 (Mohammad Jafarnejad)
% Last Modified: Mar 21, 2019 (MJ) 

function PSA_plot_Waterfall_color(simDataPSApost,model,params_in,params_out,color)

n_PSA = length(params_out.iPatientPlaus);
index = params_out.iPatientPlaus;

f = figure; hold on; box on;
set(f,'Position', [50 50 1000 350]);

% Find outputs for PSA cases
j = [find(strcmp(simDataPSApost(index(1)).simData.DataNames,'D_T_perc') )];
for i =1:n_PSA
    temp(i,1) = simDataPSApost(index(i)).simData.Data(end,j);
end
temp = sortrows(temp, 1 ,'descend');

h1=bar(1:n_PSA,temp(:),'BarWidth',1,'LineWidth',0.1,'EdgeColor','none','FaceColor',color);

h3 = plot( [0, n_PSA*1.2], [+20, +20], '--k' ); 
h4 = plot( [0, n_PSA*1.2], [-30, -30], '--k' ); 
hx = text(n_PSA*1.10, 60,'PD');
hx = text(n_PSA*1.10,-10,'SD');
hx = text(n_PSA*1.05,-60,'PR/CR');

% legend([h1 h2],{sprintf([paramName,' $<$ %0.2e ',paramUnit,' (median)'],tempMedian),sprintf([paramName,' $>$ %0.2e ',paramUnit,' (median)'],tempMedian)}); 

% legend([h1 h2],{[param,' < ',num2str(tempMedian,'%6.0f'),' median'],[param,' > ',num2str(tempMedian,'\%6.0f'),' median']});
ylabel('Percent tumor size change ($\%$)','Fontsize',12); 
ylim([-100 100])
xlim([0  n_PSA*1.2])
set(gca,'Fontsize',14)
set(gca,'XTick',[])

   

    