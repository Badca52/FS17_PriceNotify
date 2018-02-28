priceNotify = {};
priceNotify.fillTypes = {};
priceNotify.deltaT = 0;
priceNotify.shops = {};
priceNotify.firstLoad = true;

function priceNotify:loadMap(name)
	print("--- Price Notify loaded ---");
end;

function priceNotify:deleteMap()
end;

function priceNotify:keyEvent(unicode, sym, modifier, isDown)
end;

function priceNotify:mouseEvent(posX, posY, isDown, isUp, button)
end;

function priceNotify:update(dt)

	if priceNotify.firstLoad then

	-- collect shops
		for k, v in pairs(g_currentMission.tipTriggers) do
			if v ~= nil then
				if v.isEnabled ~= nil and v.isSellingPoint ~= nil then
					if v.isEnabled and v.isSellingPoint then
						table.insert(priceNotify.shops, v);
						-- we collect every fillType that you can sell somewhere
						for fillTK, v1 in pairs(v.acceptedFillTypes) do
							priceNotify.fillTypes[fillTK] = {};
							priceNotify.fillTypes[fillTK].gotSome = false;
							print(fillTK);
						end;
					end;
				end;
			end;
		end;

		priceNotify.firstLoad = false;
		end;

	priceNotify.deltaT = priceNotify.deltaT + dt;

	if priceNotify.deltaT >= 10000 then  -- only update prices once every 10 seconds
		priceNotify.deltaT = 0;

		priceNotify:getStoredFruits();

		print("updating fruits");
	end;
end;

function priceNotify:draw()
		setTextBold(false);
		setTextAlignment(RenderText.ALIGN_LEFT);
		setTextColor(1, 1, 1, 1);

		local lineCount = 0;
		local lineOffset = 0;
		local fontSize = g_currentMission.moneyTextSize;
		local lineDist = fontSize + 0.002;

		for fillType, info in pairs(priceNotify.fillTypes) do
			if info.gotSome then
				lineOffset = lineCount * .05;
				lineOffset = lineOffset + .3;
				line = g_i18n:getText(FillUtil.fillTypeIntToName[fillType]);
				renderText(.5, lineOffset, fontSize, line);

				lineCount = lineCount + 1;
			end;
		end;
end;

function priceNotify:getStoredFruits()
	local fillInfo = {};

	-- Reset if we have stuff or not, so we don't display prices when we sold the beans ages ago.
	for fillT, infos in pairs(priceNotify.fillTypes) do
		infos.gotSome = false;
	end;

	-- check silos
	for k, silo in pairs(g_currentMission.siloTriggers) do
		if silo ~= nil then
			for k, fillType in pairs(silo.fillTypes) do
				if silo.getFillLevel ~= nil then
					if silo:getFillLevel(fillType) > 0 then
						if priceNotify.fillTypes[fillType] ~= nil then   -- modded silos or whatnot can screw this
							priceNotify.fillTypes[fillType].gotSome = true;
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
								if priceNotify.fillTypes[container.fillType] ~= nil then -- fuel traler or something can interfere
									priceNotify.fillTypes[container.fillType].gotSome = true;
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
	--					if priceNotify.fillTypes[info.fillType] ~= nil then 		-- I dunno, maybe you put something crazy in your trian, bad boy/girl!
	--						priceNotify.fillTypes[info.fillType].gotSome = true;
	--					end;
	--				end;
	--			end;
	--		end;
	--	end;
	--end;

	-- check animals ... well sheep, I thought you have to sell milk, but turns out you don't (I should get into cow business)
	if g_currentMission.husbandries.sheep.totalNumAnimals > 0 then
		priceNotify.fillTypes[FillUtil.FILLTYPE_WOOL].gotSome = true;
	end;
end;


addModEventListener(priceNotify);
