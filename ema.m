function [ema] = ema(N, data1, number)   
    
    alfa = 2 / (N+1);
    mianownik = 0;
    
    licznik = 0;
    if(number<=N)
        counter = 0;
        for i = number:-1:1
            p = data1(i,1);
            licznik = licznik + p*(1-alfa)^(counter);
            counter = counter + 1;
        end
        for i = 1:number
            mianownik = mianownik + (1-alfa)^(i-1);
        end
    else
        counter = 0;
        for i = number:-1:number-N
            p = data1(i,1);
            licznik = licznik + p*(1-alfa)^(counter);
            counter = counter + 1;
        end
        for i = 0:N
            mianownik = mianownik + (1-alfa)^i;
        end
    end
    ema = licznik/mianownik;
end