---@diagnostic disable: param-type-mismatch
AddEventHandler("playerConnecting", function (name, setKickReason, deferrals)
    local src = source
    deferrals.defer()
    deferrals.update("Checking bans...")

    local identifiers = Utils.getPlayerIdentifiersObject(src)

    PerformHttpRequest('http://localhost:3000/bans/identifiers', function (status, response)
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

RegisterCommand("kh-ban", function (source, args)
    local src = source

    if src ~= 0 and not IsPlayerAceAllowed(src, "admin") then
        TriggerClientEvent("chat:addMessage", src, { args = { "^1SYSTEM", "You do not have permission" } })
        return
    end

    local targetId = tonumber(args[1])
    local reason = table.concat(args, " ", 2)
    local expiresAt

    if not targetId  then
        if src ~= 0 then
            TriggerClientEvent("chat:addMessage", src, { args = { "^1SYSTEM", "Usage: /ban [playerId] [reason]" } })
        else
            print("^1SYSTEM: Usage: /ban [playerId] [reason]")
            
        end
        return
    end

    if not GetPlayerName(targetId)  then
        if src ~= 0 then
            TriggerClientEvent("chat:addMessage", src, { args = { "^1SYSTEM", "Invalid player ID" } })
        else
            print("^1SYSTEM: Invalid player ID")
        end
        return
    end

    local identifiers = Utils.getPlayerIdentifiersObject(targetId)
    local body = {
        reason = reason or "No reason provided",
        expiresAt = expiresAt or nil
    }

    for key, value in pairs(identifiers) do
        body[key] = value
    end

    PerformHttpRequest("http://localhost:3000/bans", function (status, response)
        if status == 201 then
            local banMessage = "You have been banned: " .. body.reason
            if body.expiresAt then
                banMessage = banMessage .. " (expires at " .. body.expiresAt .. ")"
            end

            DropPlayer(targetId, banMessage)

            if src ~= 0 then
                TriggerClientEvent("chat:addMessage", src, { args = { "^2SYSTEM", "Player banned successfully" } })
            else
                print("^2SYSTEM:", "Player banned successfully")
            end            
        else
            if src ~= 0 then
                TriggerClientEvent("chat:addMessage", src, { args = { "^1SYSTEM", "Error banning player: " .. response } })
            else
                print("^1SYSTEM: Error banning player: " .. tostring(response))
            end
        end
    end, 'POST', json.encode(body), { ["Content-Type"] = "application/json" })
end, false)