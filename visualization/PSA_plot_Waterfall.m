% Produce waterfall plot for percent change in tumor size for a parameter
%
% Inputs: simDataPSApost -- Object containing the post processed simbiology  
%                           model outputs for all batch simulations 
%         params_in      -- Object containing the input parameters 
%         param          -- name of the parameter used for color coding
%
% Created: Feb 19, 2019 (Mohammad Jafarnejad)
% Last Modified: Feb 19, 2019 (MJ) 

function PSA_plot_Waterfall(simDataPSApost,model,params_in,params_out,param)

n_PSA = length(params_out.iPatientPlaus);
index = params_out.iPatientPlaus;

f = figure; hold on; box on;
set(f,'Position', [50 50 800 500]);
% Find a list of input parameter for each PSA case
tempIn = params_in.(param).LHS(index);
paramName = params_in.(param).ScreenName;
paramInModel = sbioselect (model, 'Type', 'parameter', 'Name', param);
if strcmp(paramInModel.ValueUnits,'dimensionless')
    paramUnit = '';
else
    paramUnit = paramInModel.ValueUnits;
end

% Find outputs for PSA cases
j = [find(strcmp(simDataPSApost(index(1)).simData.DataNames,'D_T_perc') )];
for i =1:n_PSA
    tempOut(i,1) = simDataPSApost(index(i)).simData.Data(end,j);
end
temp = [tempIn, tempOut];
temp = sortrows(temp, 2 ,'descend');
tempMedian = median(  temp(:,1) );

ax = gca;
for i = 1:n_PSA
    if temp(i,1) < tempMedian
        ax.ColorOrderIndex = 1;
             h1=bar(i,temp(i,2),'DisplayName',[paramName,' $<$ median'],'LineWidth',0.1,'EdgeColor','none');
    else
        ax.ColorOrderIndex = 2;
             h2=bar(i,temp(i,2),'DisplayName',[paramName,' $>$ median'],'LineWidth',0.1,'EdgeColor','none');
    end
end
h3 = plot( [0, n_PSA*1.2], [+20, +20], '--k' ); 
h4 = plot( [0, n_PSA*1.2], [-30, -30], '--k' ); 
hx = text(n_PSA*1.10, 60,'PD');
hx = text(n_PSA*1.10,-10,'SD');
hx = text(n_PSA*1.05,-60,'PR/CR');

legend([h1 h2],{sprintf([paramName,' $<$ %0.2e ',paramUnit,' (median)'],tempMedian),sprintf([paramName,' $>$ %0.2e ',paramUnit,' (median)'],tempMedian)}); 

% legend([h1 h2],{[param,' < ',num2str(tempMedian,'%6.0f'),' median'],[param,' > ',num2str(tempMedian,'\%6.0f'),' median']});
ylabel('Percent tumor size change ($\%$)','Fontsize',12); 
ylim([-100 100])
xlim([0  n_PSA*1.2])
set(gca,'Fontsize',14)
set(gca,'XTick',[])

   

    