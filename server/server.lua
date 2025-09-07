local utils = require('utils')

AddEventHandler("playerConnecting", function (name, setKickReason, deferrals)
    local src = source
    deferrals.defer()
    deferrals.update("Checking bans...")

    local identifiers = utils.getPlayerIdentifiersObject(src)

    PerformHttpRequest('http://localhost:3000/ban/identifiers', function (status, response)

        if status == 404 then
            -- NO BAN 
            deferrals.done()
            return
        elseif status == 200 then
            local ok, data = pcall(json.decode, response)
            if not ok or not data then
                deferrals.done("Error decoding server response")
                return
            end

            if data.isExpired == false then
                deferrals.done("You are banned: " .. (data.reason or "No reason provided"))
                return
            else
                deferrals.done()
                return
            end
        else
            deferrals.done("Error contacting ban server")
            return
        end

    end, 'POST', json.encode(identifiers), { ['Content-Type'] = 'application/json' })
end)