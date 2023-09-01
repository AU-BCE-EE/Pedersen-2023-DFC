% bLS and Dynamic flux chambers
% December 2022
% Second trial
% Jesper Kamp
% East = Injection
% West = Trailing hose

cd 'C:\Users\AU323818\Dropbox\Uni\Dynamic flux chambers\DFC bLS #2'

clear

tic 

LOAD_SWITCH = 0; % Read in data from dat-files: 0 = NO, 1 = YES 
PLOT_SWITCH_CONC = 0; % Plot: 0 = NO, 1 = YES raw, 2 = YES 1 min
PLOT_SWITCH = 0; % Plot: 0 = NO, 1 = YES raw, 2 = YES 1 min
WINDOFFSET = 0; % Check WD offset
SAVE_FIG = 0;


% SAVE_FIG = 0;

PATH               = 'C:\Users\AU323818\Dropbox\Uni\Dynamic flux chambers\DFC bLS #2\bLS data';
PATH_raw_plot_east = 'C:\Users\AU323818\Dropbox\Uni\Dynamic flux chambers\DFC bLS #2\CRDS east';
PATH_raw_plot_west = 'C:\Users\AU323818\Dropbox\Uni\Dynamic flux chambers\DFC bLS #2\CRDS west';
PATH_raw_bg        = 'C:\Users\AU323818\Dropbox\Uni\Dynamic flux chambers\DFC bLS #2\CRDS BG';
foldout            = 'C:\Users\AU323818\Dropbox\Uni\Dynamic flux chambers\DFC bLS #2\Figures';


if LOAD_SWITCH == 1
    %% Load CRDS - CRDS # G2509 EAST
    CRDS_plot_east = load_G2509_func(PATH_raw_plot_east);

    % Adjust time and apply calibration to concentration - and change all concentrations to ug/m3
    % TIME CORRECTION for tank CRDS: 0 hour 59 min 4 sec
    % datetime('10:43:32',"Format","HH:mm:ss")-datetime('09:44:28',"Format","HH:mm:ss")

    Time_plot = CRDS_plot_east.DATE + timeofday(CRDS_plot_east.TIME) + hours(0) + minutes(59) + seconds(4);
    Time_plot.Format = 'dd.MM.uuuu HH:mm:ss:SSS';
    CRDS_plot_east.Time = Time_plot;


    clear Time_plot

    % CALIBRATION APPLIED and concentration changed to ug/m3

    CRDS_plot_east.NH3_ug = (CRDS_plot_east.NH3 - 0.0) ./ 1.00 *0.0409*17.031;
    CRDS_plot_east.CH4_ug = (CRDS_plot_east.CH4_dry - 0.0) ./ 1.00 *40.9*16.04;
    CRDS_plot_east.CO2_ug = (CRDS_plot_east.CO2_dry - 0.0) ./ 1.00 *40.9*44.01;
    CRDS_plot_east.N2O_ug = (CRDS_plot_east.N2O - 0.0) ./ 1.00 *40.9*44.013;

    TT_CRDS_plot_east = timetable(CRDS_plot_east.Time, CRDS_plot_east.NH3_ug, CRDS_plot_east.CH4_ug, CRDS_plot_east.CO2_ug, CRDS_plot_east.N2O_ug, 'VariableNames',{'NH3', 'CH4', 'CO2', 'N2O'});

    % Round intervals to full half hours for synchronization
    % 30 min intervals
    vec = datevec(TT_CRDS_plot_east.Time );
    v5  = vec(:,5)+vec(:,6)/60;
    vec(:,5) = round(v5/15)*15;
    vec(:,6) = 0;

    rt = [min(datetime(vec)) : minutes(30) : (max(datetime(vec))+minutes(30))];
    TT_CRDS_plot_east = retime(TT_CRDS_plot_east, rt, 'mean');

    save('TT_CRDS_plot_east_07_12_2022.mat', 'TT_CRDS_plot_east'); % Remember to change file
    
    %% Load CRDS - CRDS # G2509 WEST
    CRDS_plot_west = load_G2509_func(PATH_raw_plot_west);

    % Adjust time and apply calibration to concentration - and change all concentrations to ug/m3
    % TIME CORRECTION for tank CRDS: - 0 hour 0 min 59 sec
    % datetime('10:40:50',"Format","HH:mm:ss")-datetime('10:41:49',"Format","HH:mm:ss")

    Time_plot = CRDS_plot_west.DATE + timeofday(CRDS_plot_west.TIME) + hours(0) + minutes(0) - seconds(59);
    Time_plot.Format = 'dd.MM.uuuu HH:mm:ss:SSS';
    CRDS_plot_west.Time = Time_plot;


    clear Time_plot

    % CALIBRATION APPLIED and concentration changed to ug/m3

    CRDS_plot_west.NH3_ug = (CRDS_plot_west.NH3 - 0.0) ./ 1.00 *0.0409*17.031;
    CRDS_plot_west.CH4_ug = (CRDS_plot_west.CH4_dry - 0.0) ./ 1.00 *40.9*16.04;
    CRDS_plot_west.CO2_ug = (CRDS_plot_west.CO2_dry - 0.0) ./ 1.00 *40.9*44.01;
    CRDS_plot_west.N2O_ug = (CRDS_plot_west.N2O - 0.0) ./ 1.00 *40.9*44.013;

    TT_CRDS_plot_west = timetable(CRDS_plot_west.Time, CRDS_plot_west.NH3_ug, CRDS_plot_west.CH4_ug, CRDS_plot_west.CO2_ug, CRDS_plot_west.N2O_ug, 'VariableNames',{'NH3', 'CH4', 'CO2', 'N2O'});

    % Round intervals to full half hours for synchronization
    % 30 min intervals
    vec = datevec(TT_CRDS_plot_west.Time );
    v5  = vec(:,5)+vec(:,6)/60;
    vec(:,5) = round(v5/15)*15;
    vec(:,6) = 0;

    rt = [min(datetime(vec)) : minutes(30) : (max(datetime(vec))+minutes(30))];
    TT_CRDS_plot_west = retime(TT_CRDS_plot_west, rt, 'mean');

    save('TT_CRDS_plot_west_07_12_2022.mat', 'TT_CRDS_plot_west'); % Remember to change file
    

    %% Load CRDS bLS - CRDS # G2509 #4
    CRDS_bg = load_G2509_func(PATH_raw_bg);


    % Adjust time and apply calibration to concentration - and change all concentrations to ug/m3
    % TIME CORRECTION for BG CRDS: 1 hour 0 min 55 sec
    % datetime('10:46:04',"Format","HH:mm:ss")-datetime('09:45:09',"Format","HH:mm:ss")
    % True - CRDS

    Time_bg = CRDS_bg.DATE + timeofday(CRDS_bg.TIME) + hours(1) + minutes(0) + seconds(55);
    Time_bg.Format = 'dd.MM.uuuu HH:mm:ss:SSS';
    CRDS_bg.Time = Time_bg;


    clear Time_bg

    % CALIBRATION APPLIED and concentration changed to ug/m3

    CRDS_bg.NH3_ug = (CRDS_bg.NH3 - 0.0) ./ 1.00 *0.0409*17.031;
    CRDS_bg.CH4_ug = (CRDS_bg.CH4_dry - 0.0) ./ 1.00 *40.9*16.04;
    CRDS_bg.CO2_ug = (CRDS_bg.CO2_dry - 0.0) ./ 1.00 *40.9*44.01;
    CRDS_bg.N2O_ug = (CRDS_bg.N2O - 0.0) ./ 1.00 *40.9*44.013;

    TT_CRDS_bg = timetable(CRDS_bg.Time, CRDS_bg.NH3_ug, CRDS_bg.CH4_ug, CRDS_bg.CO2_ug, CRDS_bg.N2O_ug, 'VariableNames',{'NH3', 'CH4', 'CO2', 'N2O'});

    % Round intervals to full half hours for synchronization
    % 30 min intervals
    vec = datevec(TT_CRDS_bg.Time );
    v5  = vec(:,5)+vec(:,6)/60;
    vec(:,5) = round(v5/15)*15;
    vec(:,6) = 0;

    rt = [min(datetime(vec)) : minutes(30) : (max(datetime(vec))+minutes(30))];
    TT_CRDS_bg = retime(TT_CRDS_bg, rt, 'mean');

    save('TT_CRDS_bg_06_12_2022.mat', 'TT_CRDS_bg'); % Remember to change file

    %% Load Foulum weather station
    File_FoulumVejr = "C:\Users\AU323818\Dropbox\Uni\Dynamic flux chambers\DFC bLS #2\VejrFoulum_2411_0512.csv";
    TT_VejrFoulum = load_Foulum_Weather_func(File_FoulumVejr);

    save('TT_Foulum_06_12_2022.mat', 'TT_VejrFoulum') % Remember to change file

    %% Load bLS results

    % Set up the Import Options and import the data
    opts = delimitedTextImportOptions("NumVariables", 54);

    opts.DataLines = [2, Inf];
    opts.Delimiter = ";";

    opts.VariableNames = ["rn", "Sensor", "Source", "SensorHeight", "SourceArea", "CE", "CE_se", "CE_lo", "CE_hi", "uCE", "uCE_se", "uCE_lo", "uCE_hi", "vCE", "vCE_se", "vCE_lo", "vCE_hi", "wCE", "wCE_se", "wCE_lo", "wCE_hi", "N_TD", "TD_Time_avg", "TD_Time_max", "Max_Dist", "UCE", "Ustar", "L", "Zo", "sUu", "sVu", "sWu", "z_sWu", "WD", "d", "N0", "MaxFetch", "st", "et", "Sonic_raw", "Time", "SH", "UST", "sigW", "sigU", "sigV", "WS", "airT", "Pair", "kv", "A", "alpha", "bw", "C0"];
    opts.VariableTypes = ["double", "categorical", "categorical", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "datetime", "datetime", "categorical", "datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";

    opts = setvaropts(opts, ["Sensor", "Source", "Sonic_raw"], "EmptyFieldRule", "auto");
    opts = setvaropts(opts, "st", "InputFormat", "yyyy-MM-dd HH:mm:ss");
    opts = setvaropts(opts, "et", "InputFormat", "yyyy-MM-dd HH:mm:ss");
    opts = setvaropts(opts, "Time", "InputFormat", "dd-MMM-yyyy HH:mm:ss");

    T_results = readtable("C:\Users\AU323818\Dropbox\Uni\Dynamic flux chambers\DFC bLS #2\RSaves\DFC_2_results_1E5.csv", opts);

    TT_bLS_out = table2timetable(T_results,"RowTimes","st");

    clear opts T_results

    save('TT_bLS_out_28_11_2022.mat', 'TT_bLS_out')

else
    load('TT_CRDS_plot_west_07_12_2022.mat')
    load('TT_CRDS_plot_east_07_12_2022.mat')
    load('TT_CRDS_bg_06_12_2022.mat')
    load('TT_Foulum_06_12_2022.mat')
    load('TT_bLS_out_28_11_2022.mat')
end

%% Combine CRDS and calculate difference
    TT_CRDS = synchronize(TT_CRDS_plot_east, TT_CRDS_plot_west);
    TT_CRDS.Properties.VariableNames = {'NH3_east', 'CH4_east', 'CO2_east', 'N2O_east', 'NH3_west', 'CH4_west', 'CO2_west', 'N2O_west'};

    TT_CRDS = synchronize(TT_CRDS, TT_CRDS_bg);
    TT_CRDS.Properties.VariableNames = {'NH3_east', 'CH4_east', 'CO2_east', 'N2O_east', 'NH3_west', 'CH4_west', 'CO2_west', 'N2O_west', 'NH3_bg', 'CH4_bg', 'CO2_bg', 'N2O_bg'};

    % NH3 correction:
    % Injection     mean concentration: 1.9196 ug/m3 --> conc corr. = conc - 1.0956 (east)
    % Trailing hose mean concentration: 0.2731 ug/m3 --> conc corr. = conc + 0.5508 (west)
    % Background    mean concentration: 0.8239 ug/m3 --> conc corr. = conc 

    TT_CRDS.dNH3_east = (TT_CRDS.NH3_east - 1.0956) - TT_CRDS.NH3_bg;
    TT_CRDS.dCH4_east = TT_CRDS.CH4_east - TT_CRDS.CH4_bg;
    TT_CRDS.dCO2_east = TT_CRDS.CO2_east - TT_CRDS.CO2_bg;
    TT_CRDS.dN2O_east = TT_CRDS.N2O_east - TT_CRDS.N2O_bg;

    TT_CRDS.dNH3_west = (TT_CRDS.NH3_west + 0.5508) - TT_CRDS.NH3_bg;
    TT_CRDS.dCH4_west = TT_CRDS.CH4_west - TT_CRDS.CH4_bg;
    TT_CRDS.dCO2_west = TT_CRDS.CO2_west - TT_CRDS.CO2_bg;
    TT_CRDS.dN2O_west = TT_CRDS.N2O_west - TT_CRDS.N2O_bg;

%%  FLAGS:
    FLAG_UST005 = TT_bLS_out.UST > 0.05;
    FLAG_L2 = abs(TT_bLS_out.L) > 2;
    FLAG_sigU = TT_bLS_out.sUu < 4.5;
    FLAG_sigV = TT_bLS_out.sVu < 4.5;
    FLAG_C0 = TT_bLS_out.C0 < 10;
    FLAG_BUH = and(and(and(and(FLAG_UST005, FLAG_L2),FLAG_sigU), FLAG_sigV),FLAG_C0); % UST > 0.05, L2, sigU < 4.5, sigV < 4.5, C0 < 10 - from Bühler et al., 2021

    disp('Filtered data: Removed (%)')
    %     disp((height(TT)-[sum(FLAG_UST005) sum(FLAG_L2) sum(FLAG_sigU) sum(FLAG_sigV) sum(FLAG_C0)])/height(TT)*100)
    disp((height(TT_bLS_out)-sum(FLAG_BUH))/height(TT_bLS_out)*100)

    TT_bLS_out(~FLAG_BUH(:,1),:) = [];
    TT_bLS_out.Time = [];
    TT_bLS_out.Properties.DimensionNames{1} = 'Time'; 

%% bLS results divided by sensor CRDS_w and CRDS_e
    % WEST
    % Wind direction from 20 to 90 deg must be removed for the west plot
    TT_bLS_out_w = TT_bLS_out(TT_bLS_out.Sensor == 'CRDS_w',:);
    TT_bLS_out_w(TT_bLS_out_w.WD > 20 & TT_bLS_out_w.WD < 90, :) = [];
    % Removing in this wind range removes all intervals with subtantial
    % contribution from the east plot to the west plot. N_TD in the
    % remaning intervals are less than 0.5% of total trajectories.
    % Therefore, inputs from east source is removed.
    TT_bLS_out_w(TT_bLS_out_w.Source == 'Plot_east',:) = [];

    % Intervals with less than 10% of touchdown from the source is removed:
    TT_bLS_out_w(TT_bLS_out_w.N_TD < 1E5/10, :) = [];


    % EAST
    % Wind direction from 210 to 270 deg must be removed for the east plot
    TT_bLS_out_e = TT_bLS_out(TT_bLS_out.Sensor == 'CRDS_e',:);
    TT_bLS_out_e(TT_bLS_out_e.WD > 210 & TT_bLS_out_e.WD < 270, :) = [];
    % Removing in this wind range removes all intervals with subtantial
    % contribution from the west plot to the east plot. N_TD in the
    % remaning intervals are less than 0.7% of total trajectories.
    % Therefore, inputs from west source is removed.
    TT_bLS_out_e(TT_bLS_out_e.Source == 'Plot_west',:) = [];

    % Intervals with less than 10% of touchdown from the source is removed:
    TT_bLS_out_e(TT_bLS_out_e.N_TD < 1E5/10, :) = [];


    % Synchronize to obtain emissions
    TT_e = synchronize(TT_bLS_out_e(4:end,:), TT_CRDS);
    TT_w = synchronize(TT_bLS_out_w(4:end,:), TT_CRDS);

    TT_e(1:21,:) = [];
    TT_w(1:21,:) = [];

%%  Emissions and cumulative loss
    % EAST
    Time_Lim7_e = [datetime(2022,11,24,11,00,0), datetime(2022,12,1,11,00,0)];

    TAN_slurry_e = 1; % CHANGE!
    %     TAN_slurry_e = 35.0 * 1.72E5 * 17.031 / 14.0067; % Basis for TAN er N mens flux er NH3

    TT_e.emis_NH3 = TT_e.dNH3_east ./ TT_e.CE;
    TT_e.emis_CH4 = TT_e.dCH4_east ./ TT_e.CE;
    TT_e.emis_N2O = TT_e.dN2O_east ./ TT_e.CE;

    TT_e.emis_NH3_gap = TT_e.emis_NH3;
    TT_e.emis_NH3_gap = fillmissing(TT_e.emis_NH3_gap,'linear');

    TT_e.emis_CH4_gap = TT_e.emis_CH4;
    TT_e.emis_CH4_gap = fillmissing(TT_e.emis_CH4_gap,'linear');

    TT_e.emis_N2O_gap = TT_e.emis_N2O;
    TT_e.emis_N2O_gap = fillmissing(TT_e.emis_N2O_gap,'linear');

    % Cumulative emissions with gap filling limited to 168 hours = 7 days
    TT_e.cum_NH3_gN = NaN(height(TT_e),1);
    TT_e.cum_NH3_gN(TT_e.Time >= Time_Lim7_e(1) & TT_e.Time < Time_Lim7_e(2)) = cumsum(TT_e.emis_NH3_gap(TT_e.Time >= Time_Lim7_e(1) & TT_e.Time < Time_Lim7_e(2)) *1800* 14.0067 / 17.031 /10^6, 'omitnan');
    
    TT_e.cum_CH4_gCH4 = NaN(height(TT_e),1);
    TT_e.cum_CH4_gCH4(TT_e.Time >= Time_Lim7_e(1) & TT_e.Time < Time_Lim7_e(2)) = cumsum(TT_e.emis_CH4_gap(TT_e.Time >= Time_Lim7_e(1) & TT_e.Time < Time_Lim7_e(2)) *1800/10^6, 'omitnan');
    
    TT_e.cum_N2O_mgN = NaN(height(TT_e),1);
    TT_e.cum_N2O_mgN(TT_e.Time >= Time_Lim7_e(1) & TT_e.Time < Time_Lim7_e(2)) = cumsum(TT_e.emis_N2O_gap(TT_e.Time >= Time_Lim7_e(1) & TT_e.Time < Time_Lim7_e(2)) *1800 * 14.0067 / 44.013 /10^3, 'omitnan');


    TAN_loss_e = cumsum(TT_e.emis_NH3_gap(TT_e.Time >= Time_Lim7_e(1) & TT_e.Time < Time_Lim7_e(2))*1800/(TAN_slurry_e)* 14.0067 / 17.031 /10^6, 'omitnan');
    Loss_CH4_e = cumsum(TT_e.emis_CH4_gap(TT_e.Time >= Time_Lim7_e(1) & TT_e.Time < Time_Lim7_e(2))*1800/10^6, 'omitnan');
    TAN_loss_N2O_e = cumsum(TT_e.emis_NH3_gap(TT_e.Time >= Time_Lim7_e(1) & TT_e.Time < Time_Lim7_e(2))*1800/(TAN_slurry_e)* 14.0067 / 44.013 /10^6, 'omitnan');

    disp('Loss of NH3 in g N /m2')
    disp(max(TT_e.cum_NH3_gN))

    disp('Loss of CH4 in g CH4 /m2')
    disp(max(TT_e.cum_CH4_gCH4))

    disp('Loss of N2O in g N /m2')
    disp(max(TT_e.cum_N2O_mgN))

    % WEST
    Time_Lim7_w = [datetime(2022,11,24,12,00,0), datetime(2022,12,1,12,00,0)];

    TAN_slurry_w = 1; % CHANGE!
    %     TAN_slurry_w = 35.0 * 1.72E5 * 17.031 / 14.0067; % Basis for TAN er N mens flux er NH3

    TT_w.emis_NH3 = (TT_w.dNH3_west+0.55) ./ TT_w.CE;
    TT_w.emis_CH4 = TT_w.dCH4_west ./ TT_w.CE;
    TT_w.emis_N2O = TT_w.dN2O_west ./ TT_w.CE;

    TT_w.emis_NH3_gap = TT_w.emis_NH3;
    TT_w.emis_NH3_gap = fillmissing(TT_w.emis_NH3_gap,'linear');

    TT_w.emis_CH4_gap = TT_w.emis_CH4;
    TT_w.emis_CH4_gap = fillmissing(TT_w.emis_CH4_gap,'linear');

    TT_w.emis_N2O_gap = TT_w.emis_N2O;
    TT_w.emis_N2O_gap = fillmissing(TT_w.emis_N2O_gap,'linear');

    % Cumulative emissions with gap filling limited to 168 hours = 7 days
    TT_w.cum_NH3_gN = NaN(height(TT_w),1);
    TT_w.cum_NH3_gN(TT_w.Time >= Time_Lim7_w(1) & TT_w.Time < Time_Lim7_w(2)) = cumsum(TT_w.emis_NH3_gap(TT_w.Time >= Time_Lim7_w(1) & TT_w.Time < Time_Lim7_w(2)) *1800* 14.0067 / 17.031 /10^6, 'omitnan');
    
    TT_w.cum_CH4_gCH4 = NaN(height(TT_w),1);
    TT_w.cum_CH4_gCH4(TT_w.Time >= Time_Lim7_w(1) & TT_w.Time < Time_Lim7_w(2)) = cumsum(TT_w.emis_CH4_gap(TT_w.Time >= Time_Lim7_w(1) & TT_w.Time < Time_Lim7_w(2)) *1800/10^6, 'omitnan');
    
    TT_w.cum_N2O_mgN = NaN(height(TT_w),1);
    TT_w.cum_N2O_mgN(TT_w.Time >= Time_Lim7_w(1) & TT_w.Time < Time_Lim7_w(2)) = cumsum(TT_w.emis_N2O_gap(TT_w.Time >= Time_Lim7_w(1) & TT_w.Time < Time_Lim7_w(2)) *1800 * 14.0067 / 44.013 /10^3, 'omitnan');


    TAN_loss_w = cumsum(TT_w.emis_NH3_gap(TT_w.Time >= Time_Lim7_w(1) & TT_w.Time < Time_Lim7_w(2))*1800/(TAN_slurry_w)* 14.0067 / 17.031 /10^6, 'omitnan');
    Loss_CH4_w = cumsum(TT_w.emis_CH4_gap(TT_w.Time >= Time_Lim7_w(1) & TT_w.Time < Time_Lim7_w(2))*1800/10^6, 'omitnan');
    TAN_loss_N2O_w = cumsum(TT_w.emis_NH3_gap(TT_w.Time >= Time_Lim7_w(1) & TT_w.Time < Time_Lim7_w(2))*1800/(TAN_slurry_w)* 14.0067 / 44.013 /10^6, 'omitnan');

    disp('Loss of NH3 in g N /m2')
    disp(max(TT_w.cum_NH3_gN))

    disp('Loss of CH4 in g CH4 /m2')
    disp(max(TT_w.cum_CH4_gCH4))

    disp('Loss of N2O in g N /m2')
    disp(max(TT_w.cum_N2O_mgN))

%% Plots
ii = 1;

if PLOT_SWITCH_CONC == 1

    % Before application: 
    % Injection     mean concentration: 1.9196 ug/m3 (+- 0.0627) --> conc corr. = conc - 1.0956
    % Trailing hose mean concentration: 0.2731 ug/m3 (+- 0.0331) --> conc corr. = conc + 0.5508
    % Background    mean concentration: 0.8239 ug/m3 (+- 0.1098) --> conc corr. = conc 
    % TT_CRDS: Only dNH3 is changed according to the correction, see under '%% Combine CRDS and calculate difference' above
    
    diff_bg_e = mean(TT_CRDS.NH3_east(1:20), 'omitnan') - mean(TT_CRDS.NH3_bg(1:20), 'omitnan');
    diff_bg_w = mean(TT_CRDS.NH3_west(1:20), 'omitnan') - mean(TT_CRDS.NH3_bg(1:20), 'omitnan');
    diff_bg_all_e = mean(TT_CRDS.NH3_east, 'omitnan') - mean(TT_CRDS.NH3_bg, 'omitnan');
    diff_bg_all_w = mean(TT_CRDS.NH3_west, 'omitnan') - mean(TT_CRDS.NH3_bg, 'omitnan');

    figure(ii)
    plot(TT_CRDS.Time, TT_CRDS.NH3_east - 1.0956, 'o:', TT_CRDS.Time, TT_CRDS.NH3_west + 0.5508, 'o:', TT_CRDS.Time, TT_CRDS.NH3_bg, 'o:')
    grid minor
    ylabel('NH_3 (\mug m^{-3})')
    legend('Injection', 'Trailing hose', 'Background')
    ii = ii + 1;


end

if PLOT_SWITCH == 1
    figure(ii)
    plot(TT_e.Time, TT_e.emis_NH3, 'o:', TT_w.Time, TT_w.emis_NH3, 'o:')
    grid on
    grid minor
    ylabel('NH_3 (\mug m^{-2} s^{-1})')
    legend('Injection', 'Trailing hose')
    ii = ii + 1;

    figure(ii)
    plot(TT_e.Time, TT_e.emis_NH3, 'o:', TT_w.Time, TT_w.emis_NH3, 'o:')
    hold on
    plot(TT_e.Time, TT_e.emis_NH3_gap, 'x', TT_w.Time, TT_w.emis_NH3_gap, 'x')
    grid on
    grid minor
    ylabel('NH_3 (\mug m^{-2} s^{-1})')
    legend('Injection', 'Trailing hose', 'Gap filled', 'Gap filled')
    ii = ii + 1;

    figure(ii)
    plot(TT_e.Time, TT_e.emis_CH4, 'o:', TT_w.Time, TT_w.emis_CH4, 'o:')
    grid on
    grid minor
    ylabel('CH_4 (\mug m^{-2} s^{-1})')
    legend('Injection', 'Trailing hose')
    ii = ii + 1;

    figure(ii)
    plot(TT_e.Time, TT_e.emis_N2O, 'o:', TT_w.Time, TT_w.emis_N2O, 'o:')
    grid on
    grid minor
    ylabel('N_2O (\mug m^{-2} s^{-1})')
    legend('Injection', 'Trailing hose')
    ii = ii + 1;

    figure(ii)
    plot(TT_e.Time, TT_e.cum_NH3_gN, ':', TT_w.Time, TT_w.cum_NH3_gN, ':')
    grid minor
    ylabel('Loss of TAN (g N)')
    legend('Injection', 'Trailing hose','Location','northwest')
    title('Lost TAN')
    ii = ii + 1;
    

        if SAVE_FIG == 1
        FigFileName = 'TAN_loss';
        fullFileName = fullfile(foldout, FigFileName);
        fig59 = gcf;
        fig59.PaperUnits = 'centimeters';
        fig59.PaperPosition = [0 0 19 19];
        print(fullFileName,'-dpng','-r800')
        end


end



writetimetable(TT_e, [PATH, '\DFC_2_east_results_20_03_2023.txt'], 'Delimiter','tab')
writetimetable(TT_w, [PATH, '\DFC_2_west_results_20_03_2023.txt'], 'Delimiter','tab')

toc


