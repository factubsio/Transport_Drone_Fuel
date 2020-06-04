local events = require("event_handler")
local util = require("util")


events.add_lib{
    on_init = function()
        for _,force in pairs(game.forces) do
            if force.technologies["transport-system"].researched then
                game.print("TD_fuel: Giving transport fuel researches")
                force.recipes["transport-drone-refinery"].enabled = true
                force.recipes["drone-fuel-from-coal"].enabled = true
                force.recipes["drone-engine-unit"].enabled = true
            end
        end

        local old_fuel = settings.startup["fuel-fluid"].value


        local fuel_depot_prototype = game.entity_prototypes["fuel-depot"]
        local in_pipe_pos = nil
        if fuel_depot_prototype.fluidbox_prototypes[1].production_type == "input" then
            in_pipe_pos = fuel_depot_prototype.fluidbox_prototypes[1].pipe_connections[1].positions
        else
            in_pipe_pos = fuel_depot_prototype.fluidbox_prototypes[2].pipe_connections[1].positions
        end

        local dump = game.create_inventory(8)

        for _,surface in pairs(game.surfaces) do
            local bad_things_count = 0
            local list = surface.find_entities_filtered{name = {"request-depot", "fuel-depot", "buffer-depot"}}
            for _,entity in pairs(list) do
                local amount = entity.remove_fluid{name=old_fuel, amount=1000000000}


                if entity.prototype.name == "fuel-depot" then
                    local search_offset = nil
                    if entity.direction == defines.direction.north then search_offset = in_pipe_pos[1]
                    elseif entity.direction == defines.direction.east then search_offset = in_pipe_pos[2]
                    elseif entity.direction == defines.direction.south then search_offset = in_pipe_pos[3]
                    elseif entity.direction == defines.direction.west then search_offset = in_pipe_pos[4]
                    end

                    local search_offset = in_pipe_pos[entity.direction/2 + 1]
                    local search_pos = util.copy(entity.position)
                    search_pos.x = search_pos.x + search_offset.x
                    search_pos.y = search_pos.y + search_offset.y
                    local entity_to_mine = surface.find_entities_filtered{position = search_pos, radius = 0.1}[1]
                    if entity_to_mine then
                        entity_to_mine.mine{inventory = dump, raise_destroyed = false}
                        local items = dump.get_contents()
                        for dump_name,dump_amount in pairs(items) do
                            surface.spill_item_stack(search_pos, {name = dump_name, amount = dump_amount, allow_belts = false})
                        end
                        dump.clear()
                        bad_things_count = bad_things_count + 1
                    end
                    -- surface.find_entities_filtered{}

                    entity.set_recipe("fuel-depots-bubbles")
                    if amount > 0 then
                        entity.insert_fluid{name = "drone-fuel", amount = amount}
                    end
                end
            end
            if bad_things_count == 1 then
                game.print("TD_fuel: A contaminated fluid box connected to fuel depots was mined (on surface: " .. surface.name .. ")")
            elseif bad_things_count > 1 then
                game.print("TD_fuel: " .. tostring(bad_things_count) .. " contaminated fluid boxes connected to fuel depots were mined (on surface: " .. surface.name .. ")")
            end
        end

        dump.destroy()

    end
}
