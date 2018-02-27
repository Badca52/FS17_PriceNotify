priceNotify = {};

addModEventListener(priceNotify);

priceNotify = {
    text: "PriceNotify v0.1"
};

function priceNotify:loadMap()

	print("--- Price Watch loaded ---");
	
end;

function priceNotify:keyEvent(unicode, sym, modifier, isDown)
end;

function priceNotify:mouseEvent(posX, posY, isDown, isUp, button)
end;

function priceNotify:deleteMap()
end;

function priceNotify:update(dt)
	renderText(.5, .5, g_currentMission.moneyTextSize, priceNotify.text);
end;