function [signal] = signal(data)
    N = size(data,1);
    signal = zeros(N,1);

    for i=1:N
        signal(i,1) = ema(9, data, i);
    end
end