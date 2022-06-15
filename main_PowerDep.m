%%Software for analysis of the power dependence experiments. Developed by
%%LuNASI research group, Institute of Low Temperatures and Structure
%%Research, PAS, Poland

clear;
close all;
%load intensity dependence on power
%please note specific format of the file name containing experimental
%parameters 

directory = uigetdir(pwd, 'Select a folder'); %user-selectable folder
AllFiles = dir([ directory '\' '*.asc']);    
KineticsFiles = dir([ directory '\' '*TCSPC*.asc']);
[match,noMatch] = regexp(KineticsFiles(1).name,'_TCSPC','match','split');
PowerDepName = strcat([directory '\' noMatch{1} '.asc']);
pow_int = read_power_intensity_file(PowerDepName,1);

[match,noMatch] = regexp(KineticsFiles(1).name,'_TCSPC','match','split');
PowerDepName = noMatch{1};
TabelaDoZapisania = zeros(10,1);

%increase in luminescence intensity (Dav parameter)
TableDav = calc_table_dac(pow_int);

%deretmining the N and A values
[TableN, TableA] = calc_slope(pow_int);

%combination for dense data
idx = find(TableN(:, 2) > 0.1); 
TableN = [TableN(idx, 1) TableN(idx, 2)];
TableN = [TableN(7:end, 1), TableN(7:end, 2)];
TableA = TableA(idx);
TableA = TableA(7:end);
TableX = log(pow_int(:, 1));
TableX = TableX(idx);
TableX = TableX(7:end);

%calculation of values for the s-shape curve
s_shape = exp(TableA) + TableN(:, 2) .* log(TableN(:, 1));
a = [TableN(:, 1),s_shape];
[TableNsmooth, TableAsmooth] = calc_slope(a);
TableDavsmooth = calc_table_dac(a);

%Counting Threshold
[Threshold,p_Low,p_PA] = calc_threshold(TableNsmooth,[TableN(:, 1), s_shape]);

%loading data with rise times
[power_rise, time_start, time_end, time_rise, intensity_rise] = read_time_intensity_filesAB(directory, KineticsFiles,1);

%method for determining the rise time
t_50 = calc_t_XPercent_new(power_rise, time_start, time_end, time_rise, intensity_rise, 50);
t_95 = calc_t_XPercent_new(power_rise, time_start, time_end, time_rise, intensity_rise, 80);


% figure;
%Graph intensity dependence on power
subplot(5, 2, 1);
h1 = loglog(pow_int(:, 1), pow_int(:, 2), '.-', 'color', [0 0 0]); 
grid on;
hold on;
h2 = loglog(TableN(:, 1), s_shape, 'LineWidth', 2.75, 'color', [1 0.5 0]); alpha(0.3);
hold on

xlim([10^2, 10^7]);
ylim([10^1, 10^8]);
yticks([10^1, 10^3, 10^5, 10^7]);
ylabel('Intensity (1Ch) [cps]');
title('a)', 'Units', 'normalized', 'Position', [1, 1, 1]);
legend(["Data", "Matching S-shape curve"], 'Location', 'northwest');

% residuals
pow_int(:, 3) = interp1(TableN(:, 1), s_shape, pow_int(:, 1));
subplot(5, 2, 3);
h1 = semilogx(pow_int(:, 1), (pow_int(:, 2)-pow_int(:, 3))./pow_int(:, 2), '.-', 'color', [1 0.5 0]); 
xlim([10^2, 10^7]);
grid on;
hold on;
ylabel('rel.residuals (I_L-I_{theo})/I_L');
title('b)', 'Units', 'normalized', 'Position', [1, 1, 1]);

%graph 
subplot(5, 2, 5);
semilogx(TableN(:, 1), TableN(:, 2), '.-', 'color' , [0 0 0]); hold on;
semilogx(TableNsmooth(:, 1), TableNsmooth(:, 2), '.-', 'color' , [1 0.5 0]); hold on;
grid on;
xlim([10^2, 10^7]);
ylim([0, 30]);
yticks([0, 10^(-1), 10^0, 10^1]);
ylabel('In-out order N [arb. units]');
title('c)', 'Units', 'normalized', 'Position', [1, 1, 1]);

%graph of luminescence intensity increase dependence on power
subplot(5, 2, 7);
semilogx(pow_int(:, 1), TableDav, '.-', 'color', [0 0 0]); hold on;
semilogx(TableN(:, 1), TableDavsmooth, '.-', 'color', [1 0.5 0]); hold on;

grid on;
xlim([10^2, 10^7]);
ylabel('\Delta_{AV}');
title('d)', 'Units', 'normalized', 'Position', [1, 1, 1]);
yticks([10^0, 10^1, 10^2]);

%plot of time t50% t95% and kinetics I_LUM against power
subplot(5, 2, 9);
ColorAB = zeros(length(power_rise), 3);

for k=1:length(power_rise) 
    subplot(5, 2, 9);
        ColorAB(k,:) = [0.3 1-k/length(power_rise) k/length(power_rise)];
        semilogx(power_rise{k}, t_50{k} * 1000,  'o-', 'LineStyle', '-', 'LineWidth', 1, 'MarkerSize', 6, 'MarkerFaceColor', ColorAB(k, :),...
            'MarkerEdgeColor', ColorAB(k, :)); hold on;
        semilogx(power_rise{k}, t_95{k} * 1000,  'o-', 'LineWidth', 1, 'MarkerSize', 6, 'MarkerFaceColor', [1 1 1],...
            'MarkerEdgeColor', ColorAB(k, :)); hold on;
        if (k>1)
            line( [power_rise{k} power_rise{k-1}], [t_50{k} * 1000 t_50{k-1} * 1000],'Color',ColorAB(k, :),'LineStyle','-');
            line( [power_rise{k} power_rise{k-1}], [t_95{k} * 1000 t_95{k-1} * 1000],'Color',ColorAB(k, :),'LineStyle','--');
        end;
    subplot(5, 2, [6,8,10]);
        semilogy(time_rise{k}, intensity_rise{k}, 'LineWidth', 1, 'Color', ColorAB(k, :));
        hold on;
    subplot(5, 2, 1);
        idx = find(pow_int(:, 1)>= power_rise{k});
        loglog(power_rise{k}, pow_int(idx(1), 2),  'o-', 'LineStyle', '-', 'LineWidth', 1, 'MarkerSize', 6, 'MarkerFaceColor', ColorAB(k, :),...
            'MarkerEdgeColor', ColorAB(k, :)); hold on;
    
end
subplot(5, 2, 9);
grid on;
hold off;
xlim([10^2, 10^7]);
xlabel('I_{exc} [W cm^{-2}]');
ylabel('\bullet t_{50%}, o - t_{95%} [ms]');
title('e)', 'Units', 'normalized', 'Position', [1, 1, 1]);

subplot(5, 2, [6,8,10]);
hold off;
grid on;
xlabel('Time [ms]');
ylabel('Intensity (cps)');
title('f)', 'Units', 'normalized', 'Position', [1, 1, 1]);

%% calculate statistics

spstat = subplot( 5, 2, 2);
title('statistics');
box on;
spstat.XTickLabel = '';
spstat.YTickLabel = '';
spstat.TickLength = [0 0];

[v,i] = max(TableDavsmooth);
DAVtext = sprintf('max \x0394_{AV} = %3.2f at I_{P}= %3.2f W/cm^2', TableDavsmooth(i), TableNsmooth(i,1));
[v,i] = max(TableNsmooth(:,2));
Ntext = sprintf('max N = %3.2f at I_{P}= %3.2f W/cm^2', TableNsmooth(i,2), TableNsmooth(i,1));
[v,i] = max([t_95{:}]);
Nr95text = sprintf('max t_{80%%} = %3.2f at I_{P}= %3.2f W/cm^2', v, power_rise{i});
[v,i] = max([t_50{:}]);
Nr50text = sprintf('max t_{50%%} = %3.2f at I_{P}= %3.2f W/cm^2', v, power_rise{i});
Thresholdtext = sprintf('Threshold at %3.2f W/cm^2', Threshold(1,1));
txt = {DAVtext, Ntext, Nr95text, Nr50text, Thresholdtext}; 
text( 0, 0.9, txt, 'VerticalAlignment', 'baseline', 'FontWeight', 'bold');
disp(DAVtext);
disp(Ntext);
disp(Nr95text );
disp(Nr50text );
disp(Thresholdtext);


figure('Name', 'Comparison data with fit and threshold');
loglog(pow_int(:,1), pow_int(:,2)); hold on;
loglog(TableN(:, 1), s_shape); hold on;
loglog(Threshold(1,1),Threshold(1,2),'o','Color','r','MarkerSize',10);
xlabel('Power density [W cm^{-2}]');
ylabel('Intensity [cps]');
legend('data','data smooth','threshold', 'Location','northwest');


