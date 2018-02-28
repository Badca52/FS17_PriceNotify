function priceNotify:getStoredFruits()
	local fillInfo = {};

	-- Reset if we have stuff or not, so we don't display prices when we sold the beans ages ago.
	for fillT, infos in pairs(priceNotify.fillTypeInfo) do
		infos.gotSome = false;
		infos.maxPrice = 0;
	end;

	-- check silos
	for k, silo in pairs(g_currentMission.siloTriggers) do
		if silo ~= nil then
			for k, fillType in pairs(silo.fillTypes) do
				if silo.getFillLevel ~= nil then
					if silo:getFillLevel(fillType) > 0 then
						if priceNotify.fillTypeInfo[fillType] ~= nil then   -- modded silos or whatnot can screw this
							priceNotify.fillTypeInfo[fillType].gotSome = true;
						end;
					end;
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
								if priceNotify.fillTypeInfo[container.fillType] ~= nil then -- fuel traler or something can interfere
									priceNotify.fillTypeInfo[container.fillType].gotSome = true;
								end;
							end;
						end;
					end;
				end;
			end;
		end;
	end;

	-- check trains
	--fillInfo = {};
	--for k, train in pairs(priceNotify.trains) do
	--	if train.getFillLevelInformation ~= nil then
	--		train:getFillLevelInformation(fillInfo);
	--		if fillInfo ~= nil then
	--			for k, info in pairs(fillInfo) do
	--				if info.fillLevel > 0 then
	--					if priceNotify.fillTypeInfo[info.fillType] ~= nil then 		-- I dunno, maybe you put something crazy in your trian, bad boy/girl!
	--						priceNotify.fillTypeInfo[info.fillType].gotSome = true;
	--					end;
	--				end;
	--			end;
	--		end;
	--	end;
	end;

	-- check animals ... well sheep, I thought you have to sell milk, but turns out you don't (I should get into cow business)
	if g_currentMission.husbandries.sheep.totalNumAnimals > 0 then
		priceNotify.fillTypeInfo[FillUtil.FILLTYPE_WOOL].gotSome = true;
	end;
end;
