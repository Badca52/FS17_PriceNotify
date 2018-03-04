xmlHandler = {}
local xmlFile

--load xml
function xmlHandler:load()
  print "Loading XML File"
  -- following 'DeckerMMIV' and creating a modsSettings folder
  local folder = getUserProfileAppPath() .. "modsSettings";
  local tag = "priceNotify";

  local xmlFileName = folder .. "/" .. "priceNotify.xml";

  if fileExists(xmlFileName) then
    xmlFile = loadXMLFile(tag, xmlFileName);
    if xmlFile ~= nil then
      local version = getXMLString(xmlFile, "priceNotify#version");
      print(version);
    else
      print "XML file failed to load"
    end
  else
    print "XML file does not exist"
    --create it
    self:create();
  end

  return xmlFile;
end;

--create xml if not exist
function xmlHandler:create()
  print "Let's Create a default XML";

  local folder = getUserProfileAppPath() .. "modsSettings";
  local tag = "priceNotify";

  local xmlFileName = folder .. "/" .. "priceNotify.xml";

  xmlFile = createXMLFile("priceNotify.xml", xmlFileName, "priceNotify");
  saveXMLFile(xmlFile);
  if fileExists(xmlFileName) then
    if xmlFile ~= nil then
      setXMLString(xmlFile, "priceNotify#version", "0.1.0.1"); -- Use code for this

      for k, fillType in pairs(priceNotify.fillTypes) do
        local tag = "priceNotify.fillyTypes.fillType" .. tostring(k);
        setXMLString(xmlFile, tag .. "#readOnlyName" ,  g_i18n:getText(FillUtil.fillTypeIntToName[k]))
        setXMLString(xmlFile, tag .. "#threshold", "");
      end

      saveXMLFile(xmlFile);
      print "XML Created";
    else
      print "Newly Created XML file failed to load";
    end
  else
    print "Newly Created XML file does not exist";
  end
end;

--load settings
function xmlHandler.loadSettings()
  for k, fillType in pairs(priceNotify.fillTypes) do
    local tag = "priceNotify.fillyTypes.fillType" .. tostring(k);
    if hasXMLProperty(xmlFile, tag .. "#threshold") then
      val = getXMLInt(xmlFile, tag .. "#threshold");
      if val == 0 then threshold = nil else threshold = val end;
      fillType.threshold = threshold
    else
      setXMLString(xmlFile, tag .. "#readOnlyName" ,  g_i18n:getText(FillUtil.fillTypeIntToName[k]))
      setXMLString(xmlFile, tag .. "#threshold", "");
      fillType.threshold = nil
      saveXMLFile(xmlFile);
    end
  end
  --for testing
  for k, fillType in pairs(priceNotify.fillTypes) do
    print(g_i18n:getText(FillUtil.fillTypeIntToName[k]) .. ": " .. Utils.getNoNil(fillType.threshold, ""));
  end
end;

--save settings -WIP
function xmlHandler.save()
  for k, fillType in pairs(priceNotify.fillTypes) do
    local tag = "priceNotify.fillyTypes.fillType" .. tostring(k);
    setXMLString(xmlFile, tag .. "#readOnlyName" ,  g_i18n:getText(FillUtil.fillTypeIntToName[k]))
    setXMLInt(xmlFile, tag .. "#threshold", Utils.getNoNil(fillType.threshold, ""));
  end
end;
