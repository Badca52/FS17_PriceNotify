priceNotify = {};
priceNotify.fillTypes = {};
priceNotify.deltaT = 0;
priceNotify.shops = {};
priceNotify.firstLoad = true;
priceNotify.path = g_currentModDirectory;
if priceNotify.path:sub(-1) ~= '/' then
    priceNotify.path = priceNotify.path .. '/';
end;
priceNotify.modName = g_currentModName;
priceNotify.dialog = {};

-- Load scripts
source(priceNotify.path .. 'scripts/Crops/getStoredFruits.lua')

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
		g_gui:closeAllDialogs();
		g_gui:showYesNoDialog({
        text = "Yep, my dialog works!",
        title = g_i18n:getText("title"),
        dialogType = DialogElement.TYPE_INFO,
        callback = cb,
        target = self,
        yesText = "Ok",
        noText = "Ok"
    });
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

		priceNotify:getStoredFruits();
		priceNotify.firstLoad = false;
		end;

	priceNotify.deltaT = priceNotify.deltaT + dt;

	if priceNotify.deltaT >= 10000 then  -- only update prices once every 10 seconds
		priceNotify.deltaT = 0;

		-- Green text in top right corner
		g_currentMission:addIngameNotification(FSBaseMission.INGAME_NOTIFICATION_OK, g_i18n:getText("title"));


		--Gui.showMessageDialog(g_i18n:getText("title"));
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

addModEventListener(priceNotify);
