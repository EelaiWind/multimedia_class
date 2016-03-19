clear all;
close all;

load('colors.mat');
centroid = colors;

img = imread('clash1.png');
img = double(img);
imshow(uint8(img));

n_center = size(centroid,1);
[ m, n, k ] = size(img);

% === Image Quantization ===
tic;
dis = zeros(m,n,n_center);
for i = 1 : n_center
    tmp = zeros(m,n,k);
    tmp(:, :, 1) = repmat( centroid(i,1), m, n);                             % Red
    tmp(:, :, 2) = repmat( centroid(i,2), m, n);                             % Green
    tmp(:, :, 3) = repmat( centroid(i,3), m, n);                             % Blue
    
    dis(:, :, i) = sum( (img - tmp).^2, 3 );
end

[ tmp , group_index] = min( dis , [], 3 );

figure;
imshow(group_index, centroid/255);
toc;

count_color = zeros(n_center, 1);
for i = 1 : n_center
    count_color(i,1) = sum( group_index(:) == i );
end
total_pixel = sum( count_color(:) );


% === Entropy Encode ===
average_entropy_count = 0;
encode_entropy = zeros( n_center, 1 );
for i = 1 : n_center
   tmp = count_color(i)/total_pixel;
   encode_entropy(i) = log2(1/tmp);
   average_entropy_count = average_entropy_count + tmp*encode_entropy(i);
end

% === Shannon Fano ===
global encode_fano
[count_color,sorted_index] = sort(count_color,'descend');
centroid = centroid(sorted_index);
prefix_sum = zeros( n_center, 1 );
prefix_sum(1) = count_color(1);
for i = 2 : n_center
   prefix_sum(i) = prefix_sum(i-1) + count_color(i);
end
runShannonFano(prefix_sum, '');

% === print result ===
fprintf('===Entropy encoding===\n');
for  i = 1:n_center
    fprintf('color %d = %f\n', i, encode_entropy(i));
end
fprintf('average entropy coding bit = %f\n',average_entropy_count);
fprintf('total entropy coding bit = %f\n',average_entropy_count*total_pixel);
fprintf('\n\n');
fprintf('===Shannon Fano encoding===\n');
total_fano_bit_count = 0;
for  i = 1:n_center
    tmp_str = char(encode_fano(i));
    fprintf('color %d = %s\n', i, tmp_str);
    total_fano_bit_count = total_fano_bit_count + length(tmp_str)*count_color(i);
end
fprintf('total shannon fano coding bit = %d\n',total_fano_bit_count);
imwrite(group_index, colors/255, 'q1');

