function [ output ] = my_dct( input )

[m,n] = size(input);
output = zeros(m,n);

tmp_offset_m = (2/m)^0.5*ones(1,m);
tmp_offset_m(1) = 1/(m^0.5);
tmp_offset_n = (2/n)^0.5*ones(1,n);
tmp_offset_n(1) = 1/(n^0.5);
offset = tmp_offset_m' * tmp_offset_n;

cos_offset_m = pi/m * ((1:m)-0.5);
cos_offset_n = pi/n * ((1:n)-0.5);

for i = 1:m
    for j = 1:n
        tmp = input .* ( cos( cos_offset_m*(i-1) )'*cos( cos_offset_n*(j-1) ) );
        output(i,j) = sum( tmp(:) );
    end
end

output = output.*offset;

end

