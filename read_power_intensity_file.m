%function to read the power dependence data file containing excitation
%powers and the coresponding luminescence intensity
function pow_int = read_power_intensity_file(file_name, ChannelNo)
    fileID = fopen(file_name);
    for i=1:9
        tline = fgets(fileID);
    end
    formatspec='%f %f %f %f %f %f';
    sizeA = [6 Inf];
    A = fscanf(fileID, formatspec, sizeA);
    A = A';
    power = A(:, 2);
    intensity = A(:, 2*ChannelNo+2);
    pow_int = [power intensity];
    pow_int = sortrows(pow_int, 1);
end