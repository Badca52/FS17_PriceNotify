gui = {};

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
  print("Settings Open")
  gui:superClass().onOpen(self)
end;

function gui:onClose()
  -- Not Yet Implemented
  print("Settings Close")
  gui:superClass().onClose(self)
end;

function gui:onCreate()
  print("Settings Create")
end;

function gui:save()
  -- Not Yet Implemented
  print("Settings Saving")
end;

function gui:onClickBack()
  print("Back Button Clicked")
  gui:superClass().onClickBack(self)
  g_gui:showGui("") -- this forces a gui:onClose event.
end;
