priceNotify = {};
priceNotify.fillTypes = {};
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

-- XML
source(priceNotify.path .. 'scripts/Xml/xmlHandler.lua')

-- Load Crop Scripts
source(priceNotify.path .. 'scripts/Crops/fruits.lua')
source(priceNotify.path .. 'scripts/Crops/trains.lua')

-- Load Shop Scripts
source(priceNotify.path .. 'scripts/Shops/shops.lua')
source(priceNotify.path .. 'scripts/Shops/prices.lua')

-- Load Dialog Scripts
source(priceNotify.path .. 'scripts/Dialogs/notificationDialog.lua')

-- GUI
source(priceNotify.path .. 'scripts/Gui/gui.lua')

priceNotify.settingsGui = gui:new()
g_gui:loadGui(priceNotify.path .. "scripts/Gui/gui.xml", "priceNotifySettings", priceNotify.settingsGui)

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
  --Can all of this be in the load map? Should stop the before loading in popup
  if priceNotify.firstLoad then
    shops.load();
    trains.load();
    fruits.load();
    xmlHandler:load();
    xmlHandler.loadSettings();
    prices.update();
    priceNotify.firstLoad = false;
    print(g_currentMission:getIsServer());
    if self.showControlsInHelpScreen then
      --g_currentMission:addHelpButtonText(g_i18n:getText("input_PRICE_NOTIFY_SHOW_MENU"), InputBinding.PRICE_NOTIFY_SHOW_MENU, nil, GS_PRIO_VERY_LOW)
      g_currentMission:addHelpButtonText("Open Price Notify Settings", InputBinding.PRICE_NOTIFY_SHOW_MENU, nil, GS_PRIO_VERY_LOW)
    end

    --for i, prof in pairs(g_gui.profiles) do
      --print(prof.name)
      --for key,value in pairs(prof) do
      --	print( key, value )
      --end
    --end;
  end;

  -- Open the menu
  if InputBinding.hasEvent(InputBinding.PRICE_NOTIFY_SHOW_MENU) then
      g_gui:showGui("priceNotifySettings")
  end

	priceNotify.deltaT = priceNotify.deltaT + dt;
  if priceNotify.deltaT >= 10000 then  -- only update prices once every 10 seconds
		priceNotify.deltaT = 0;
    fruits.update();
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
