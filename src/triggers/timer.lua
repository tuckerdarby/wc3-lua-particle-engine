local interval = 0

local function timerConditions()
    return true
end

local function timerActions()
    print("yay timer expired, " .. interval)
    interval = interval + 1
end

local function initTimer()
    timerTrigger = CreateTrigger()
    TriggerRegisterTimerEventPeriodic(timerTrigger, 1)
    TriggerAddCondition(timerTrigger, Condition(timerConditions))
    TriggerAddAction(timerTrigger, timerActions)
end

initTimer()
