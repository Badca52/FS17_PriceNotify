function priceNotify:loadStoredFruits()
	local fillInfo = {};

	-- check silos
	for k, silo in pairs(g_currentMission.siloTriggers) do
		if silo ~= nil then
			for k, fillType in pairs(silo.fillTypes) do
				if silo.getFillLevel ~= nil then
					if silo:getFillLevel(fillType) > 0 then
						if priceNotify.fillTypes[fillType] == nil then
							priceNotify.fillTypes[fillType] = {};
							priceNotify.fillTypes[fillType].maxPrice = 0;
							priceNotify.fillTypes[fillType].shopName = "";
							priceNotify.fillTypes[fillType].trending = false;
						end;
					end;

					--if silo:getFillLevel(fillType) <= 0 then
					--	if priceNotify.fillTypes[fillType] ~= nil then
					--		table.remove(priceNotify.fillTypes, fillType);
					--	end;
					--end;

				end;
			end;
		end;
	end;

	-- check trailers
	for k, attachable in pairs(g_currentMission.attachables) do
		if attachable ~= nil then
			if attachable.typeDesc == "tipper" then
				if attachable.getFillLevelInformation ~= nil then
					attachable:getFillLevelInformation(fillInfo);
					if fillInfo ~= nil then
						for i, container in pairs(fillInfo) do
							if container.fillLevel > 0 then
								if priceNotify.fillTypes[fillType] == nil then
									priceNotify.fillTypes[fillType] = {};
									priceNotify.fillTypes[fillType].maxPrice = 0;
									priceNotify.fillTypes[fillType].shopName = "";
									priceNotify.fillTypes[fillType].trending = false;
								end;
							end;
						end;
					end;
				end;
			end;
		end;
	end;

	-- check trains
	fillInfo = {};
	for k, train in pairs(priceNotify.trains) do
		if train.getFillLevelInformation ~= nil then
			train:getFillLevelInformation(fillInfo);
			if fillInfo ~= nil then
				for k, info in pairs(fillInfo) do
					if info.fillLevel > 0 then
						if priceNotify.fillTypes[fillType] == nil then
							priceNotify.fillTypes[fillType] = {};
							priceNotify.fillTypes[fillType].maxPrice = 0;
							priceNotify.fillTypes[fillType].shopName = "";
							priceNotify.fillTypes[fillType].trending = false;
						end;
					end;
				end;
			end;
		end;
	end;

	-- check animals ... well sheep, I thought you have to sell milk, but turns out you don't (I should get into cow business)
	if g_currentMission.husbandries.sheep.totalNumAnimals > 0 then
		if priceNotify.fillTypes[FillUtil.FILLTYPE_WOOL] == nil then
			priceNotify.fillTypes[FillUtil.FILLTYPE_WOOL] = {};
			priceNotify.fillTypes[FillUtil.FILLTYPE_WOOL].maxPrice = 0;
			priceNotify.fillTypes[FillUtil.FILLTYPE_WOOL].shopName = "";
			priceNotify.fillTypes[FillUtil.FILLTYPE_WOOL].trending = false;
		end;
	end;
end;
