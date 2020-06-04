local tdf = require("tdf_shared")
local util = require("util")

for name,recipe in pairs(data.raw.recipe) do
    if recipe.category == "transport-drone-request" then
        recipe.ingredients[2].name = tdf.fuel_name
    end
end

-- defaults
local engine_unit = "drone-engine-unit"
local circuit = "electronic-circuit"
local circuit_count = 4

-- choose circuit board - bobs gets priority then pyhightech
if data.raw.item["basic-circuit-board"] then
    circuit = "basic-circuit-board"
elseif mods["pyhightech"] then
    -- simple circuit boards are still called 'electronic-circuit'
    circuit_count = 3
end

-- engine unit tweaks
if mods["aai-industry"] then
    engine_unit = "electric-motor"
    data.raw.recipe["drone-engine-unit"].hidden = true
elseif mods["pypetroleumhandling"] then
    data.raw.recipe["drone-engine-unit"].ingredients = {
        { name = "small-parts-01", amount = 1},
        { name = "pipe", amount = 2},
    }
end


data.raw.recipe["fuel-depots"].results[1].name = tdf.fuel_name

local new_fuel_recipe = util.copy(data.raw.recipe["fuel-depots"])
new_fuel_recipe.name = "fuel-depots-bubbles"
new_fuel_recipe.ingredients[2].name = tdf.fuel_name

data:extend{new_fuel_recipe}

data.raw["assembling-machine"]["fuel-depot"].fixed_recipe = nil

data.raw.recipe["fuel-depot"].ingredients = {
    {"iron-plate", 100},
    {"iron-gear-wheel", 30},
    {"pipe", 20},
    {circuit, 10},
}


data.raw.recipe["transport-drone"].ingredients = {
    {engine_unit, 2},
    {"iron-plate", 5},
    {"copper-plate", 2},
    {circuit, circuit_count},
}