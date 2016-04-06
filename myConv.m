function [ output ] = myConv( signal, mask )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% make sure mask is a column vector
if size(mask,2) > size(mask,1)
    mask = mask';
end

% make sure mask is a row vector
if size(signal,1) > size(signal,2)
    signal = signal';
end

maskSize = length(mask);
signalSize = length(signal);
outputSize = maskSize+signalSize-1;
output = zeros(1,outputSize);
signal(end+1) = 0;

index = 0:-1:-(maskSize-1);
for i = 1:outputSize
    shiftedIndex = i+index;
    shiftedIndex(shiftedIndex>signalSize | shiftedIndex<=0 ) = signalSize+1;
    output(i) = signal(uint32(shiftedIndex))*mask;
end


end

