function priceNotify:showNotificationDialog(shop, fruit, price)
    local msg = fruit .. " - $" .. price;
    g_gui:showYesNoDialog({
        text = msg,
        title = shop,
        dialogType = DialogElement.TYPE_INFO,
        callback = cb,
        target = self,
        yesText = "Ok",
        noText = "Dismiss"
    });

end;
