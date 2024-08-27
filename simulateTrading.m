function[money, actions, moneyArr] = simulateTrading(dataTableSim, buyMoment, sellMoment)
    nBuy = size(buyMoment,1);
    nSell = size(sellMoment,1);
    counterBuy = 1;
    counterSell = 1;
    moneyArr = zeros(1,size(dataTableSim,1));
    money = 0;
    actions = 1000;
     for i=1:size(dataTableSim,1)
        moneyArr(i) = money + actions*dataTableSim.Close(i);

        if(counterBuy<=nBuy || counterSell<=nSell)
            while(counterBuy<=nBuy && i> buyMoment(counterBuy,1))
                counterBuy = counterBuy+1;
            end
            while(counterSell<=nSell && i> sellMoment(counterSell,1))
                counterSell = counterSell+1;
            end
            
            %buy
            if(counterBuy < nBuy && i == buyMoment(counterBuy,1))
                if(money>0)
                    actions = floor(money / dataTableSim.Close(buyMoment(counterBuy,1)));
                    money = money - actions*dataTableSim.Close(buyMoment(counterBuy,1));
                end
                counterBuy = counterBuy + 1;
            end
    
            %sell
           if(counterSell < nSell && i == sellMoment(counterSell,1))
                if(actions>0)
                    money = money + actions*dataTableSim.Close(sellMoment(counterSell,1));
                    actions = 0;
                end
                counterSell = counterSell + 1;
            end
        end        
    end
end