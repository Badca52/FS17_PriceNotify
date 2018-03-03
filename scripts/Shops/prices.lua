prices = {}

function prices.update()

	-- go through the list of fillTypes that sellplaces accept
	for fillT, info in pairs(priceNotify.fillTypes) do

			local bestShop = nil;
			-- go through shops to get prices
			for k, shop in pairs(priceNotify.shops) do


				if shop.acceptedFillTypes[fillT] ~= nil then  -- if shop buys our shit
					if bestShop == nil then
						bestShop = shop;
					end;
					if bestShop.mapHotspot ~= nil then
						if bestShop.mapHotspot.fullViewName ~= nil then
							if bestShop.pricingDynamics ~= nil then
								if bestShop.pricingDynamics[fillT] ~= nil then
										shopPrice = math.floor(shop:getEffectiveFillTypePrice(fillT) * 1000);
										if shopPrice > math.floor(bestShop:getEffectiveFillTypePrice(fillT) * 1000) then
											bestShop = shop;
									end;
								end;
							end;
						end;
					end;
				end;
			end;

			local cropName = g_i18n:getText(FillUtil.fillTypeIntToName[fillT]);

			if priceNotify.alarmLibrary[cropName] ~= nil then
				priceNotify.alarmLibrary[cropName].curMaxPrice = math.floor(bestShop:getEffectiveFillTypePrice(fillT) * 1000);

				if priceNotify.alarmLibrary[cropName].curMaxPrice >= priceNotify.alarmLibrary[cropName].threshold and priceNotify.alarmLibrary[cropName].active == false then
					notificationDialog.show(bestShop.mapHotspot.fullViewName, g_i18n:getText(FillUtil.fillTypeIntToName[fillT]), priceNotify.alarmLibrary[cropName].curMaxPrice);
					priceNotify.alarmLibrary[cropName].active = true;
				end;

				if priceNotify.alarmLibrary[cropName].curMaxPrice < priceNotify.alarmLibrary[cropName].threshold then
					priceNotify.alarmLibrary[cropName].active = false;
				end;
			end;
	end;
end;
