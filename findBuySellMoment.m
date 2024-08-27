function [buyMoment, sellMoment] = findBuySellMoment(macd1, signal1, dataTable)
    buyMoment = [];
    sellMoment = [];
    
    for i = 1:size(macd1, 1) - 1
        if macd1(i) > signal1(i) && macd1(i - 1) < signal1(i - 1)
            buyMoment(end + 1, 1) = i;
        elseif macd1(i) < signal1(i) && macd1(i - 1) > signal1(i - 1)
            sellMoment(end + 1, 1) = i;
        end
    end
end
