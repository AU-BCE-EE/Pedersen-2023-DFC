% bLS and Dynamic flux chambers
% November 2022
% Jesper Kamp

cd 'C:\Users\AU323818\Dropbox\Uni\Dynamic flux chambers\DFC bLS #1'

clear

tic 

LOAD_SWITCH = 0; % Read in data from dat-files: 0 = NO, 1 = YES 
PLOT_SWITCH_CONC = 0; % Plot: 0 = NO, 1 = YES raw, 2 = YES 1 min
PLOT_SWITCH = 0; % Plot: 0 = NO, 1 = YES raw, 2 = YES 1 min
WINDOFFSET = 0; % Check WD offset


% SAVE_FIG = 0;

PATH          = 'C:\Users\AU323818\Dropbox\Uni\Dynamic flux chambers\DFC bLS #1\bLS data';
PATH_raw_plot = 'C:\Users\AU323818\Dropbox\Uni\Dynamic flux chambers\DFC bLS #1\CRDS plot';
PATH_raw_bg   = 'C:\Users\AU323818\Dropbox\Uni\Dynamic flux chambers\DFC bLS #1\CRDS BG';
foldout       = 'C:\Users\AU323818\Dropbox\Uni\Dynamic flux chambers\DFC bLS #1\Figures';


if LOAD_SWITCH == 1
    %% Load CRDS - CRDS # G2509
    CRDS_plot = load_G2509_func(PATH_raw_plot);

    % Adjust time and apply calibration to concentration - and change all concentrations to ug/m3
    % TIME CORRECTION for tank CRDS: 0 hour 59 min 38 sec
    % datetime('10:55:30',"Format","HH:mm:ss")-datetime('09:55:52',"Format","HH:mm:ss")

    Time_plot = CRDS_plot.DATE + timeofday(CRDS_plot.TIME) + hours(0) + minutes(59) + seconds(38);
    Time_plot.Format = 'dd.MM.uuuu HH:mm:ss:SSS';
    CRDS_plot.Time = Time_plot;


    clear Time_plot

    % CALIBRATION APPLIED and concentration changed to ug/m3

    CRDS_plot.NH3_ug = (CRDS_plot.NH3 - 0.0) ./ 1.00 *0.0409*17.031;
    CRDS_plot.CH4_ug = (CRDS_plot.CH4_dry - 0.0) ./ 1.00 *40.9*16.04;
    CRDS_plot.CO2_ug = (CRDS_plot.CO2_dry - 0.0) ./ 1.00 *40.9*44.01;
    CRDS_plot.N2O_ug = (CRDS_plot.N2O - 0.0) ./ 1.00 *40.9*44.013;

    TT_CRDS_plot = timetable(CRDS_plot.Time, CRDS_plot.NH3_ug, CRDS_plot.CH4_ug, CRDS_plot.CO2_ug, CRDS_plot.N2O_ug, 'VariableNames',{'NH3', 'CH4', 'CO2', 'N2O'});

    % Round intervals to full half hours for synchronization
    % 30 min intervals
    vec = datevec(TT_CRDS_plot.Time );
    v5  = vec(:,5)+vec(:,6)/60;
    vec(:,5) = round(v5/15)*15;
    vec(:,6) = 0;

    rt = [min(datetime(vec)) : minutes(30) : (max(datetime(vec))+minutes(30))];
    TT_CRDS_plot = retime(TT_CRDS_plot, rt, 'mean');

    save('TT_CRDS_plot_28_11_2022.mat', 'TT_CRDS_plot'); % Remember to change file
    

    %% Load CRDS bLS - CRDS # G2509 #4
    CRDS_bg = load_G2509_func(PATH_raw_bg);


    % Adjust time and apply calibration to concentration - and change all concentrations to ug/m3
    % TIME CORRECTION for BG CRDS: - 0 hour 1 min 25 sec
    % datetime('15:13:25',"Format","HH:mm:ss")-datetime('15:14:50',"Format","HH:mm:ss")
    % datetime('15:13:25',"Format","HH:mm:ss")-datetime('15:14:50',"Format","HH:mm:ss")
    % True - CRDS

    Time_bg = CRDS_bg.DATE + timeofday(CRDS_bg.TIME) + hours(0) - minutes(1) - seconds(25);
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

    save('TT_CRDS_bg_28_11_2022.mat', 'TT_CRDS_bg'); % Remember to change file

    %% Load Foulum weather station
    File_FoulumVejr = "C:\Users\AU323818\Dropbox\Uni\Dynamic flux chambers\DFC bLS #1\VejrFoulum_1611_2311.csv";
    TT_VejrFoulum = load_Foulum_Weather_func(File_FoulumVejr);

    save('TT_Foulum_28_11_2022.mat', 'TT_VejrFoulum') % Remember to change file

    %% Load bLS results

    % Set up the Import Options and import the data
    opts = delimitedTextImportOptions("NumVariables", 54);

    opts.DataLines = [2, Inf];
    opts.Delimiter = ";";

    opts.VariableNames = ["rn", "Sensor", "Source", "SensorHeight", "SourceArea", "CE", "CE_se", "CE_lo", "CE_hi", "uCE", "uCE_se", "uCE_lo", "uCE_hi", "vCE", "vCE_se", "vCE_lo", "vCE_hi", "wCE", "wCE_se", "wCE_lo", "wCE_hi", "N_TD", "TD_Time_avg", "TD_Time_max", "Max_Dist", "UCE", "Ustar", "L", "Zo", "sUu", "sVu", "sWu", "z_sWu", "WD", "d", "N0", "MaxFetch", "st", "et", "Sonic_raw", "Time", "SH", "UST", "sigW", "sigU", "sigV", "WS", "airT", "Pair", "kv", "A", "alpha", "bw", "C0"];
    opts.VariableTypes = ["double", "double", "categorical", "categorical", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "datetime", "datetime", "categorical", "datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";

    opts = setvaropts(opts, ["Source", "SensorHeight", "Sonic_raw"], "EmptyFieldRule", "auto");
    opts = setvaropts(opts, "st", "InputFormat", "yyyy-MM-dd HH:mm:ss");
    opts = setvaropts(opts, "et", "InputFormat", "yyyy-MM-dd HH:mm:ss");
    opts = setvaropts(opts, "Time", "InputFormat", "dd-MMM-yyyy HH:mm:ss");
    opts = setvaropts(opts, ["Sensor", "CE_se", "CE_lo", "CE_hi", "uCE_se", "uCE_lo", "uCE_hi", "vCE_se", "vCE_lo", "vCE_hi", "wCE_se", "wCE_lo", "wCE_hi", "TD_Time_avg", "TD_Time_max", "Max_Dist"], "TrimNonNumeric", true);
    opts = setvaropts(opts, ["Sensor", "CE_se", "CE_lo", "CE_hi", "uCE_se", "uCE_lo", "uCE_hi", "vCE_se", "vCE_lo", "vCE_hi", "wCE_se", "wCE_lo", "wCE_hi", "TD_Time_avg", "TD_Time_max", "Max_Dist"], "ThousandsSeparator", ",");


    T_results = readtable("C:\Users\AU323818\Dropbox\Uni\Dynamic flux chambers\DFC bLS #1\RSaves\DFC_1_results_1E5.csv", opts);

    TT_bLS_out = table2timetable(T_results,"RowTimes","st");

    clear opts T_results

    save('TT_bLS_out_28_11_2022.mat', 'TT_bLS_out')

else
    load('TT_CRDS_plot_28_11_2022.mat')
    load('TT_CRDS_bg_28_11_2022.mat')
    load('TT_Foulum_28_11_2022.mat')
    load('TT_bLS_out_28_11_2022.mat')
end

%% Combine and calculate flux
    TT_CRDS = synchronize(TT_CRDS_plot, TT_CRDS_bg);
    TT_CRDS.Properties.VariableNames = {'NH3', 'CH4', 'CO2', 'N2O', 'NH3_bg', 'CH4_bg', 'CO2_bg', 'N2O_bg'};

    TT_CRDS.dNH3 = TT_CRDS.NH3 - TT_CRDS.NH3_bg;
    TT_CRDS.dCH4 = TT_CRDS.CH4 - TT_CRDS.CH4_bg;
    TT_CRDS.dCO2 = TT_CRDS.CO2 - TT_CRDS.CO2_bg;
    TT_CRDS.dN2O = TT_CRDS.N2O - TT_CRDS.N2O_bg;

    TT = synchronize(TT_bLS_out, TT_CRDS);

    TT = rmmissing(TT,'DataVariables','CE');

%%  FLAGS:
    FLAG_UST005 = TT.UST > 0.05;
    FLAG_L2 = abs(TT.L) > 2;
    FLAG_sigU = TT.sUu < 4.5;
    FLAG_sigV = TT.sVu < 4.5;
    FLAG_C0 = TT.C0 < 10;
    FLAG_BUH = and(and(and(and(FLAG_UST005, FLAG_L2),FLAG_sigU), FLAG_sigV),FLAG_C0); % UST > 0.05, L2, sigU < 4.5, sigV < 4.5, C0 < 10 - from Bühler et al., 2021
    TT.FLAG = FLAG_BUH;

    disp('Filtered data: Removed (%)')
    %     disp((height(TT)-[sum(FLAG_UST005) sum(FLAG_L2) sum(FLAG_sigU) sum(FLAG_sigV) sum(FLAG_C0)])/height(TT)*100)
    disp((height(TT)-sum(FLAG_BUH))/height(TT)*100)


%%  Cumulative loss
    Time_Lim7 = [datetime(2022,11,16,9,30,0), datetime(2022,11,23,9,30,0)];

    TAN_slurry = 1; % CHANGE!
    %     TAN_slurry = 35.0 * 1.72E5 * 17.031 / 14.0067; % Basis for TAN er N mens flux er NH3

    TT.emis_NH3 = TT.dNH3 ./ TT.CE;
    TT.emis_CH4 = TT.dCH4 ./ TT.CE;
    TT.emis_N2O = TT.dN2O ./ TT.CE;

    TT.emis_NH3_gap = TT.emis_NH3;
    TT.emis_NH3_gap(~FLAG_BUH) = NaN;
    TT.emis_NH3_gap = fillmissing(TT.emis_NH3_gap,'linear');

    TT.emis_CH4_gap = TT.emis_CH4;
    TT.emis_CH4_gap(~FLAG_BUH) = NaN;
    TT.emis_CH4_gap = fillmissing(TT.emis_CH4_gap,'linear');

    TT.emis_N2O_gap = TT.emis_N2O;
    TT.emis_N2O_gap(~FLAG_BUH) = NaN;
    TT.emis_N2O_gap = fillmissing(TT.emis_N2O_gap,'linear');

    % Cumulative emissions with gap filling limited to 168 hours = 7 days
    TT.cum_NH3_gN = NaN(height(TT),1);
    TT.cum_NH3_gN(TT.Time >= Time_Lim7(1) & TT.Time < Time_Lim7(2)) = cumsum(TT.emis_NH3_gap(TT.Time >= Time_Lim7(1) & TT.Time < Time_Lim7(2))*1800* 14.0067 / 17.031 /10^6, 'omitnan');
    
    TT.cum_CH4_gCH4 = NaN(height(TT),1);
    TT.cum_CH4_gCH4(TT.Time >= Time_Lim7(1) & TT.Time < Time_Lim7(2)) = cumsum(TT.emis_CH4_gap(TT.Time >= Time_Lim7(1) & TT.Time < Time_Lim7(2))*1800/10^6, 'omitnan');
    
    TT.cum_N2O_mgN = NaN(height(TT),1);
    TT.cum_N2O_mgN(TT.Time >= Time_Lim7(1) & TT.Time < Time_Lim7(2)) = cumsum(TT.emis_N2O_gap(TT.Time >= Time_Lim7(1) & TT.Time < Time_Lim7(2))* 1800 * 14.0067 / 44.013 /10^3, 'omitnan');



    TAN_loss = cumsum(TT.emis_NH3_gap(TT.Time >= Time_Lim7(1) & TT.Time < Time_Lim7(2))*1800/(TAN_slurry)* 14.0067 / 17.031 /10^6, 'omitnan');
    Loss_CH4 = cumsum(TT.emis_CH4_gap(TT.Time >= Time_Lim7(1) & TT.Time < Time_Lim7(2))*1800/10^6, 'omitnan');
    TAN_loss_N2O = cumsum(TT.emis_NH3_gap(TT.Time >= Time_Lim7(1) & TT.Time < Time_Lim7(2))*1800/(TAN_slurry)* 14.0067 / 44.013 /10^6, 'omitnan');

    disp('Loss of NH3 in g N /m2')
    disp(max(TT.cum_NH3_gN))

    disp('Loss of CH4 in g CH4 /m2')
    disp(max(TT.cum_CH4_gCH4))

    disp('Loss of N2O in g N /m2')
    disp(max(TT.cum_N2O_mgN))


%% Plots
ii = 1;

if PLOT_SWITCH_CONC == 1
    figure(ii)
    plot(TT_CRDS.Time, TT_CRDS.NH3, 'o:', TT_CRDS.Time, TT_CRDS.NH3_bg, 'o:')
    grid on
    grid minor
    ylabel('NH_3 (\mug m^{-2} s^{-1})')
    legend('Plot', 'BG')
    ii = ii + 1;



end

if PLOT_SWITCH == 1
    figure(ii)
    plot(TT.Time(FLAG_BUH), TT.emis_CH4(FLAG_BUH), 'o:')
    grid on
    grid minor
    ylabel('CH_4 (\mug m^{-2} s^{-1})')
    ii = ii + 1;

    figure(ii)
    plot(TT.Time(FLAG_BUH), TT.emis_NH3(FLAG_BUH), 'o:')
    grid on
    grid minor
    ylabel('NH_3 (\mug m^{-2} s^{-1})')
    ii = ii + 1;

    figure(ii)
    plot(TT.Time(FLAG_BUH), TT.emis_N2O(FLAG_BUH), 'o:')
    grid on
    grid minor
    ylabel('N_2O (\mug m^{-2} s^{-1})')
    ii = ii + 1;

    figure(ii)
    plot(TT.Time, TT.cum_NH3_gN, ':')
    grid minor
    ylabel('Loss of TAN (g N)')
    title('Lost TAN')
    ii = ii + 1;
    
end


writetimetable(TT, [PATH, '\DFC_1_results_16_12_2022.txt'], 'Delimiter','tab')


toc

