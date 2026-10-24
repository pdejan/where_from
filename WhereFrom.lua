local HEADER_COLOR = { 1, 0.82, 0 }
local NAME_COLOR = { 0.4, 0.8, 1 }

local function GetSourceTypeLabel(sourceType)
    return sourceType and _G["BATTLE_PET_SOURCE_" .. sourceType] or nil
end

local function IsSecret(value)
    return issecretvalue ~= nil and issecretvalue(value)
end

local function FindUnitMount(unit)
    for i = 1, 255 do
        local ok, aura = pcall(C_UnitAuras.GetAuraDataByIndex, unit, i, "HELPFUL")
        if not ok or not aura then
            return nil
        end
        local spellID = aura.spellId
        if spellID and not IsSecret(spellID) then
            local mountID = C_MountJournal.GetMountFromSpell(spellID)
            if mountID then
                return mountID
            end
        end
    end
end

local function AddMountLines(tooltip, mountID)
    local name, _, icon, _, _, sourceType, _, _, _, _, isCollected = C_MountJournal.GetMountInfoByID(mountID)
    local _, _, sourceText = C_MountJournal.GetMountInfoExtraByID(mountID)

    tooltip:AddLine(" ")

    local label = GetSourceTypeLabel(sourceType)
    if label then
        tooltip:AddLine("Where From? |cffffffff[" .. label .. "]|r", unpack(HEADER_COLOR))
    else
        tooltip:AddLine("Where From?", unpack(HEADER_COLOR))
    end

    if icon then
        tooltip:AddLine("|T" .. icon .. ":0|t " .. name, unpack(NAME_COLOR))
    else
        tooltip:AddLine(name, unpack(NAME_COLOR))
    end

    if sourceText and sourceText ~= "" then
        tooltip:AddLine(sourceText, 1, 1, 1, true)
    else
        tooltip:AddLine("No source information from Blizzard.", 0.6, 0.6, 0.6, true)
    end

    if isCollected then
        tooltip:AddLine("Collected", 0.25, 1, 0.25)
    else
        tooltip:AddLine("Not collected", 1, 0.25, 0.25)
    end

    tooltip:Show()
end

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip)
    if tooltip ~= GameTooltip then
        return
    end
    local _, unit = tooltip:GetUnit()
    if not unit or IsSecret(unit) then
        return
    end
    if not UnitIsPlayer(unit) or UnitIsUnit(unit, "player") then
        return
    end

    local mountID = FindUnitMount(unit)
    if mountID then
        AddMountLines(tooltip, mountID)
    end
end)
