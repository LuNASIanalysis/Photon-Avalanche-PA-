%function that calculates the time required to reach X% of saturation intensity
function t_50 = calc_t_XPercent_new(power, time_start, time_end, time, intensity, ParamXPercent)
    how_many_percent = 30;
   
    for k = 1:length(power)
        [~, i_start] = min(abs(time{k} - time_start)); %the index at which rise begins 
        [~, i_end] = min(abs(time{k} - time_end)); %the index for which the rise ends

        how_many = int16( how_many_percent*(i_end - i_start)/100);
        intensity_max = mean(intensity{k}(i_end-how_many:i_end)); %the average of the last 10% of the maximum values
        III = smooth(intensity{k}(i_start:i_end), 9, 'moving');
        [~, ind] = min(abs(intensity{k}(i_start:i_end) - ParamXPercent*intensity_max/100)); %the index for which the intensity is half of the maximum value
        [~, ind] = min(abs(III - ParamXPercent*intensity_max/100)); %the index for which the intensity has half of the maximum value
        t_50{k} = time{k}(ind);

    end    
end