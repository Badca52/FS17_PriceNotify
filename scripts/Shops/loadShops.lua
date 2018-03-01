function priceNotify:loadShops()
  for k, v in pairs(g_currentMission.tipTriggers) do
    if v ~= nil then
      if v.isEnabled ~= nil and v.isSellingPoint ~= nil then
        if v.isEnabled and v.isSellingPoint then
          table.insert(priceNotify.shops, v);
        end;
      end;
    end;
  end;

end;
