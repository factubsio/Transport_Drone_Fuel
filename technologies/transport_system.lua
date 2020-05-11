local base_tech = data.raw.technology["transport-system"]

base_tech.prerequisites = nil
base_tech.unit = {
    count = 25,
    ingredients = {{"automation-science-pack", 1}},
    time = 10
}
base_tech.effects[#base_tech.effects + 1] =
    {type = "unlock-recipe", recipe = "transport-drone-refinery"}
base_tech.effects[#base_tech.effects + 1] =
    {type = "unlock-recipe", recipe = "drone-fuel-from-coal"}
base_tech.effects[#base_tech.effects + 1] =
    {type = "unlock-recipe", recipe = "drone-engine-unit"}