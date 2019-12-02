require("test.lua")

function initTriggers()
    dofile("triggers/timer.lua")
    dofile("triggers/foo.lua")
    DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 5, "yey")
    DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 5, ok)
end

initTriggers()
