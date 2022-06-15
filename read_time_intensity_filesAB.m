%function to load data with rise times 
function [power, time_start, time_end, time, intensity] = read_time_intensity_filesAB(dir_, KineticFiles,ChannelNo)

    [match,noMatch] = regexp(KineticFiles(1).name,'mWcm2_td','match','split');
    [match,noMatch] = regexp(noMatch{2},'ms_ds', 'match','split');
    time_start = str2double(noMatch{1}); %value of the time for which the excitation is switched on
    [match,noMatch] = regexp(KineticFiles(1).name,'ms_ds','match','split');
    [match,noMatch] = regexp(noMatch{2},'ms_', 'match','split');
    time_end = str2double(noMatch{1}); %value of the time for which the excitation is switched off
    
    for k = 1:length(KineticFiles)
        [match,noMatch] = regexp(KineticFiles(k).name,'nm_PD','match','split');
        [match,noMatch] = regexp(noMatch{2},'mWcm2','match','split');
        power{k} = str2double(noMatch{1});
        power{k} = power{k} / 1000; %power density in W/cm2
        fullFileName = fullfile(dir_, KineticFiles(k).name);
        fileID = fopen(fullFileName);
        for i=1:11
           tline = fgets(fileID); 
        end
        formatspec='%f %f %f %f %f';
        sizeA = [5 Inf];
        A = fscanf(fileID, formatspec, sizeA);
        A = A';
        time{k} = A(:, 1) * 1000; %time values expressed in ms
        intensity{k} = A(:, 2*ChannelNo);
        clc; sprintf('Reading file %3.2f %%', 100*k/length(KineticFiles));
        fclose(fileID);
    end
end