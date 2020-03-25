% function PSA_plot_Spec(params_in, D_T_perc_tri5, param)

param = 'n_T1_clones'; % n_T1_clones k_P1_d1
tempIn = params_in.(param).LHS(index);
tempOut = D_T_perc_tri5(:,end);
temp = [tempIn tempOut];
temp = sortrows(temp, 1);

l = temp(:,1);
%l = log(temp(:,1));

for i = 1:5
  X(i) = (temp(i*200-150,1) + temp(i*200-149,1))/2;
  PR(i) = length(find(temp(i*200-199:i*200, 2) <= -30))/200*100;
  SD(i) = length(find(temp(i*200-199:i*200, 2) <= 20))/200*100;
end
X(6) = (temp(1098,1) + temp(1099,1))/2;
PR(6) = length(find(temp(1000:end, 2) <= -30))/200*100;
SD(6) = length(find(temp(1000:end, 2) <= 20))/200*100;

% Fit the range fro 10 to 20 with a line.
%coeffs = polyfit(X, SD, 3);
%SD = polyval(coeffs, X);
%coeffs = polyfit(X, PR, 3);
%PR = polyval(coeffs, X);

figure
subplot(3,3,1)
hold on

%plot(X, PR)
%plot(X, SD)

ylim([0,100])
xlim([min(X),max(X)])
patch([X max(X) min(X)], [SD 100 100], [.75 0.1 .4], 'EdgeColor', 'none')
patch([X fliplr(X)], [PR fliplr(SD)], [.93 0.69 .13], 'EdgeColor', 'none')
patch([0 X max(X)], [0 PR 0], [0 0.45 .74], 'EdgeColor', 'none')
alpha(0.6)


hXLabel = xlabel('TMB (median)');
hYLabel = ylabel('RECIST (%)');

set(gca, 'FontName', 'Helvetica')
set([hXLabel, hYLabel], 'FontName', 'AvantGarde', 'FontSize', 14)
% set(hTitle, 'FontSize', 16, 'FontWeight' , 'bold')

% Adjust axes properties
set(gca, 'XMinorTick', 'on', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 2)
hold off


%% Param2
param = 'k_P1_d1'; % n_T1_clones k_P1_d1
tempIn = params_in.(param).LHS(index);
tempOut = D_T_perc_tri5(:,end);
temp = [tempIn tempOut];
temp = sortrows(temp, 1);

l = temp(:,1);
%l = log(temp(:,1));

for i = 1:5
  X(i) = (temp(i*200-150,1) + temp(i*200-149,1))/2;
  PR(i) = length(find(temp(i*200-199:i*200, 2) <= -30))/200*100;
  SD(i) = length(find(temp(i*200-199:i*200, 2) <= 20))/200*100;
end
X(6) = (temp(1098,1) + temp(1099,1))/2;
PR(6) = length(find(temp(1000:end, 2) <= -30))/200*100;
SD(6) = length(find(temp(1000:end, 2) <= 20))/200*100;

subplot(3,3,2)
hold on

ylim([0,100])
xlim([min(X),max(X)])
xticks([5e-9 1e-8 3e-8 1e-7 3e-7])

patch([X max(X) min(X)], [SD 100 100], [.75 0.1 .4], 'EdgeColor', 'none')
patch([X fliplr(X)], [PR fliplr(SD)], [.93 0.69 .13], 'EdgeColor', 'none')
patch([min(X) X max(X)], [0 PR 0], [0 0.45 .74], 'EdgeColor', 'none')
alpha(0.6)

hXLabel = xlabel('Kd (median)');
hYLabel = ylabel('RECIST (%)');

set(gca, 'FontName', 'Helvetica')
set([hXLabel, hYLabel], 'FontName', 'AvantGarde', 'FontSize', 14)
set(gca, 'XScale', 'log')
set(gca, 'XMinorTick', 'on', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 2)
hold off

%% Param3
param = 'k_C1_growth';
tempIn = params_in.(param).LHS(index);
tempOut = D_T_perc_tri5(:,end);
temp = [tempIn tempOut];
temp = sortrows(temp, 1);

l = temp(:,1);
%l = log(temp(:,1));

for i = 1:5
  X(i) = (temp(i*200-150,1) + temp(i*200-149,1))/2;
  PR(i) = length(find(temp(i*200-199:i*200, 2) <= -30))/200*100;
  SD(i) = length(find(temp(i*200-199:i*200, 2) <= 20))/200*100;
end
X(6) = (temp(1098,1) + temp(1099,1))/2;
PR(6) = length(find(temp(1000:end, 2) <= -30))/200*100;
SD(6) = length(find(temp(1000:end, 2) <= 20))/200*100;

subplot(3,3,3)
hold on

ylim([0,100])
xlim([min(X),max(X)])
patch([X max(X) min(X)], [SD 100 100], [.75 0.1 .4], 'EdgeColor', 'none')
patch([X fliplr(X)], [PR fliplr(SD)], [.93 0.69 .13], 'EdgeColor', 'none')
patch([min(X) X max(X)], [0 PR 0], [0 0.45 .74], 'EdgeColor', 'none')
alpha(0.6)

xticks([.005 .01 .02 .03])
hXLabel = xlabel('Tumor growth rate (median)');
hYLabel = ylabel('RECIST (%)');
hLegend = legend('PD', 'SD', 'PR/CR');

set(gca, 'FontName', 'Helvetica')
set([hXLabel, hYLabel], 'FontName', 'AvantGarde', 'FontSize', 14)
set(hLegend, 'FontSize', 12)

set(gca, 'XScale', 'log')
set(gca, 'XMinorTick', 'on', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 2)
hold off

%% Param4
param = 'initial_tumour_diameter';
tempIn = params_in.(param).LHS(index);
tempOut = D_T_perc_tri5(:,end);
temp = [tempIn tempOut];
temp = sortrows(temp, 1);

l = temp(:,1);
%l = log(temp(:,1));

for i = 1:5
  X(i) = (temp(i*200-150,1) + temp(i*200-149,1))/2;
  PR(i) = length(find(temp(i*200-199:i*200, 2) <= -30))/200*100;
  SD(i) = length(find(temp(i*200-199:i*200, 2) <= 20))/200*100;
end
X(6) = (temp(1098,1) + temp(1099,1))/2;
PR(6) = length(find(temp(1000:end, 2) <= -30))/200*100;
SD(6) = length(find(temp(1000:end, 2) <= 20))/200*100;

subplot(3,3,4)
hold on

ylim([0,100])
xlim([min(X),max(X)])
patch([X max(X) min(X)], [SD 100 100], [.75 0.1 .4], 'EdgeColor', 'none')
patch([X fliplr(X)], [PR fliplr(SD)], [.93 0.69 .13], 'EdgeColor', 'none')
patch([min(X) X max(X)], [0 PR 0], [0 0.45 .74], 'EdgeColor', 'none')
alpha(0.6)

hXLabel = xlabel('Initial tumor diameter (median)');
hYLabel = ylabel('RECIST (%)');

set(gca, 'FontName', 'Helvetica')
set([hXLabel, hYLabel], 'FontName', 'AvantGarde', 'FontSize', 14)
set(gca, 'XMinorTick', 'on', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 2)
hold off

%% Param5
param = 'MDSC_max';
tempIn = params_in.(param).LHS(index);
tempOut = D_T_perc_tri5(:,end);
temp = [tempIn tempOut];
temp = sortrows(temp, 1);

l = temp(:,1);
%l = log(temp(:,1));

for i = 1:5
  X(i) = (temp(i*200-150,1) + temp(i*200-149,1))/2;
  PR(i) = length(find(temp(i*200-199:i*200, 2) <= -30))/200*100;
  SD(i) = length(find(temp(i*200-199:i*200, 2) <= 20))/200*100;
end
X(6) = (temp(1098,1) + temp(1099,1))/2;
PR(6) = length(find(temp(1000:end, 2) <= -30))/200*100;
SD(6) = length(find(temp(1000:end, 2) <= 20))/200*100;

subplot(3,3,5)
hold on

ylim([0,100])
xlim([min(X),max(X)])
patch([X max(X) min(X)], [SD 100 100], [.75 0.1 .4], 'EdgeColor', 'none')
patch([X fliplr(X)], [PR fliplr(SD)], [.93 0.69 .13], 'EdgeColor', 'none')
patch([min(X) X max(X)], [0 PR 0], [0 0.45 .74], 'EdgeColor', 'none')
alpha(0.6)

hXLabel = xlabel('Steady-state MDSC density (median)');
hYLabel = ylabel('RECIST (%)');

set(gca, 'FontName', 'Helvetica')
set([hXLabel, hYLabel], 'FontName', 'AvantGarde', 'FontSize', 14)
set(gca, 'XMinorTick', 'on', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 2)
hold off

%% Param6
param = 'C1_PDL1_total';
tempIn = params_in.(param).LHS(index);
tempOut = D_T_perc_tri5(:,end);
temp = [tempIn tempOut];
temp = sortrows(temp, 1);

l = temp(:,1);
%l = log(temp(:,1));

for i = 1:5
  X(i) = (temp(i*200-150,1) + temp(i*200-149,1))/2;
  PR(i) = length(find(temp(i*200-199:i*200, 2) <= -30))/200*100;
  SD(i) = length(find(temp(i*200-199:i*200, 2) <= 20))/200*100;
end
X(6) = (temp(1098,1) + temp(1099,1))/2;
PR(6) = length(find(temp(1000:end, 2) <= -30))/200*100;
SD(6) = length(find(temp(1000:end, 2) <= 20))/200*100;

subplot(3,3,6)
hold on

ylim([0,100])
xlim([min(X) max(X)])
patch([X max(X) min(X)], [SD 100 100], [.75 0.1 .4], 'EdgeColor', 'none')
patch([X fliplr(X)], [PR fliplr(SD)], [.93 0.69 .13], 'EdgeColor', 'none')
patch([min(X) X max(X)], [0 PR 0], [0 0.45 .74], 'EdgeColor', 'none')
alpha(0.6)

xticks([5e4 1e5 3e5 1e6])
hXLabel = xlabel('PD-L1 molecules on cancer cell (median)');
hYLabel = ylabel('RECIST (%)');

set(gca, 'FontName', 'Helvetica')
set([hXLabel, hYLabel], 'FontName', 'AvantGarde', 'FontSize', 14)
set(gca, 'XScale', 'log')
set(gca, 'XMinorTick', 'on', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 2)
hold off
%% Param7
param = 'C1_PDL2_total';
tempIn = params_in.(param).LHS(index);
tempOut = D_T_perc_tri5(:,end);
temp = [tempIn tempOut];
temp = sortrows(temp, 1);

l = temp(:,1);
%l = log(temp(:,1));

for i = 1:5
  X(i) = (temp(i*200-150,1) + temp(i*200-149,1))/2;
  PR(i) = length(find(temp(i*200-199:i*200, 2) <= -30))/200*100;
  SD(i) = length(find(temp(i*200-199:i*200, 2) <= 20))/200*100;
end
X(6) = (temp(1098,1) + temp(1099,1))/2;
PR(6) = length(find(temp(1000:end, 2) <= -30))/200*100;
SD(6) = length(find(temp(1000:end, 2) <= 20))/200*100;

subplot(3,3,7)
hold on

ylim([0,100])
xlim([min(X),max(X)])
patch([X max(X) min(X)], [SD 100 100], [.75 0.1 .4], 'EdgeColor', 'none')
patch([X fliplr(X)], [PR fliplr(SD)], [.93 0.69 .13], 'EdgeColor', 'none')
patch([min(X) X max(X)], [0 PR 0], [0 0.45 .74], 'EdgeColor', 'none')
alpha(0.6)

xticks([2e3 5e3 1e4 3e4])
hXLabel = xlabel('PD-L2 molecules on cancer cell (median)');
hYLabel = ylabel('RECIST (%)');

set(gca, 'FontName', 'Helvetica')
set([hXLabel, hYLabel], 'FontName', 'AvantGarde', 'FontSize', 14)
set(gca, 'XScale', 'log')
set(gca, 'XMinorTick', 'on', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 2)
hold off


%% Param8
param = 'IC50_ArgI_CTL';
tempIn = params_in.(param).LHS(index);
tempOut = D_T_perc_tri5(:,end);
temp = [tempIn tempOut];
temp = sortrows(temp, 1);

l = temp(:,1);
%l = log(temp(:,1));

for i = 1:5
  X(i) = (temp(i*200-150,1) + temp(i*200-149,1))/2;
  PR(i) = length(find(temp(i*200-199:i*200, 2) <= -30))/200*100;
  SD(i) = length(find(temp(i*200-199:i*200, 2) <= 20))/200*100;
end
X(6) = (temp(1098,1) + temp(1099,1))/2;
PR(6) = length(find(temp(1000:end, 2) <= -30))/200*100;
SD(6) = length(find(temp(1000:end, 2) <= 20))/200*100;

subplot(3,3,8)
hold on

ylim([0,100])
xlim([min(X),max(X)])
patch([X max(X) min(X)], [SD 100 100], [.75 0.1 .4], 'EdgeColor', 'none')
patch([X fliplr(X)], [PR fliplr(SD)], [.93 0.69 .13], 'EdgeColor', 'none')
patch([min(X) X max(X)], [0 PR 0], [0 0.45 .74], 'EdgeColor', 'none')
alpha(0.6)

xticks([8 10 20 50 100 200 400])
hXLabel = xlabel('IC_{50} of Arg-I on Teff inhibition (median)');
hYLabel = ylabel('RECIST (%)');

set(gca, 'FontName', 'Helvetica')
set([hXLabel, hYLabel], 'FontName', 'AvantGarde', 'FontSize', 14)
set(gca, 'XScale', 'log')
set(gca, 'XMinorTick', 'on', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 2)
hold off


%% Param9
param = 'k_T1';
tempIn = params_in.(param).LHS(index);
tempOut = D_T_perc_tri5(:,end);
temp = [tempIn tempOut];
temp = sortrows(temp, 1);

l = temp(:,1);
%l = log(temp(:,1));

for i = 1:5
  X(i) = (temp(i*200-150,1) + temp(i*200-149,1))/2;
  PR(i) = length(find(temp(i*200-199:i*200, 2) <= -30))/200*100;
  SD(i) = length(find(temp(i*200-199:i*200, 2) <= 20))/200*100;
end
X(6) = (temp(1098,1) + temp(1099,1))/2;
PR(6) = length(find(temp(1000:end, 2) <= -30))/200*100;
SD(6) = length(find(temp(1000:end, 2) <= 20))/200*100;

subplot(3,3,9)
hold on

ylim([0,100])
xlim([min(X),max(X)])
patch([X max(X) min(X)], [SD 100 100], [.75 0.1 .4], 'EdgeColor', 'none')
patch([X fliplr(X)], [PR fliplr(SD)], [.93 0.69 .13], 'EdgeColor', 'none')
patch([min(X) X max(X)], [0 PR 0], [0 0.45 .74], 'EdgeColor', 'none')
alpha(0.6)

xticks([0.06 0.1 .2 0.3 0.4])
hXLabel = xlabel('T cell exhaustion rate (median)');
hYLabel = ylabel('RECIST (%)');

set(gca, 'FontName', 'Helvetica')
set([hXLabel, hYLabel], 'FontName', 'AvantGarde', 'FontSize', 14)
set(gca, 'XScale', 'log')
set(gca, 'XMinorTick', 'on', ...
    'XColor', [.3 .3 .3], 'YColor', [.3 .3 .3], ...
    'LineWidth', 2)
hold off
