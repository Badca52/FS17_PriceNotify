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

			if priceNotify.fillTypes[fillT] ~= nil and priceNotify.fillTypes[fillT].threshold ~= nil and bestShop.mapHotspot ~= nil then
				priceNotify.fillTypes[fillT].curMaxPrice = math.floor(bestShop:getEffectiveFillTypePrice(fillT) * 1000);

				if priceNotify.fillTypes[fillT].curMaxPrice >= priceNotify.fillTypes[fillT].threshold and priceNotify.fillTypes[fillT].active == false then
					notificationDialog.show(bestShop.mapHotspot.fullViewName, g_i18n:getText(FillUtil.fillTypeIntToName[fillT]), priceNotify.fillTypes[fillT].curMaxPrice);
					priceNotify.fillTypes[fillT].active = true;
				end;

				if priceNotify.fillTypes[fillT].curMaxPrice < priceNotify.fillTypes[fillT].threshold then
					priceNotify.fillTypes[fillT].active = false;
				end;
			end;
	end;
end;
