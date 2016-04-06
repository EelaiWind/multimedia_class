%%% HW2_Q1.m - Complete the procedure of separating HW2_mix.wav into 3 songs

%% Clean variables and screen
clear all;clc;close all;
tic;
%% Visualization parameters (Change it if you want)
% Some Tips:
% (Tip 1) You can change the axis range to make the plotted result more clearly 
% (Tip 2) You can use subplot function to show multiple spectrums / shapes in one figure
titlefont = 15;
fontsize = 13;
LineWidth = 1.5;

%% 1. Read in input audio file ( audioread )
% y_input: input signal, fs: sampling rate
[y_input, fs] = audioread('HW2_Mix.wav');

%%% Plot example : plot the input audio
% The provided function "makeSpectrum" generates frequency
% and magnitude. Use the following example to plot the spectrum.
[frequency, magnitude] = makeSpectrum( y_input , fs );
plot(frequency,magnitude,'LineSmooth', 'on', 'LineWidth', LineWidth); 
axis([0,1600,0,27000]);
title('Input', 'fontsize', titlefont);
set(gca,'fontsize',fontsize);

%% 2. Filtering 
% (Hint) Implement myFilter here
% [...] = myFilter(...);
filterOrder = 1001;
[outputSignalLowPass, outputFilterLowPass] = myFilter(y_input, fs, filterOrder, 'Blackman', 'low-pass', 380 );
[outputSignalBandPass, outputFilterBandPass] = myFilter(y_input, fs, filterOrder, 'Blackman', 'bandpass', [400,700] );
[outputSignalHighPass, outputFilterHighPass] = myFilter(y_input, fs,filterOrder, 'Blackman', 'high-pass', 800 );
%%% Plot the shape of filters in Time domain
figure;
subplot(1,3,1);
plot(outputFilterLowPass,'LineSmooth', 'on', 'LineWidth', LineWidth, 'Color', 'r');
title('Low Pass Filter in time domain', 'fontsize', titlefont);
set(gca,'fontsize',fontsize);
axis([0, filterOrder, -inf, inf ]);

subplot(1,3,2);
plot(outputFilterBandPass,'LineSmooth', 'on', 'LineWidth', LineWidth);
title('Band Pass Filter in time domain', 'fontsize', titlefont);
set(gca,'fontsize',fontsize);
axis([0, filterOrder, -inf, inf ]);

subplot(1,3,3);
plot(outputFilterHighPass,'LineSmooth', 'on', 'LineWidth', LineWidth, 'Color', 'g');
title('High Pass Filter in time domain', 'fontsize', titlefont);
set(gca,'fontsize',fontsize);
axis([0, filterOrder, -inf, inf ]);

%%% Plot the spectrum of filters (Frequency Analysis)

figure;
hold on;
[frequency, magnitude] = makeSpectrum( outputFilterLowPass , fs );
plot(frequency,magnitude,'LineSmooth', 'on', 'LineWidth', LineWidth, 'Color', 'r');

[frequency, magnitude] = makeSpectrum( outputFilterBandPass , fs );
plot(frequency,magnitude,'LineSmooth', 'on', 'LineWidth', LineWidth);

[frequency, magnitude] = makeSpectrum( outputFilterHighPass , fs );
plot(frequency,magnitude,'LineSmooth', 'on', 'LineWidth', LineWidth, 'Color', 'g');
legend('Low Pass','Band Pass', 'High Pass');
title('Filters in frequency domain', 'fontsize', titlefont);
axis([0,1500,0,2]);
set(gca,'fontsize',fontsize);
hold off;

%% 3. Save the filtered audio (audiowrite)
% name the file 'FilterName_para1_para2.wav'. 
% para means the cutoff frequency that you set for the filter

audiowrite('output_LowPass.wav', outputSignalLowPass, fs);
audiowrite('output_BandPass.wav', outputSignalBandPass, fs);
audiowrite('output_HighPass.wav', outputSignalHighPass, fs);

%%% Plot the spectrum of filtered signals
figure;
hold on;
[frequency, magnitude] = makeSpectrum( outputSignalLowPass , fs );
plot(frequency,magnitude,'LineSmooth', 'on', 'LineWidth', LineWidth, 'Color', 'r');

[frequency, magnitude] = makeSpectrum( outputSignalBandPass , fs );
plot(frequency,magnitude,'LineSmooth', 'on', 'LineWidth', LineWidth);

[frequency, magnitude] = makeSpectrum( outputSignalHighPass , fs );
plot(frequency,magnitude,'LineSmooth', 'on', 'LineWidth', LineWidth, 'Color', 'g');

legend('Low Pass','Band Pass', 'High Pass');
title('Output signals in frequency domain', 'fontsize', titlefont);
axis([0,1600,0,27000]);
set(gca,'fontsize',fontsize);
hold off;
toc;
