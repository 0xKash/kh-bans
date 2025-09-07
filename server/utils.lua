local utils = {}

function utils.getPlayerIdentifiersObject(source)
    local playerIdentifiers = GetPlayerIdentifiers(source)
    local steam, license, xbl, discord, ip, fivem, hardware

    for _, id in ipairs(playerIdentifiers) do
        if string.find(id, "steam:") then steam = id end
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
    if xbl then identifiers.xbl = xbl end
    if discord then identifiers.discord = discord end
    if ip then identifiers.ip = ip end
    if fivem then identifiers.fivem = fivem end
    if hardware then identifiers.hardware = hardware end

    return identifiers

end

return utils