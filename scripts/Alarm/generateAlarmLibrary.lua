function priceNotify:generateAlarmLibrary()
  priceNotify.alarmLibrary = {
    ["Wheat"] = { threshold = 700, active = false, curMaxPrice = 0 },
    ["Barley"] = { threshold = 475, active = false, curMaxPrice = 0 },
    ["Canola"] = { threshold = 1300, active = false, curMaxPrice = 0 },
    ["Sunflowers"] = { threshold = 1100, active = false, curMaxPrice = 0 },
    ["Soybeans"] = { threshold = 1750, active = false, curMaxPrice = 0 },
    ["Corn"] = { threshold = 625, active = false, curMaxPrice = 0 },
    ["Potatoes"] = { threshold = 450, active = false, curMaxPrice = 0 },
    ["Sugar Beets"] = { threshold = 360, active = false, curMaxPrice = 0 },
    ["Manure"] = { threshold = 100, active = false, curMaxPrice = 0 },
    ["Liquid Manure"] = { threshold = 100, active = false, curMaxPrice = 0 },
    ["Wool"] = { threshold = 10000, active = false, curMaxPrice = 0 },
    ["Woodchips"] = { threshold = 600, active = false, curMaxPrice = 0 },
    ["Silage"] = { threshold = 99999, active = false, curMaxPrice = 0 },
    ["Straw"] = { threshold = 99999, active = false, curMaxPrice = 0 },
    ["Hay"] = { threshold = 99999, active = false, curMaxPrice = 0 },
    ["Grass"] = { threshold = 99999, active = false, curMaxPrice = 0 },
  };
end;
