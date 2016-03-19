clear all;
close all;

block_size = 8;

image = imread('clash2.png');
output = loosly_dct( image, block_size, 2 );
figure;
imshow(output);
title_str = sprintf('when n = 2, PSNR = %f',my_psnr(output, image) );
title(title_str);

output = loosly_dct( image, block_size, 4 );
figure;
imshow(output);
title_str = sprintf('when n = 4, PSNR = %f',my_psnr(output, image) );
title(title_str);

output = loosly_dct( image, block_size, 8 );
figure;
imshow(output);
title_str = sprintf('when n = 8, PSNR = %f',my_psnr(output, image) );
title(title_str);