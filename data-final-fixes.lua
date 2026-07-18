-- 1. Remove it from Circuit Network 3 (Chemical Science level)
local circuit_3 = data.raw["technology"]["circuit-network-3"]
if circuit_3 then
    for i, effect in ipairs(circuit_3.effects) do
        if effect.type == "unlock-recipe" and effect.recipe == "selector-combinator" then
            table.remove(circuit_3.effects, i)
            break
        end
    end
end

-- 2. Add it to the basic Circuit Network technology (Green Science level)
local circuit_1 = data.raw["technology"]["circuit-network"]
if circuit_1 then
    table.insert(circuit_1.effects, {
        type = "unlock-recipe",
        recipe = "selector-combinator"
    })
end

-- 3. Find the Selector Combinator recipe and change the ingredient from Red Circuits to Green Circuits (and adjust the amount accordingly)
local recipe = data.raw["recipe"]["selector-combinator"]

if recipe and recipe.ingredients then
    for i, ingredient in ipairs(recipe.ingredients) do
        -- Check if it's the old 'advanced-circuit' (Red)
        -- This handles both the short-form {"item", amount} and long-form {name="item", amount=x}
        local name = ingredient.name or ingredient[1]

        if name == "advanced-circuit" then
            -- Swap the name to Green Circuits
            if ingredient.name then
                ingredient.name = "electronic-circuit"
                ingredient.amount = ingredient.amount * 2
            else
                recipe.ingredients[i] = { "electronic-circuit", ingredient[2] * 2 }
            end
        end
    end
end