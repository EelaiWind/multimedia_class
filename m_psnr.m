function [ result ] = my_psnr( new_image, origin_image )
[m,n] = size(origin_image);

% normalize
%new_image = new_image/max(new_image(:));
%origin_image = origin_image/max(origin_image(:));

tmp = ( origin_image - new_image).^2;
MSE = sum( tmp(:) )/(m*n);
result = 10 * log10(255*255/MSE);

end

