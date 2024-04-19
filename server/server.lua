RegisterNetEvent('panicButtonPressed')
AddEventHandler('panicButtonPressed', function(streetName)
    local source = source
    local identifiers = GetPlayerIdentifiers(source)

    local discordId
    for i = 1, #identifiers do
        if string.sub(identifiers[i], 1, string.len("discord:")) == "discord:" then
            discordId = string.gsub(identifiers[i], 'discord:', '')
            break
        end
    end

    if discordId == nil then
        if ServerConfig.Debug then
            print("No linked Discord account found.")
        end
        return
    end

    local headers = {
        ['Content-Type'] = 'application/json',
        ['token'] = ServerConfig.ApiKey
    }

    local body = {
        ['user_id'] = discordId,
        ['location'] = streetName,
        ['is_panic'] = true
    }

    PerformHttpRequest(ServerConfig.ApiUrl, function(err, text, headers)
        if ServerConfig.Debug then
            print(text)
        end
    end, 'POST', json.encode(body), headers)
end)

RegisterNetEvent('panicButtonUnpressed')
AddEventHandler('panicButtonUnpressed', function(streetName)
    local source = source
    local identifiers = GetPlayerIdentifiers(source)

    local discordId
    for i = 1, #identifiers do
        if string.sub(identifiers[i], 1, string.len("discord:")) == "discord:" then
            discordId = string.gsub(identifiers[i], 'discord:', '')
            break
        end
    end

    if discordId == nil then
        if ServerConfig.Debug then
            print("No linked Discord account found.")
        end
        return
    end

    local headers = {
        ['Content-Type'] = 'application/json',
        ['token'] = ServerConfig.ApiKey
    }

    local body = {
        ['user_id'] = discordId,
        ['location'] = streetName,
        ['is_panic'] = false
    }

    PerformHttpRequest(ServerConfig.ApiUrl, function(err, text, headers)
        if ServerConfig.Debug then
            print(text)
        end
    end, 'POST', json.encode(body), headers)
end)

