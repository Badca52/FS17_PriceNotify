priceNotify = {};

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
end;

function priceNotify:draw()
    renderText(.5, .5, g_currentMission.moneyTextSize, g_i18n:getText("title"));
end;

addModEventListener(priceNotify);