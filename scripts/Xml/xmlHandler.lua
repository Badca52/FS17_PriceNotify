xmlHandler = {}

--load settings
function xmlHandler:load()
  print "Loading XML File"
  -- following 'DeckerMMIV' and creating a modsSettings folder
  local folder = getUserProfileAppPath() .. "modsSettings";
  local tag = "priceNotify";

  local xmlFileName = folder .. "/" .. "priceNotify.xml";
  local xmlFile

  print(xmlFileName);

  if fileExists(xmlFileName) then
    print(tag);
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

--create if not exist
function xmlHandler:create()
  print "Let's Create a default XML"

  local defaultFolder = priceNotify.path;
  local defaultXmlFileName = defaultFolder .. "/" .. "defaultConfig.xml";

  local folder = getUserProfileAppPath() .. "modsSettings";
  local tag = "priceNotify";

  local xmlFileName = folder .. "/" .. "priceNotify.xml";
  local xmlFile

  local defaultConfig = io.open(defaultXmlFileName, "w");
  if defaultConfig == nil then
      print("File may be locked or read-only " .. defaultXmlFileName);
  else
    local contents = defaultConfig:read("*a")
    defaultConfig = nil
    newConfig = io.open(xmlFileName, "w")
    newConfig:write(contents)
    newConfig:close()
    newConfig = nil
  end

end;

--save settings
function xmlHandler.save()

end;
