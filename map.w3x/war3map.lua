udg_unitGroup = nil
udg_unitGroup_Copy = {}
gg_trg_timer = nil

function InitGlobals()
    local i = 0
    udg_unitGroup = CreateGroup()
    i = 0
    while (true) do
        if (i > 1) then
            break
        end
        udg_unitGroup_Copy[i] = CreateGroup()
        i = i + 1
    end
end

function CreateUnitsForPlayer0()
    local p = Player(0)
    local u
    local unitID
    local t
    local life
    u = CreateUnit(p, FourCC("h000"), 219.4, -90.4, 293.630)
end

function CreatePlayerBuildings()
end

function CreatePlayerUnits()
    CreateUnitsForPlayer0()
end

function CreateAllUnits()
    CreatePlayerBuildings()
    CreatePlayerUnits()
end

function Trig_timer_Conditions()
    if (not (GetTriggerPlayer() == Player(0))) then
        return false
    end
    return true
end

function Trig_timer_Actions()
    FogEnableOn()
end

function InitTrig_timer()
    gg_trg_timer = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(gg_trg_timer, 2)
    TriggerAddCondition(gg_trg_timer, Condition(Trig_timer_Conditions))
    TriggerAddAction(gg_trg_timer, Trig_timer_Actions)
end

function InitCustomTriggers()
    InitTrig_timer()
end

function InitCustomPlayerSlots()
    SetPlayerStartLocation(Player(0), 0)
    SetPlayerColor(Player(0), ConvertPlayerColor(0))
    SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(0), true)
    SetPlayerController(Player(0), MAP_CONTROL_USER)
end

function InitCustomTeams()
    SetPlayerTeam(Player(0), 0)
end

function main()
    SetCameraBounds(
        -3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT),
        -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM),
        3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT),
        3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP),
        -3328.0 + GetCameraMargin(CAMERA_MARGIN_LEFT),
        3072.0 - GetCameraMargin(CAMERA_MARGIN_TOP),
        3328.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT),
        -3584.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM)
    )
    SetDayNightModels(
        "Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl",
        "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl"
    )
    NewSoundEnvironment("Default")
    SetAmbientDaySound("LordaeronSummerDay")
    SetAmbientNightSound("LordaeronSummerNight")
    SetMapMusic("Music", true, 0)
    CreateAllUnits()
    InitBlizzard()
    InitGlobals()
    InitCustomTriggers()
end

function config()
    SetMapName("TRIGSTR_001")
    SetMapDescription("TRIGSTR_003")
    SetPlayers(1)
    SetTeams(1)
    SetGamePlacement(MAP_PLACEMENT_USE_MAP_SETTINGS)
    DefineStartLocation(0, 896.0, -640.0)
    InitCustomPlayerSlots()
    SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
    InitGenericPlayerSlots()
end
