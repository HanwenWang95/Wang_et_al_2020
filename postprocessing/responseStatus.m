% Function to add RECIST and response status to the postprocessed parameters
%
% Inputs: simDataPSA      -- Object containing the simbiology model outputs
%                            for all batch simulations
%         simDataPSApost  -- Object containing the postprocessed simbiology
%                           model outputs for all batch simulations
%         params_outPlaus -- Object containing organized outputs
%
% Outputs: simDataPSAout  -- Updated Object containing organized outputs
%                            with response status and RECIST added
%
% Created: Feb 27, 2019 (Mohammad Jafarnejad)
% Last Modified: Oct 3, 2019 (HW)

function params_outUpdate = responseStatus(simDataPSA,simDataPSApost,params_out)

n_PSA = length(params_out.patient);
params_outUpdate = params_out;

% find the index of postprocessed percent change in tumor size
k = find(strcmp(simDataPSApost(params_out.iPatient(1)).simData.DataNames, 'D_T_perc' ));
for j = 1:n_PSA
    % see if the initial tumor diameter has reached
    if (params_out.patient(j)==1)
        % Find the final perentage change in the diameter
        D_T_perc = simDataPSApost(j).simData.Data(end,k);
        % Add RECIST status of the patient
        if (D_T_perc < (-30))
            params_outUpdate.RECIST(j,1) = {'CR/PR'};
        elseif (D_T_perc > (20))
            params_outUpdate.RECIST(j,1) = {'PD'};
        else
            params_outUpdate.RECIST(j,1) = {'SD'};
        end
        % Add Response status
        if (D_T_perc < 0)
            params_outUpdate.Response(j,1) = {'Responder'};
        else
            params_outUpdate.Response(j,1) = {'Non-responder'};
        end
        % If the patient progressed add time of the event for Kaplan-Meier plots (time to progression)
        D_T_perc_max = max(simDataPSApost(j).simData.Data(:,k));
        if (D_T_perc_max > (20))
            idx = find((simDataPSApost(j).simData.Data(:,k)-20)>0,1);
            params_outUpdate.tPFS(j,1) = simDataPSA(params_out.iPatient(1)).simData.time(idx);
        else
            params_outUpdate.tPFS(j,1) = simDataPSA(params_out.iPatient(1)).simData.time(end);
        end
        % Time to response
        D_T_perc_min = min(simDataPSApost(j).simData.Data(:,k));
        if (D_T_perc_min < (-30))
            idx2 = find((simDataPSApost(j).simData.Data(:,k)+30)<0,1);
            params_outUpdate.TTR(j,1) = simDataPSA(params_out.iPatient(1)).simData.time(idx2);
            if (D_T_perc_max > (20) && idx > idx2)
                params_outUpdate.DOR(j,1) = simDataPSA(params_out.iPatient(1)).simData.time(idx) - simDataPSA(params_out.iPatient(1)).simData.time(idx2);
            else
                params_outUpdate.DOR(j,1) = 0;
            end
        else
            params_outUpdate.TTR(j,1) = simDataPSA(params_out.iPatient(1)).simData.time(end);
        end
    else
        params_outUpdate.RECIST(j,1)   = {'NP'};
        params_outUpdate.Response(j,1) = {'Non-patient'};
    end
end

%
