% Get Model Parameters
setup_model;

% Setup Parameter Range
percentage = 5;

% Parameter Loop
k = 1;
for i = 1:length(model.Parameters)
    if (model.Parameters(i).ConstantValue)
        if ~((model.Parameters(i).Name(1)=='H')||(model.Parameters(i).Name(1)=='a')||...
              strcmp(model.Parameters(i).Name,'m')||strcmp(model.Parameters(i).Name,'k')||...
              strcmp(model.Parameters(i).Name,'cell')||strcmp(model.Parameters(i).Name,'day'))
          
            Name = model.Parameters(i).Name;
            UpperBound = model.Parameters(i).Value *(100+percentage)/100;
            LowerBound = model.Parameters(i).Value *(100-percentage)/100;
            
            % Write Info to File
            disp(['printing parameter ' num2str(k) ': ' Name]);
            k = k+1;
            disp(model.Parameters(i).Value);
            % Comment
%             fprintf('%% \n');
%             fprintf('params.names = [params.names; ''%s''];\n',Name);
%             fprintf('params.%s.UpperBound = %s;\n',Name,UpperBound);
%             fprintf('params.%s.LowerBound = %s;\n',Name,LowerBound);
%             fprintf('params.%s.Sampling = ''uniform'';\n',Name);
%             fprintf('params.%s.ScreenName = '' '';\n',Name);
%             fprintf('\n');
        end
    end
end