clear all
close all
format compact

filePath = './lpp.csv';

dataTable = readtable(filePath);

%%%%%%%%%%%%%%% CAŁY OKRES %%%%%%%%%%%%%%%%%%
%macd+signal+kupno/sprzedaz dla calosci danych

macdAll = macd(dataTable);
signalAll = signal(macdAll);

plot(dataTable.Date, macdAll(1:1000));
hold on;
plot(dataTable.Date, signalAll(1:1000));
hold off;

[buyMoment, sellMoment] = findBuySellMoment(macdAll, signalAll, dataTable);

plot(dataTable.Date, macdAll, "blue");
hold on
plot(dataTable.Date, signalAll, "red");
title("MACD i SIGNAL dla LPP");
legend("MACD", "SIGNAL", 'Location', 'eastoutside');

xlabel("Data");
ylabel("Wartość");
xlim([dataTable.Date(1,1), dataTable.Date(size(dataTable,1),1)]);
ylim([min(min(macdAll), min(signalAll))*1.1, max(max(macdAll), max(signalAll))*1.1]);

print('macd_signal_all.png', '-dpng');

hold on;
scatter(dataTable.Date(buyMoment(:,1)), signalAll(buyMoment(:,1)), "O", 'MarkerFaceColor', 'green');
scatter(dataTable.Date(sellMoment(:,1)), signalAll(sellMoment(:,1)), "O",'MarkerFaceColor', 'magenta');
legend("MACD", "SIGNAL", "Kupno","Sprzedaż", 'Location', 'eastoutside');
print('buy_sell_all.png', '-dpng');

%Notowania dla calosci danych

figure;
plot(dataTable.Date, dataTable.Close);
title("Notowania LPP");
xlabel("Data");
ylabel("Cena zamkniecia PLN");
xlim([dataTable.Date(1,1), dataTable.Date(size(dataTable,1),1)]);
ylim([min(dataTable.Close)*0.95, max(dataTable.Close)*1.05]);
print('notowania_all.png', '-dpng');

%symulacja pieniedzy dla calosci danych
[money,shares, moneyArr] = simulateTrading(dataTable, buyMoment, sellMoment);
figure;
plot(dataTable.Date, moneyArr);
title("Stan kapitału");
xlabel("Data");
ylabel("Wartosc kapitalu PLN");
print('kapital_all.png', '-dpng');


%%%%%%%%%%%%%%% WYBRANE DATY %%%%%%%%%%%%%%%%

%%%% pierwsze 100 dni %%%%

%macd+signal+kupno/sprzedaz dla wybranych dat

selectedData = dataTable(1:100, :);

selectedDates = selectedData.Date;
selectedClose = selectedData.Close;
selectedMacd = macd(selectedData);
selectedSignal = signal(selectedMacd);


[buyMomentSelected, sellMomentSelected] = findBuySellMoment(selectedMacd, selectedSignal, selectedData);

figure;
plot(selectedDates, selectedMacd);
hold on
plot(selectedDates, selectedSignal);
title("MACD i SIGNAL dla LPP 23.03.2020 - 12.08.2020");
xlabel("Data");
ylabel("Wartosc");
xlim([selectedDates(1,1), selectedDates(size(selectedDates,1),1)]);
ylim([min(min(selectedMacd), min(selectedSignal))*1.1, max(max(selectedMacd), max(selectedSignal))*1.1]);
legend("MACD", "SIGNAL", 'Location', 'eastoutside');

print('macd_signal_first_100.png', '-dpng');

hold on;
scatter(selectedDates(buyMomentSelected(:,1)), selectedSignal(buyMomentSelected(:,1)), "O", 'MarkerFaceColor', 'green');
scatter(selectedDates(sellMomentSelected(:,1)), selectedSignal(sellMomentSelected(:,1)), "O",'MarkerFaceColor', 'magenta');
legend("MACD", "SIGNAL", "Kupno","Sprzedaż", 'Location', 'eastoutside');

print('buy_sell_first_100.png', '-dpng');

%Notowania dla wybranych danych

figure;
plot(selectedDates, selectedClose);
title("Notowania LPP 23.03.2020 - 12.08.2020");
xlabel("Data");
ylabel("Cena zamkniecia PLN");
xlim([selectedDates(1), selectedDates(end)]);
ylim([min(dataTable.Close)*0.95, max(dataTable.Close)*1.05]);
print('notowania_first_100.png', '-dpng');

%symulacja pieniedzy dla wybranych dat

[moneySelected,sharesSelected, moneyArrSelected] = simulateTrading(selectedData, buyMomentSelected, sellMomentSelected);
figure;
plot(selectedDates, moneyArrSelected);
title("Stan kapitału 23.03.2020 - 12.08.2020");
xlabel("Data");
ylabel("Wartosc kapitalu PLN");
xlim([selectedDates(1,1), selectedDates(size(selectedDates,1),1)]);
ylim([min(moneyArrSelected)*0.95, max(moneyArrSelected)*1.05]);
print('kapital_first_100.png', '-dpng');




%%%% 09.11.2021 - 18.03.2022 %%%%

%macd+signal+kupno/sprzedaz dla wybranych dat

startDate = datetime(2021, 11, 09);
endDate = datetime(2022, 3, 18);

selectedIndexes = dataTable.Date >= startDate & dataTable.Date <= endDate;

selectedData = dataTable(selectedIndexes, :);

selectedDates = selectedData.Date;
selectedClose = selectedData.Close;
selectedMacd = macd(selectedData);
selectedSignal = signal(selectedMacd);

[buyMomentSelected, sellMomentSelected] = findBuySellMoment(selectedMacd, selectedSignal, selectedData);

figure;
plot(selectedDates, selectedMacd);
hold on
plot(selectedDates, selectedSignal);
title("MACD i SIGNAL dla LPP 09.11.2021 - 18.03.2022");
xlabel("Data");
ylabel("Wartosc");
xlim([selectedDates(1,1), selectedDates(size(selectedDates,1),1)]);
ylim([min(min(selectedMacd), min(selectedSignal))*1.1, max(max(selectedMacd), max(selectedSignal))*1.1]);
legend("MACD", "SIGNAL", 'Location', 'eastoutside');
print('macd_signal_selected.png', '-dpng');

hold on;
scatter(selectedDates(buyMomentSelected(:,1)), selectedSignal(buyMomentSelected(:,1)), "O", 'MarkerFaceColor', 'green');
scatter(selectedDates(sellMomentSelected(:,1)), selectedSignal(sellMomentSelected(:,1)), "O",'MarkerFaceColor', 'magenta');

legend("MACD", "SIGNAL", "Kupno","Sprzedaż", 'Location', 'eastoutside');
print('buy_sell_selected.png', '-dpng');

%Notowania dla wybranych danych

figure;
plot(selectedDates, selectedClose);
title("Notowania LPP 09.11.2021 - 18.03.2022");
xlabel("Data");
ylabel("Cena zamkniecia PLN");
xlim([selectedDates(1), selectedDates(end)]);
ylim([min(dataTable.Close)*0.95, max(dataTable.Close)*1.05]);
print('notowania_selected.png', '-dpng');

%symulacja pieniedzy dla wybranych dat

[moneySelected,sharesSelected, moneyArrSelected] = simulateTrading(selectedData, buyMomentSelected, sellMomentSelected);
figure;
plot(selectedDates, moneyArrSelected);
title("Stan kapitału 09.11.2021 - 18.03.2022");
xlabel("Data");
ylabel("Wartosc kapitalu PLN");
xlim([selectedDates(1,1), selectedDates(size(selectedDates,1),1)]);
ylim([min(moneyArrSelected)*0.95, max(moneyArrSelected)*1.05]);
print('kapital_selected.png', '-dpng');
