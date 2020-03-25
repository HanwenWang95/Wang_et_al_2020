% Initial Conditions Debugging Script
%
% Script for testing ICs
%
% Created: Mar 25, 2019 (Richard Sové)
% Last Modified: Mar 25, 2019 (RJS)

% Setup the model
if ~exist('model','var')
    disp('Model Setup');
    tic
    setup_model;
    toc
end

% Number of ICs
numICs = length(model.Species);

model_old = copyobj(model);
model_new = copyobj(model);

% Run new and old ICs
disp('old ICs');
tic
[model_old,success_old,simDataIC_old] = initial_conditions(model_old);
toc
disp('new ICS');
tic
[model_new,sucess_new,simDataIC_new] = initial_conditions_new(model_new);
toc

% Store ICs
ICs_old = zeros(length(model.Species),1);
ICs_new = zeros(length(model.Species),1);
for i = 1:numICs
    ICs_old(i) = model_old.Species(i).InitialAmount;
    ICs_new(i) = model_new.Species(i).InitialAmount;
end

% Compare
meanIC = (ICs_new+ICs_old)/2;
meanIC = (meanIC~=0).*meanIC + (meanIC==0);
diff = abs(ICs_new-ICs_old)./meanIC;
numDiff = sum(diff>0);
figure; plot(diff); title('IC Differences'); xlabel('ICs'); ylabel('Percent Difference');
disp(['Number of differences: ' num2str(numDiff) '/' num2str(numICs)]);

% Plot 
figure; simbio_plot(simDataIC_old,'V_T','legendEntry','old');
hold on; simbio_plot(simDataIC_new,'V_T','legendEntry','new');
title('IC Run');

% Simulate with New ICs
simData_old = sbiosimulate(model_old);
simData_new = sbiosimulate(model_new);

% Plot 
figure; simbio_plot(simData_old,'V_T','legendEntry','old');
hold on; simbio_plot(simData_new,'V_T','legendEntry','new');
title('Simulation');