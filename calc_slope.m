%function that calculates the values of the coefficients A and N of the
%power dependence curve
function [TableN, TableA] = calc_slope(pow_int)
    TableX = log(pow_int(:, 1));
    TableY = log(pow_int(:, 2));

    SizeT = max(size(TableX));
    
    % user defined parameters determining the precision of analysis
    SD = 0;
   
    SDErr = 0.002;      
    MinimalCheck=8;   
    
    Step = 1;

    TableN = zeros(SizeT-5, 2);
    TableA = zeros(SizeT-5, 1);

    for idxT=1:SizeT-MinimalCheck
        Didx = MinimalCheck;
        SD = 0;
        while (SD < SDErr) && (idxT + Didx < SizeT)

            TableX2 = TableX(idxT:idxT+Didx) - TableX(idxT);
            TableY2 = TableY(idxT:idxT+Didx);

            [p, ErrorEst] = polyfit(TableX2, TableY2, 1); %polynomial fit
            [f, delta] = polyval(p, TableX2, ErrorEst);
            SD = sum((delta.^2)./(f.^2));
            TableN(idxT, 1) = pow_int(idxT, 1); %x-axis values
            TableN(idxT, 2) = p(1); %the values of the coefficients N
            TableA(idxT) = p(2); %values of coefficients A
            Didx = Didx + Step;
        end
        clc; sprintf('Calculating N %3.2f %%', 100*idxT/(SizeT-MinimalCheck))
    end  
end