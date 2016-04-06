function [ outputSignal ] = addRandomNoise( inputSignal, mode, quantizationDepth )
%UNTITLED Summary of this function goes here
%   mode can either be 'uniform' or 'gaussian'

[m,n] = size(inputSignal);

if strcmp(mode,'uniform') == 1
    outputSignal = inputSignal + (2*rand(m,n)-1)/quantizationDepth;
else
    outputSignal = inputSignal + randn(m,n)/quantizationDepth;
end

outputSignal(outputSignal > 1 ) = 1;
outputSignal(outputSignal < -1 ) = -1;

end

