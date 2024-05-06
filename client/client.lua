function triggerPanic()
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    local detailedLocation = ""

    if Config.StreetName then
        local streetHash = GetStreetNameAtCoord(x, y, z)
        local streetName = GetStreetNameFromHashKey(streetHash)
        detailedLocation = streetName
    end

    if Config.CrossingRoadName then
        local _, crossingRoadHash = GetStreetNameAtCoord(x, y, z)
        if crossingRoadHash ~= 0 then
            local crossingRoadName = GetStreetNameFromHashKey(crossingRoadHash)
            detailedLocation = detailedLocation .. " & " .. crossingRoadName
        end
    end

    if Config.ZoneName then
        local zoneName = GetNameOfZone(x, y, z)
        detailedLocation = detailedLocation .. ", " .. zoneName
    end

    if Config.PostalName then
        local postal = exports['nearest-postal']:getPostal()
        if postal ~= nil then
            detailedLocation = detailedLocation .. ", Postal: " .. postal
        end
    end

    TriggerServerEvent('cc-panic:panicButtonPressed', detailedLocation)
    TriggerEvent('chat:addMessage', {
        color = { 255, 0, 0 },
        multiline = true,
        args = { "[PANIC]", "You have pressed your panic button!" }
    })
end

RegisterCommand('panic', triggerPanic, false)

function triggerStopPanic()
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    local detailedLocation = ""

    if Config.StreetName then
        local streetHash = GetStreetNameAtCoord(x, y, z)
        local streetName = GetStreetNameFromHashKey(streetHash)
        detailedLocation = streetName
    end

    if Config.CrossingRoadName then
        local _, crossingRoadHash = GetStreetNameAtCoord(x, y, z)
        if crossingRoadHash ~= 0 then
            local crossingRoadName = GetStreetNameFromHashKey(crossingRoadHash)
            detailedLocation = detailedLocation .. " & " .. crossingRoadName
        end
    end

    if Config.ZoneName then
        local zoneName = GetNameOfZone(x, y, z)
        detailedLocation = detailedLocation .. ", " .. zoneName
    end

    if Config.PostalName then
        local postal = exports['nearest-postal']:getPostal()
        if postal ~= nil then
            detailedLocation = detailedLocation .. ", Postal: " .. postal
        end
    end

    TriggerServerEvent('cc-panic:panicButtonUnpressed', detailedLocation)
    TriggerEvent('chat:addMessage', {
        color = { 255, 0, 0 },
        multiline = true,
        args = { "[PANIC]", "You have cleared your panic button!" }
    })
end

RegisterCommand('stop_panic', triggerStopPanic, false)


if Config.enableSonoranRadio then
    RegisterNetEvent('cc-panic:handlePanicEvent')
    AddEventHandler('cc-panic:handlePanicEvent', function(playerId)
        -- Using the same chat message for both the triggering player and others
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},  -- Red color for alert messages
            multiline = true,
            args = {"[PANIC]", "You have pressed your panic button!"}
        })
    end)

    RegisterNetEvent('cc-panic:getDetailedLocation')
    AddEventHandler('cc-panic:getDetailedLocation', function()
        local detailedLocation = ""

        if Config.StreetName then
            local streetHash = GetStreetNameAtCoord(x, y, z)
            local streetName = GetStreetNameFromHashKey(streetHash)
            detailedLocation = streetName
        end
    
        if Config.CrossingRoadName then
            local _, crossingRoadHash = GetStreetNameAtCoord(x, y, z)
            if crossingRoadHash ~= 0 then
                local crossingRoadName = GetStreetNameFromHashKey(crossingRoadHash)
                detailedLocation = detailedLocation .. " & " .. crossingRoadName
            end
        end
    
        if Config.ZoneName then
            local zoneName = GetNameOfZone(x, y, z)
            detailedLocation = detailedLocation .. ", " .. zoneName
        end
    
        if Config.PostalName then
            local postal = exports['nearest-postal']:getPostal()
            if postal ~= nil then
                detailedLocation = detailedLocation .. ", Postal: " .. postal
            end
        end
        TriggerServerEvent('cc-panic:greceiveDetailedLocation', detailedLocation)
    end)
end