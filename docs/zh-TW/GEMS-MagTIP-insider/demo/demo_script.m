%% GEMS-MagTIP 2024
% Follow the instruction to complete the settings. They are written in startup.m 
%% Convert Raw data to standard type
% Load original data and save them as matfiles of the standard format

conv_gemsdata(dir_data0gems, dir_data, dir_catalog,'FilterByDatetime',datetime(2020,1,1)); % Convert raw GE data of timestamps after 2020 to standard format. Use FilterByDatetime when standard geomagnetic data out of the specified date-time range already exist.
conv_geomagdata(dir_data0mag, dir_data,'FilterByDatetime',datetime(2020,1,1)); % The same as above but for the conversion of GM data.

%% Calculate Statistic Index
statind_parfor(dir_data,dir_stat, ... % Load data in dir_data, save index in dir_stat
    'Preprocess',{'ULF_A','ULF_B','BP_40','BP_35'}, ... % with 4 kinds of filtering
    'SavePreprocessedData',false, ... % without saving filtered timeseries
    'StatName', {'S', 'K', 'FI', 'SE'},  ...
    'StatFunction', {@skewness, @kurtosis, @fisherinformation, @shannonentropy}, ...
    'FilterByDatetime',[datetime(2011,1,1), datetime(2022,12,31)]); % This means only statistical indices between 2011 and the end of 2022 will be calculated. Noted that standard format GE/GM data have to be available in this range, otherwise you will get NaN if data is missing (or not converted) in `dir_data`.


%% Data overview
% An overview of data avaliability/deficiency according to the results in dir_stat 
plot_dataoverview(dir_stat, dir_catalog);

%% Calculate Anomaly Indices
anomalyind(dir_stat,dir_tsAIN);

%% Training
molscore_parfor(dir_tsAIN,dir_catalog,dir_molchan,... 
    'TrainingPhase', {calyears(3),datetime(2022,4,1);...
                      calyears(5),datetime(2022,4,1);...
                      calyears(7),datetime(2022,4,1);...
                      calyears(9),datetime(2022,4,1)},...
    'modparam',{'Test', 5000}); % Remember to disable 'Test' in a real run.

%% Forecast and test
molscore3_parfor(dir_tsAIN,dir_molchan,dir_catalog,dir_jointstation,...
    'OverwriteFile',true, ...
    'ForecastingPhase', repmat([datetime(2022,4,2), datetime(2022,9,27)], 4,1));
    % Manually assign forecasting phases.