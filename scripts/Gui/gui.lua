gui = {};
gui.settingsElements = {}

local gui_mt = Class(gui, ScreenElement)

function gui:new(target, custom_mt)
  print("Initalizing Settings Object")
  if custom_mt == nil then
  		custom_mt = gui_mt
	end
  local self = ScreenElement:new(target, custom_mt)

  --This is where we can initialize settings
  return self
end;

function gui:onOpen()
  -- Not Yet Implemented
  print("Settings Open");
  gui:superClass().onOpen(self)
end;

function gui:onClose()
  print("Settings Close");
  gui:save(self)
  gui:superClass().onClose(self)
end;

function gui:onCreate()
  print("Settings Create")
end;

function gui:save()
  print("Settings Saving");
  for i, element in pairs(self.settingsElements) do
    local fillType = tonumber(string.match(element.id, "(%d+)"))
    print("Fill Type ID: " .. fillType);
    print("Before threshold: " .. priceNotify.fillTypes[fillType].threshold);
    if priceNotify.fillTypes ~= nil and priceNotify.fillTypes[fillType] ~= nil then
      priceNotify.fillTypes[fillType].threshold = tonumber(element.text)
      priceNotify.fillTypes[fillType].active = false
    end;
    print("After threshold: " .. priceNotify.fillTypes[fillType].threshold);
  end;
  xmlHandler.save()
end;

function gui:onClickBack()
  print("Back Button Clicked")
  gui:superClass().onClickBack(self)
  g_gui:showGui("") -- this forces a gui:onClose event.
  prices.update();
end;

function gui:onCreateElement(element)
  --fillType = tonumber(string.match(element.id, "(%d+)"))
  --self.settingsElements[fillType] = element
  --Might not need these ^^^
  table.insert(self.settingsElements, element)
end;
