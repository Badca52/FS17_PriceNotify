fruits = {};

function fruits.load()
  print "Loading Stored Fruits"

  for i, shop in pairs(priceNotify.shops) do
    for fillType, v in pairs(shop.acceptedFillTypes) do
      if priceNotify.fillTypes[fillType] == nil then
        priceNotify.fillTypes[fillType] = {};
        priceNotify.fillTypes[fillType].maxPrice = 0;
        priceNotify.fillTypes[fillType].currentMaxPrice = 0;
        priceNotify.fillTypes[fillType].active = false;
        priceNotify.fillTypes[fillType].threshold = nil;
        priceNotify.fillTypes[fillType].hasSome = false;

        for j, silo in pairs(g_currentMission.siloTriggers) do

          if priceNotify.fillTypes[fillType].hasSome then break end;

      		if silo ~= nil then
      			for k, fill in pairs(silo.fillTypes) do
      				if silo.getFillLevel ~= nil then
                if silo:getFillLevel(k) > 0 then
                  if priceNotify.fillTypes[k] ~= nil then --Was seeing errors so added this.
                    priceNotify.fillTypes[k].hasSome = true;
                    break;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function fruits.update()

  for i, fillType in pairs(priceNotify.fillTypes) do
    for j, silo in pairs(g_currentMission.siloTriggers) do

      if silo ~= nil then
        for k, fillType in pairs(silo.fillTypes) do
          if silo.getFillLevel ~= nil then
            if silo:getFillLevel(fillType) > 0 then
              priceNotify.fillTypes[fillType].hasSome = true;
            else
              priceNotify.fillTypes[fillType].hasSome = false;
            end;
          end;
        end;
      end;
    end;
  end;
end;
