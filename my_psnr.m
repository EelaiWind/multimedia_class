function [ result ] = my_psnr( new_image, origin_image )
new_image = double(new_image);
origin_image = double(origin_image);
[m,n] = size(origin_image);

% normalize
new_image = new_image/max(new_image(:));
origin_image = origin_image/max(origin_image(:));

tmp = origin_image(:) - new_image(:);
MSE = (tmp'*tmp)/(m*n);
result = 10 * log10(1/MSE);

end

