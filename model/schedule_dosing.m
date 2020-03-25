% Dose Schedule
%
% Generates Donsing Schedule
%
% Inputs: drugName -- drug name or character array of drug names
%         varargin -- Name-Value Pairs
%                     - drugName_dose (mg/kg)
%                     - drugName_schedule [start,interval,repeat]
%                     - patientWeight (kg)
%
%       vaild drugName values: nivolumab, durvalumab, ipilimumab
%
% Outputs: dosing -- SimBiology model object with new antigen module
%
% Created: Feb 19, 2019 (Richard Sov�)
% Last Modified: Oct 3, 2019 (HW)

function dose_schedule = schedule_dosing(drugName,varargin)

% Check if drugName is cell array
if (iscell(drugName))
    N = length(drugName);
else
    N = 1;
    drugName = {drugName};
end

% Optional Inputs
in = inputParser;
% Nivolumab
addParameter(in,'nivolumab_dose',3); % 3 mg/kg every two weeks
addParameter(in,'nivolumab_schedule',[0,14,30]);
% Durvalumab
addParameter(in,'durvalumab_dose',10); % 10 mg/kg every two weeks
addParameter(in,'durvalumab_schedule',[0,14,30]);
% Ipilimumab
addParameter(in,'ipilimumab_dose',1); % 1 mg/kg every three weeks
addParameter(in,'ipilimumab_schedule',[0,21,30]);
% Entinostat
addParameter(in,'entinostat_dose',3); % 3 mg every week
addParameter(in,'entinostat_schedule',[0,7,55]);
% Patient Weight
addParameter(in,'patientWeight',80);
% Parse Inputs
parse(in,varargin{:});
% Nivolumab
dose_nivo = in.Results.nivolumab_dose;
schedule_nivo = in.Results.nivolumab_schedule;
% Durvalumab
dose_durv = in.Results.durvalumab_dose;
schedule_durv = in.Results.durvalumab_schedule;
% Ipilimumab
dose_ipil = in.Results.ipilimumab_dose;
schedule_ipil = in.Results.ipilimumab_schedule;
% Entinostat
dose_ENT = in.Results.entinostat_dose;
schedule_ENT = in.Results.entinostat_schedule;
% Patient Weight
patient_weight = in.Results.patientWeight;

% Nivolumab
MW_nivo = 1.436E8; % milligrams per mole
doseObj_nivo = sbiodose('nivo','Amount',patient_weight*dose_nivo/MW_nivo,'AmountUnits','mole','TargetName','V_C.nivo');
doseObj_nivo.StartTime = schedule_nivo(1);
doseObj_nivo.Interval = schedule_nivo(2);
doseObj_nivo.TimeUnits = 'day';
doseObj_nivo.RepeatCount = schedule_nivo(3);
doseObj_nivo.Active = true;

% Entinostat
MW_ENT = 3.764085e5; % mg/mole
Bio = 0.18; % Fraction of dose through buccal absorption

doseObj_ENT_0 = sbiodose('ENT','Amount',Bio*dose_ENT/MW_ENT,'AmountUnits','mole','TargetName','V_C.ENT_Buccal');
doseObj_ENT_0.StartTime = schedule_ENT(1);
doseObj_ENT_0.Interval = schedule_ENT(2);
doseObj_ENT_0.TimeUnits = 'day';
doseObj_ENT_0.RepeatCount = schedule_ENT(3);
doseObj_ENT_0.Active = true;
doseObj_ENT_0.DurationParameterName = 'durP';

doseObj_ENT_1 = sbiodose('ENT','Amount',(1-Bio)*dose_ENT/MW_ENT,'AmountUnits','mole','TargetName','V_C.Dose2');
doseObj_ENT_1.StartTime = schedule_ENT(1);
doseObj_ENT_1.Interval = schedule_ENT(2);
doseObj_ENT_1.TimeUnits = 'day';
doseObj_ENT_1.RepeatCount = schedule_ENT(3);
doseObj_ENT_1.Active = true;
doseObj_ENT_1.LagParameterName = 'lagP';

% Durvalumab
MW_durv = 1.436E8; % milligrams per mole
doseObj_durv = sbiodose('durv','Amount',patient_weight*dose_durv/MW_durv,'AmountUnits','mole','TargetName','V_C.durv');
doseObj_durv.StartTime = schedule_durv(1);
doseObj_durv.Interval = schedule_durv(2);
doseObj_durv.TimeUnits = 'day';
doseObj_durv.RepeatCount = schedule_durv(3);
doseObj_durv.Active = true;

% Ipilimumab
MW_ipil = 1.486349E8; % milligrams per mole
doseObj_ipil = sbiodose('ipi','Amount',patient_weight*dose_ipil/MW_ipil,'AmountUnits','mole','TargetName','V_C.ipi');
doseObj_ipil.StartTime = schedule_ipil(1);
doseObj_ipil.Interval = schedule_ipil(2);
doseObj_ipil.TimeUnits = 'day';
doseObj_ipil.RepeatCount = schedule_ipil(3);
doseObj_ipil.Active = true;

% Dose Schedule Array
dose_schedule(N) = sbiodose('empty'); % preallocate array
for i = 1:N
    switch drugName{i}
        case 'nivolumab'
            dose_schedule(i) = doseObj_nivo;
        case 'durvalumab'
            dose_schedule(i) = doseObj_durv;
        case 'ipilimumab'
            dose_schedule(i) = doseObj_ipil;
        case 'entinostat'
            dose_schedule(i) = doseObj_ENT_0;
            dose_schedule(i+1) = doseObj_ENT_1;
        otherwise
            error('No match for drug name');
    end
end
