function priceNotify:updatePrices()
	local curPrice = 0;

	-- go through the list of fillTypes that sellplaces accept
	for fillT, info in pairs(priceNotify.fillTypes) do
			-- go through shops to get prices
			for k, shop in pairs(priceNotify.shops) do
				if shop.acceptedFillTypes[fillT] ~= nil then  -- if shop buys our shit
					curPrice = shop:getEffectiveFillTypePrice(fillT);
          curPrice = math.floor(curPrice*1000);

					-- if the shop offers more price than the currently stored price, refresh info
					if curPrice > info.maxPrice then
						info.maxPrice = curPrice;
						if shop.mapHotspot ~= nil then
							if shop.mapHotspot.fullViewName ~= nil then
								info.shopName = shop.mapHotspot.fullViewName;
                if shop.pricingDynamics ~= nil then
    							if shop.pricingDynamics[fillT] ~= nil then
    								info.trending = shop.pricingDynamics[fillT]:getBaseCurveTrend() == PricingDynamics.TREND_CLIMBING;
										--priceNotify:showNotificationDialog(info.shopName, g_i18n:getText(FillUtil.fillTypeIntToName[fillT]), info.maxPrice);

										-- Only Check Corn for Now
                    if g_i18n:getText(FillUtil.fillTypeIntToName[fillT]) == "Corn" then
                      if info.maxPrice >= priceNotify.alarmLibrary[0].threshold and priceNotify.alarmLibrary[0].active == false then
                        priceNotify:showNotificationDialog(info.shopName, g_i18n:getText(FillUtil.fillTypeIntToName[fillT]), info.maxPrice);
                        priceNotify.alarmLibrary[0].active = true;
                      end;

                      if info.maxPrice < priceNotify.alarmLibrary[0].threshold then
                        priceNotify.alarmLibrary[0].active = false;
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

end;
