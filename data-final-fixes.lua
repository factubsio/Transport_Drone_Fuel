local tdf = require("tdf_shared")

for name,recipe in pairs(data.raw.recipe) do
    if recipe.category == "transport-drone-request" then
        recipe.ingredients[2].name = tdf.fuel_name
    end
end

data.raw.recipe["fuel-depots"].results[1].name = tdf.fuel_name
data.raw.recipe["fuel-depots"].ingredients[2].name = tdf.fuel_name
data.raw.recipe["fuel-depot"].ingredients = {
    {"iron-plate", 100},
    {"iron-gear-wheel", 30},
    {"pipe", 20},
    {"electronic-circuit", 10},
}
data.raw.recipe["transport-drone"].ingredients = {
    {"drone-engine-unit", 2},
    {"iron-plate", 5},
    {"copper-plate", 2},
    {"electronic-circuit", 4},
}