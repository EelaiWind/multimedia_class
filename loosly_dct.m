function [ out_image ] = loosly_dct( in_image, block_size, offset )

in_image = double(in_image);
[m,n] = size(in_image);
out_image = zeros(m,n);
block_m = m/block_size;
block_n = n/block_size;

for i=1:block_m
    for j= 1:block_n
        block = in_image( i*block_size-7:i*block_size, j*block_size-7:j*block_size );
        dct_matrix = my_dct(block);
        dct_matrix( 1:block_size > offset, : ) = 0;
        dct_matrix( :, 1:block_size > offset ) = 0;
        out_image( i*block_size-7:i*block_size, j*block_size-7:j*block_size ) = my_idct(dct_matrix);
    end
end
out_image = uint8(out_image);

end

