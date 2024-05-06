RegisterNetEvent('cc-panic:panicButtonPressed')
AddEventHandler('cc-panic:panicButtonPressed', function(streetName)
    local source = source
    local identifiers = GetPlayerIdentifiers(source)

    local discordId
    for i, identifier in ipairs(identifiers) do
        if string.sub(identifier, 1, 8) == "discord:" then
            discordId = string.sub(identifier, 9)
            break
        end
    end

    if discordId == nil then
        if Config.Debug then
            print("No linked Discord account found.")
        end
        return
    end

    local headers = {
        ['Content-Type'] = 'application/json',
        ['token'] = Config.ApiKey
    }

    local body = {
        ['user_id'] = discordId,
        ['location'] = streetName,
        ['is_panic'] = true
    }

    PerformHttpRequest(Config.ApiUrl, function(err, text, headers)
        if Config.Debug then
            print(text)
        end
    end, 'POST', json.encode(body), headers)
end)


RegisterNetEvent('cc-panic:panicButtonUnpressed')
AddEventHandler('cc-panic:panicButtonUnpressed', function(streetName)
    local source = source
    local identifiers = GetPlayerIdentifiers(source)

    local discordId
    for i, identifier in ipairs(identifiers) do
        if string.sub(identifier, 1, 8) == "discord:" then
            discordId = string.sub(identifier, 9)
            break
        end
    end

    if not discordId then
        if Config.Debug then
            print("No linked Discord account found.")
        end
        return
    end

    local headers = {
        ['Content-Type'] = 'application/json',
        ['token'] = Config.ApiKey
    }

    local body = {
        ['user_id'] = discordId,
        ['location'] = streetName,
        ['is_panic'] = false
    }

    PerformHttpRequest(Config.ApiUrl, function(err, text, headers)
        if Config.Debug then
            print(text)
        end
    end, 'POST', json.encode(body), headers)
end)


if Config.enableSonoranRadio then
    RegisterNetEvent('SonoranCAD::callcommands:SendPanicApi')
    AddEventHandler('SonoranCAD::callcommands:SendPanicApi', function()
        local playerId = source
        local detailedLocation = ""

        TriggerClientEvent('cc-panic:getDetailedLocation', playerId)

        RegisterServerEvent('cc-panic:greceiveDetailedLocation')
        AddEventHandler('cc-panic:greceiveDetailedLocation', function(location)
            detailedLocation = location

            -- Proceed with sending panic API request with detailedLocation data
            local identifiers = GetPlayerIdentifiers(playerId)
            local discordId
            for _, identifier in ipairs(identifiers) do
                if string.sub(identifier, 1, 8) == "discord:" then
                    discordId = string.sub(identifier, 9)
                    break
                end
            end

            if discordId then
                local headers = {
                    ['Content-Type'] = 'application/json',
                    ['token'] = Config.ApiKey
                }
                local body = {
                    ['user_id'] = discordId,
                    ['location'] = detailedLocation,
                    ['is_panic'] = true
                }

                PerformHttpRequest(Config.ApiUrl, function(err, text, headers)
                    if Config.Debug then
                        print(text)
                    end
                end, 'POST', json.encode(body), headers)
            else
                if Config.Debug then
                    print("No linked Discord account found for player ID:", playerId)
                end
            end
            TriggerClientEvent('cc-panic:handlePanicEvent', -1, playerId)
        end)
    end)
end
