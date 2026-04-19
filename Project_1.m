clc;
clear;
close all;
%% --------------------------UNIPOLAR SIGNALING----------------------------
a = 4;
n = 101;                                      % 101 bits (one extra for the shift)
ensemble_uni = zeros(500,800);
for i = 1 : 500
    data = randi([0,1], 1, n);
    tx = a * data;
    tx_matrix = repmat(tx, 8, 1);
    tx_column = reshape(tx_matrix, [], 1);    % 808 samples
    shift = randi([0,7]);                     % random initial shift
    ensemble_uni(i, :) = tx_column(shift+1 : shift+800);
end
%% ------------------------POLAR NON RETURN TO ZERO------------------------
ensemble_NRZ = zeros(500,800);
for i = 1 : 500
    data = randi([0,1], 1, n);
    tx = ((2 * data) - 1) * a;
    tx_matrix = repmat(tx, 8, 1);
    tx_column = reshape(tx_matrix, [], 1);
    shift = randi([0,7]);
    ensemble_NRZ(i, :) = tx_column(shift+1 : shift+800);
end
%% ---------------------------RETURN TO ZERO-------------------------------
ensemble_RZ = zeros(500,800);
for i = 1:500
    data = randi([0,1], 1, n);
    tx = ((2 * data) - 1) * a;
    first_half  = repmat(tx, 4, 1);
    second_half = zeros(4, n);
    tx_matrix   = [first_half ; second_half];
    tx_column   = reshape(tx_matrix, [], 1);
    shift = randi([0,7]);
    ensemble_RZ(i,:) = tx_column(shift+1 : shift+800);
end
%% ----------------------- PLOTTING FIRST 2 WAVEFORMS ---------------------
plot_waveform(ensemble_uni, 'Unipolar',   'b', [-1  5]);
plot_waveform(ensemble_NRZ, 'Polar NRZ',  'r', [-5  5]);
plot_waveform(ensemble_RZ,  'Return to Zero', 'g', [-5  5]);
%% ----------------------- COMPUTING STATISTICAL MEAN ---------------------
plot_mean(ensemble_uni,"UniPolar Statistical Mean");
plot_mean(ensemble_NRZ,"Polar Non Return To Zero Statistical Mean");
plot_mean(ensemble_RZ,"Polar Return To Zero Statistical Mean");
%% ----------------------- COMPUTING STATISTICAL AUTOCORRELATION ---------------------
plot_autocorrelation(ensemble_uni,"UniPolar AUTOCORRELATION");
plot_autocorrelation(ensemble_NRZ,"Polar Non Return To Zero AUTOCORRELATION");
plot_autocorrelation(ensemble_RZ,"Polar Return To Zero AUTOCORRELATION");
%% ----------------------- COMPUTING TIME MEAN AND TIME AUTOCORRELATION OF ONE WAVEFORM ---------------------
Mean_autocorrelation_OneWaveform(ensemble_uni,"UniPolar Time AutoCorrelation ");
Mean_autocorrelation_OneWaveform(ensemble_NRZ,"Polar Non Return To Zero Time AutoCorrelation ");
Mean_autocorrelation_OneWaveform(ensemble_RZ,"Polar Return To Zero Time AutoCorrelation ");
%% ----------------------- PSD ---------------------
PSD(ensemble_uni,"UniPolar");
PSD(ensemble_NRZ,"Polar Non Return To Zero ");
PSD(ensemble_RZ,"Polar Return To Zero ");