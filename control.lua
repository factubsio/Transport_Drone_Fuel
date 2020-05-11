local events = require("event_handler")


events.add_lib{
    on_init = function()
        for _,force in pairs(game.forces) do
            if force.technologies["transport-system"].researched then
                game.print("Giving transport fuel researches")
                force.recipes["transport-drone-refinery"].enabled = true
                force.recipes["drone-fuel-from-coal"].enabled = true
                force.recipes["drone-engine-unit"].enabled = true
            end
        end
    end
}
