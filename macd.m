function [macd] = macd(dataTable)
    N = size(dataTable,1);
    macd = zeros(N,1);
    for i = 1:N
        ema12 = ema(12, dataTable.Close, i);
        ema26 = ema(26, dataTable.Close, i);
        macd(i,1) = ema12-ema26;
    end
end