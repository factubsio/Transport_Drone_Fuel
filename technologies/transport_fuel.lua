local td_shared = require("__Transport_Drones__/shared")
local tdf = require("tdf_shared")

local name = td_shared.transport_system_technology

local advanced_coal_to_fuel =
{
  name = "advanced-coal-to-drone-fuel",
  localised_name = {"advanced-coal-to-drone-fuel"},
  type = "technology",
  icon = tdf.path("technologies/transport-fuel-coal-2.png"),
  icon_size = 128,
  upgrade = true,
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "drone-fuel-from-coal-2"
    },
  },
  prerequisites = {name, "logistics"},
  unit =
  {
    count = 50,
    ingredients =
    {
      {"automation-science-pack", 1},
    },
    time = 20
  },
  order = name,
}

local gas_to_fuel =
{
  name = "gas-to-drone-fuel",
  localised_name = {"gas-to-drone-fuel"},
  type = "technology",
  icon = tdf.path("technologies/transport-fuel-gas.png"),
  icon_size = 128,
  upgrade = true,
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "drone-fuel-from-gas"
    },
  },
  prerequisites = {name, "engine", "oil-processing"},
  unit =
  {
    count = 200,
    ingredients =
    {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
    },
    time = 30
  },
  order = name,
}

local rocket_fuel_to_fuel =
{
  name = "rocket-fuel-to-drone-fuel",
  localised_name = {"rocket-fuel-to-drone-fuel"},
  type = "technology",
  icon = tdf.path("technologies/transport-fuel-rocket-fuel.png"),
  icon_size = 128,
  upgrade = true,
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "drone-fuel-from-rocket-fuel"
    },
  },
  prerequisites = {name, "rocket-fuel", "gas-to-drone-fuel"},
  unit =
  {
    count = 200,
    ingredients =
    {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1},
    },
    time = 45
  },
  order = name,
}

data:extend{advanced_coal_to_fuel, gas_to_fuel, rocket_fuel_to_fuel}

