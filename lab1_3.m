close all;
clear all;

origin_image = imread('clash3.png');
scale = 4;
[ m, n, RGB ] = size(origin_image);
origin_image = double(origin_image);

bigger_image = zeros(m*scale, n*scale, RGB);
for i = 1 : m*scale 
    for j = 1 : n*scale
        round_x = round(i/scale);
        round_y = round(j/scale);
        if round_x == 0
            round_x = 1;
        end
        if round_y == 0
            round_y = 1;
        end
        bigger_image( i, j, : ) = origin_image( round_x, round_y, : );
    end
end

bigger_image = uint8(bigger_image);
figure;
imshow(bigger_image);
title('Nearest-neighbor (NN) interpolation');
imwrite(bigger_image,'q3_1.png')

area = zeros(4,1);
bilinear_image = zeros(m*scale, n*scale, RGB);
for i = 0:m*scale-1
    for j = 0:n*scale-1
        x = floor(i/scale);
        y = floor(j/scale);
        x1 = i/scale - x;
        x2 = 1 - x1;
        y1 = j/scale - y;
        y2 = 1 - y1;
        area(3) = x1*y1;
        area(4) = x1*y2;
        area(2) = x2*y1;
        area(1) = x2*y2;
        
        % top left
        tmp = area(1)*origin_image( x+1, y+1, : );
        
        % top right
        if y+1 >= n
            tmp = tmp + area(2)*origin_image( x+1, y+1, : );
        else
            tmp = tmp + area(2)*origin_image( x+1, y+2, : );
        end
        % bottom left
        if x+1 >= m
            tmp = tmp + area(3)*origin_image( x+1, y+1, : );
        else
            tmp = tmp + area(3)*origin_image( x+2, y+1, : );
        end
        % bottom right
        if x+1 >=m || y+1 >= n
            tmp = tmp +area(4)*origin_image( x+1, y+1, : );
        else
            tmp = tmp + area(4)*origin_image( x+2, y+2, : );
        end
        bilinear_image( i+1, j+1, : ) = tmp;
    end
end

bb = uint8(bilinear_image);
figure;
imshow(bb);
title('Bilinear interpolation');
imwrite(bb,'q3_2.png')