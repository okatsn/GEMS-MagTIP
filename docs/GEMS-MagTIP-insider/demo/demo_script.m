%% Convert Raw data to standard type
% Load original data and save them as matfiles of the standard format

conv_gemsdata(dir_gems_raw, dir_data, dir_catalog,'FilterByDatetime',datetime(2020,1,1)); % Convert raw GE data of timestamps after 2020-1-1 to standard format. 
% Assign 'FilterByDatetime' to save time when standard geomagnetic data out of the specified date-time range already exist. 
% Discard 'FilterByDatetime' to convert everything in the raw-data directory.
conv_geomagdata(dir_mag_raw, dir_data,'FilterByDatetime',datetime(2020,1,1)); % The same as above but for the conversion of GM data.

%% Calculate Statistic Index
statind_parfor(dir_data,dir_stat, ... % Load data in dir_data, save index in dir_stat
    'Preprocess',{'ULF_A','ULF_B','BP_40','BP_35'}, ... % with 4 kinds of filtering
    'SavePreprocessedData',false, ... % without saving filtered timeseries
    'StatName', {'S', 'K', 'FI', 'SE'},  ... % the variable name for 'StatFunction'.
    'StatFunction', {@skewness, @kurtosis, @fisherinformation, @shannonentropy}, ...
    'FilterByDatetime',[datetime(2011,1,1), datetime(2022,12,31)]); 
% Assign 'FilterByDatetime' to calculate statistical indices only between 2011-1-1 and 2022-12-31. 
% Noted that standard format GE/GM data have to be available in this range, otherwise you will get NaN if data is missing (or not converted) in `dir_data`.


%% Data overview
% An overview of data avaliability/deficiency according to the results in dir_stat 
plot_dataoverview(dir_stat, dir_catalog);

%% Calculate Anomaly Indices
anomalyind(dir_stat,dir_tsAIN);

%% Training
molscore_parfor(dir_tsAIN,dir_catalog,dir_molchan,... 
    'TrainingPhase', {calyears(3),datetime(2022,4,1);... % Use up to 3-years data before 2022-4-1 for model training.
                      calyears(5),datetime(2022,4,1);... % Use up to 5-years data before 2022-4-1 for model training.
                      calyears(7),datetime(2022,4,1);... % Use up to 7-years data before 2022-4-1 for model training.
                      calyears(9),datetime(2022,4,1)},...% Use up to 9-years data before 2022-4-1 for model training.
    'modparam',{'Test', 5000}); % Remember to disable 'Test' in a real run.

%% Forecast and test
molscore3_parfor(dir_tsAIN,dir_molchan,dir_catalog,dir_jointstation,...
    'OverwriteFile',true, ...
    'ForecastingPhase', repmat([datetime(2022,4,2), datetime(2022,9,27)], 4,1));
    % Manually assign forecasting phases. Typically the size of 'ForecastingPhase' should align with the size of 'TrainingPhase'.