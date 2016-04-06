function [ outputSignal ] = implementNoiseShaping( inputSignal, shapingParameter, outputSampleDepth )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[m,n] = size(inputSignal);
error = zeros(1,n);
outputSignal = zeros(m,n);

for i=1:m
    if i == 1
        signalBuffer = inputSignal(i,:) ;
    else
        signalBuffer = inputSignal(i,:) + shapingParameter* error;
    end
    % map signal to new quantization value
    outputSignal(i,:) = round ((signalBuffer+1)*(outputSampleDepth-1)/2)/(outputSampleDepth-1)*2-1;
    
    if outputSignal(i,:) > 1
        outputSignal(i,:) = 1;
    elseif outputSignal(i,:) < -1
        outputSignal(i,:) = -1;
    end
        
    error = abs(outputSignal(i,:) - signalBuffer);
end

end

