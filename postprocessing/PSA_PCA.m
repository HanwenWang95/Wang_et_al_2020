% Function to run the model with parameter snesitivity analysis cases
%
% Inputs: model        -- simbio data from PSA  
%         params       -- object containing LHS values of model parameters
%         n_PSA        -- number of samples
%        
% Outputs: simDataPSA  -- results from the LHS simulations 
%
% Created: Jan 21, 2019 (Mohammad Jafarnejad)
% Last Modified: Jan 21, 2019 (MJ)

function PSA_PCA(simDataPSA,params_in)

% Use PCA to categorize the simulations into phenotypic subtypes 
C = corr(params_in.postPlaus , simDataPSA.postPlaus);

%     C = corr(CorrMatrix,CorrMatrix);
%     w = 1./var(CorrMatrix);
%     [wcoeff,score,latent,tsquared,explained] = pca(CorrMatrix,'VariableWeights',w);
%      c3 = wcoeff(:,1:3);
%     coefforth = inv(diag(std(CorrMatrix)))*wcoeff;
%     I = coefforth'*coefforth;
%     I(1:3,1:3);
%     cscores = zscore(CorrMatrix)*coefforth;

%     figure
%     plot(score(:,1),score(:,2),'+')
%     xlabel('1st Principal Component')
%     ylabel('2nd Principal Component')
% %     latent
% %     explained
% 
%     figure
%     pareto(explained)
%     xlabel('Principal Component')
%     ylabel('Variance Explained (%)')
%     biplot(coefforth(:,1:2),'Scores',score(:,1:2),'Varlabels',names);
%     axis([-.26 0.6 -.51 .51]);


