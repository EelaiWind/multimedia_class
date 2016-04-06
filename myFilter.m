function [outputSignal, outputFilter] = myFilter(inputSignal, fsample, N, windowName, filterName, fcutoff)
%%% Input
% inputSignal: input signal
% fsample: sampling frequency
% N : size of FIR filter(odd)
% windowName: 'Blackman'
% filterName: 'low-pass', 'high-pass', 'bandpass', 'bandstop'
% fcutoff: cut-off frequency or band frequencies
%       if type is 'low-pass' or 'high-pass', para has only one element
%       if type is 'bandpass' or 'bandstop', para is a vector of 2 elements

%%% Ouput
% outputSignal: output (filtered) signal
% outputFilter: output filter

%% 1. Normalization
fcutoff = fcutoff/fsample;
N = int32(N);
middle = idivide(N,2);
% make sure N is an odd interger
if mod(N,2) == 0
	N = N + 1;
end

%% 2. Create the filter according the ideal equations (slide #76)
% (Hint) Do the initialization for the outputFilter here

indexArray = double(-middle:middle);
if strcmp(filterName,'low-pass') == 1
    fprintf('low-pass filter');
	outputFilter = sin(2*pi*fcutoff(1)*indexArray)./(pi*indexArray);
	outputFilter(middle+1) = 2*fcutoff(1);
elseif strcmp(filterName,'high-pass') == 1
    fprintf('high-pass filter');
	outputFilter = -(sin(2*pi*fcutoff(1)*indexArray)./(pi*indexArray));
	outputFilter(middle+1) = 1-2*fcutoff(1);
elseif strcmp(filterName,'bandpass') == 1
    fprintf('bandpass filter');
	outputFilter = ( sin(2*pi*fcutoff(2)*indexArray) - sin(2*pi*fcutoff(1)*indexArray) ) ./ (pi*indexArray);
	outputFilter(middle+1) = 2*( fcutoff(2) - fcutoff(1) );
elseif strcmp(filterName,'bandstop') == 1
    fprintf('bandstop filter');
	outputFilter = ( sin(2*pi*fcutoff(1)*indexArray) - sin(2*pi*fcutoff(2)*indexArray) ) ./ (pi*indexArray);
	outputFilter(middle+1) = 1 - 2*( fcutoff(2) - fcutoff(1) );
else
	outputFilter = zeros(1,N);
    outputFilter(1) = 1;
end

%% 3. Create the windowing function (slide #80) and Get the realistic filter
if strcmp(windowName,'Blackman') == 1
    fprintf(' with Blackman window\n');
	windows = 0.42+0.5*cos(2*pi*double(-middle:middle)/double(N))+0.08*cos(2*pi*double(-middle:middle)/double(N));
	outputFilter = outputFilter .* windows;
else
    fprintf('\n');
end


%% 4. Filter the input signal in time domain. Do not use matlab function 'conv'
outputSignal = myConv(inputSignal, outputFilter);
outputSignal = outputSignal/max(abs(outputSignal(:)));
