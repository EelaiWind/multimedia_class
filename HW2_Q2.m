%%% HW2_Q2.m - To eliminate the noise, you need to apply audio dithering, noise shaping, and 
%                             use low-pass filter you finished in Q1 to filter out the high frequency components.

%% Clean variables and screen
clear all;close all;clc;
tic;
%% Visualization parameters (Change it if you want)
% Some Tips:
% (Tip 1) You can change the axis range to make the plotted result more clearly 
% (Tip 2) You can use subplot function to show multiple spectrums / shapes in one figure
titlefont = 15;
fontsize = 13;
LineWidth = 1.5;
inputSampleDepth = 16;
outputSamplseDepth = 256;
%% 1. Read in input audio file ( audioread )
[y_noise, fs] = audioread('Moonlight_4bit.wav');

%%% Plot the spectrum of input audio
figure;
title('Input Spectrum', 'fontsize', titlefont);
set(gca,'fontsize',fontsize);
subplot(1,2,1);
[frequency, magnitude] = makeSpectrum( y_noise(:,1) , fs );
plot(frequency,magnitude,'LineSmooth', 'on', 'LineWidth', LineWidth); 
axis([0,3000,-inf, inf]);

subplot(1,2,2);
[frequency, magnitude] = makeSpectrum( y_noise(:,2) , fs );
plot(frequency,magnitude,'LineSmooth', 'on', 'LineWidth', LineWidth);
axis([0,3000,-inf, inf]);

%%% Plot the shape of input audio
figure;
title('Input', 'fontsize', titlefont);
subplot(1,2,1);
plot(y_noise(10000:10300,1),'LineSmooth', 'on', 'LineWidth', LineWidth);
subplot(1,2,2);
plot(y_noise(10000:10300,2),'LineSmooth', 'on', 'LineWidth', LineWidth); 


%% 2. Audio dithering
% (Hint) add random noise to the y_noise
y_noise = addRandomNoise(y_noise,'gaussian', inputSampleDepth);


%%% Plot the spectrum of the dithered result
figure;
title('Input', 'fontsize', titlefont);
subplot(1,2,1);
plot(y_noise(10000:10300,1),'LineSmooth', 'on', 'LineWidth', LineWidth);
subplot(1,2,2);
plot(y_noise(10000:10300,2),'LineSmooth', 'on', 'LineWidth', LineWidth); 


%% 3. First-order feedback loop for Noise shaping
% (Hint) Check the signal value. How do I quantize the dithered signal? maybe scale up first?
y_noise = implementNoiseShaping(y_noise, 1, outputSamplseDepth);

%%% Plot the spectrum of noise shaping
figure;
title('Input', 'fontsize', titlefont);
subplot(1,2,1);
plot(y_noise(10000:10300,1),'LineSmooth', 'on', 'LineWidth', LineWidth);
subplot(1,2,2);
plot(y_noise(10000:10300,2),'LineSmooth', 'on', 'LineWidth', LineWidth);

figure;
title('Output Spectrum', 'fontsize', titlefont);
set(gca,'fontsize',fontsize);
subplot(1,2,1);
[frequency, magnitude] = makeSpectrum( y_noise(:,1) , fs );
plot(frequency,magnitude,'LineSmooth', 'on', 'LineWidth', LineWidth); 
axis([0,3000,-inf, inf]);

subplot(1,2,2);
[frequency, magnitude] = makeSpectrum( y_noise(:,2) , fs );
plot(frequency,magnitude,'LineSmooth', 'on', 'LineWidth', LineWidth);
axis([0,3000,-inf, inf]);


%% 4. Implement Low-pass filter
outputSignal1 = myFilter(y_noise(:,1),fs,1001,'Blackman','low-pass',1000)';
outputSignal2 = myFilter(y_noise(:,2),fs,1001,'Blackman','low-pass',1000)';
outputSignal = [outputSignal1,outputSignal2];
%% 5. Save filtered audio (audiowrite)
audiowrite('Moonlight_recover.wav',outputSignal,fs);


%%% Plot the spectrum of output audio
figure;
title('Input', 'fontsize', titlefont);
subplot(1,2,1);
plot(outputSignal(10000:10300,1),'LineSmooth', 'on', 'LineWidth', LineWidth);
subplot(1,2,2);
plot(outputSignal(10000:10300,2),'LineSmooth', 'on', 'LineWidth', LineWidth);


%%% Plot the shape of output audio
figure;
title('Output Spectrum', 'fontsize', titlefont);
set(gca,'fontsize',fontsize);
subplot(1,2,1);
[frequency, magnitude] = makeSpectrum( outputSignal(:,1) , fs );
plot(frequency,magnitude,'LineSmooth', 'on', 'LineWidth', LineWidth); 
axis([0,3000,-inf, inf]);

subplot(1,2,2);
[frequency, magnitude] = makeSpectrum( outputSignal(:,2) , fs );
plot(frequency,magnitude,'LineSmooth', 'on', 'LineWidth', LineWidth);
axis([0,3000,-inf, inf]);

toc;

