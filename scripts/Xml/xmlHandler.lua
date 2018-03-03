xmlHandler = {}

--load settings
function xmlHandler.load()
  print "Loading XML File"
  -- following 'DeckerMMIV' and creating a modsSettings folder
  local folder = getUserProfileAppPath() .. "modsSettings";
  local tag = "priceNotify";

  local xmlFileName = folder .. "/" .. "priceNotify.xml";
  local xmlFile

  print(xmlFileName);

  if fileExists(xmlFileName) then
    print(tag);
    xmlFile = loadXMLFiLe(tag, xmlFileName);
    if xmlFile ~= nil then
      local version = getXMLInt(xmlFile, "priceNotify#version");
      print(version);
    else
      print "XML file did not load"
    end
  else
    print "XML file does not exist"
  end

  return xmlFile;
end;

--create if not exist
function xmlHandler.create()

end;

--save settings
function xmlHandler.save()

end;
