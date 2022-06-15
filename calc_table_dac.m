%function calculating the increase of luminescence intensity (Dav
%parameter)

function TableDav = calc_table_dac(pow_int)
    TableDav = zeros(size(pow_int(:, 1)));
    for i = 2:(size(TableDav)-1)
        val = pow_int(i, 1); % Ip value
        [~, ind] = min(abs(pow_int(:, 1) - 2 * val)); %the index for which Ip is doubled
        TableDav(i) = pow_int(ind, 2)/pow_int(i, 2); %calculation of Dav
        clc; sprintf('Calculating \x0394 _{AV} %3.2f', 100*i/max(size(TableDav)));
    end    
end

