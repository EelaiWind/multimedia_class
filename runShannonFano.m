function runShannonFano( prefix_sum , c )
    global encode_fano
    
    len = length(prefix_sum);
    sum = prefix_sum(end);
    half = sum/2;
    
    if len == 1
        encode_fano{end+1} = c;
        return;
    end
    
    min_dis = sum;
    min_index = 0;
    for i = 1 : len
        if i > 1 && prefix_sum(i) <= prefix_sum(i-1)
               error('prefix_sum must be a array with increasing elements');
        end
        tmp = abs( half - prefix_sum(i) );
        if i ==1 || tmp < min_dis
            min_dis = tmp;
            min_index = i;
        else 
            break;
        end
    end
   
    runShannonFano( prefix_sum(1:min_index), [c,'0']);
    runShannonFano( prefix_sum(min_index+1:end)-prefix_sum(min_index), [c,'1']);
end

