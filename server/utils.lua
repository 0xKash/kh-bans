Utils = {}

function Utils.getPlayerIdentifiersObject(source)
    local playerIdentifiers = GetPlayerIdentifiers(source)
    local steam, license, license2, xbl, discord, ip, fivem, hardware

    for _, id in ipairs(playerIdentifiers) do
        if string.find(id, "steam:") then steam = id end
        if string.find(id, "license2:") then license2 = id end
        if string.find(id, "license:") then license = id end
        if string.find(id, "xbl:") then xbl = id end
        if string.find(id, "discord:") then discord = id end
        if string.find(id, "ip:") then ip = id end
        if string.find(id, "fivem:") then fivem = id end
        if string.find(id, "hardware:") then hardware = id end
    end

    local identifiers = {}
    if steam then identifiers.steam = steam end
    if license then identifiers.license = license end
    if license2 then identifiers.license2 = license2 end
    if xbl then identifiers.xbl = xbl end
    if discord then identifiers.discord = discord end
    if ip then identifiers.ip = ip end
    if fivem then identifiers.fivem = fivem end
    if hardware then identifiers.hardware = hardware end

    return identifiers
end

function Utils.parseDurationToISO(str)
   if not str then return nil end

    local value, unit = str:match("^(%d+)([dmy])$")
    if not value or not unit then return nil end

    value = tonumber(value)

    local seconds = 0
    if unit == "d" then
        seconds = value * 24 * 60 * 60
    elseif unit == "m" then
        seconds = value * 30 * 24 * 60 * 60
    elseif unit == "y" then
        seconds = value * 365 * 24 * 60 * 60
    end

    local unix = os.time() + seconds
    return os.date("%Y-%m-%dT%H:%M:%SZ", unix)
end