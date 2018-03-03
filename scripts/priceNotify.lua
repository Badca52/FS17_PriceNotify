priceNotify = {};
priceNotify.fillTypes = {};
priceNotify.alarmLibrary = {};
priceNotify.deltaT = 0;
priceNotify.shops = {};
priceNotify.trains = {};
priceNotify.firstLoad = true;
priceNotify.path = g_currentModDirectory;
if priceNotify.path:sub(-1) ~= '/' then
    priceNotify.path = priceNotify.path .. '/';
end;
priceNotify.modName = g_currentModName;
priceNotify.dialog = {};

-- Load Alarm scripts
source(priceNotify.path .. 'scripts/Alarm/alarmLibrary.lua')

-- Load Crop Scripts
source(priceNotify.path .. 'scripts/Crops/storedFruits.lua')
source(priceNotify.path .. 'scripts/Crops/trains.lua')

-- Load Shop Scripts
source(priceNotify.path .. 'scripts/Shops/shops.lua')
source(priceNotify.path .. 'scripts/Shops/prices.lua')

-- Load Dialog Scripts
source(priceNotify.path .. 'scripts/Dialogs/notificationDialog.lua')

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
    alarmLibrary.load();
    print(priceNotify.alarmLibrary);
    shops.load();
    trains.load();
    storedFruits.load()
    prices.update();
    priceNotify.firstLoad = false;
  end;

	priceNotify.deltaT = priceNotify.deltaT + dt;
	if priceNotify.deltaT >= 10000 then  -- only update prices once every 10 seconds
		priceNotify.deltaT = 0;
    storedFruits.load();
    prices.update();
	end;
end;

function priceNotify:draw()
		setTextBold(false);
		setTextAlignment(RenderText.ALIGN_LEFT);
		setTextColor(1, 1, 1, 1);

		--local lineCount = 0;
		--local lineOffset = 0;
		--local fontSize = g_currentMission.moneyTextSize;
		--local lineDist = fontSize + 0.002;

		--for fillType, info in pairs(priceNotify.fillTypes) do
				--lineOffset = lineCount * .05;
				--lineOffset = lineOffset + .3;
				--line = g_i18n:getText(FillUtil.fillTypeIntToName[fillType]);
				--renderText(.5, lineOffset, fontSize, line);

				--lineCount = lineCount + 1;
		--end;
end;



addModEventListener(priceNotify);
