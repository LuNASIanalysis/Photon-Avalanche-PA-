%function to calculate the PA threshold value
function [Threshold,p_Low,p_PA] = calc_threshold(TableNsmooth, pow_int)
Offset = 8;  
idx_Start = min(find(TableNsmooth(:, 2) > 3));               
[MaxN,idx_Max] = max(TableNsmooth(:,2));                           
pow_int_reduced = [pow_int(idx_Start:idx_Max+Offset, 1) pow_int(idx_Start:idx_Max+Offset, 2)];
TableNsmooth = [TableNsmooth(idx_Start:idx_Max+Offset, 1) TableNsmooth(idx_Start:idx_Max+Offset, 2)];

Threshold = -1;
p_Low = -1;
p_PA = -1;

if ~isempty(idx_Start)
    N_Th = 5;    
    [~,idx_Th1] = min(abs(TableNsmooth(:,2)-N_Th)); 
    idx_Th = max(idx_Th1);
    TableX_Low = log(pow_int_reduced(1:idx_Th-3,1));
    TableX_extended = log(pow_int_reduced(:,1));
    TableX_PA = log(pow_int_reduced(end-(Offset):end,1));
    TableY_Low = log(pow_int_reduced(1:idx_Th-3,2));
    TableY_PA = log(pow_int_reduced(end-(Offset):end,2));

    p_Low = polyfit(TableX_Low, TableY_Low, 1); 
    p_PA = polyfit(TableX_PA, TableY_PA, 1);   
    [~,Index_Th] = min(abs(polyval(p_Low, TableX_extended)-polyval(p_PA, TableX_extended)));
    Threshold = pow_int_reduced(Index_Th,:);
    figure;
    plot(TableX_Low,TableY_Low); hold on;
    plot(TableX_PA,TableY_PA); hold on;
    plot(TableX_extended,p_Low(1)*TableX_extended+p_Low(2));
    plot(TableX_extended,p_PA(1)*TableX_extended+p_PA(2));
    plot(log(Threshold(1,1)),log(Threshold(1,2)),'x');
end;
