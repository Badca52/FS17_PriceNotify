priceLogger = {};

priceLogger.file = nil;
priceLogger.fileName = nil;
function priceLogger:open()
  priceLogger.fileName = getUserProfileAppPath() .. "modsSettings" .. "/" .. getTimeSec() .. "_" .. "priceLog.log";
  priceLogger.file = io.open(priceLogger.fileName, "w");
end;

function priceLogger:writeHeader()
  priceLogger.file:write("crop,price", "\n");
end;

function priceLogger:logPrice(crop, price)
  priceLogger.file:write(crop .. "," .. price, "\n");
end;

function priceLogger:close()
  priceLogger.file:close();
end;
