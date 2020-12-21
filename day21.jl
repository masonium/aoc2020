f = open("C:\\Users\\Mason Smith\\Documents\\day21input.txt")
g = readlines(f)

function parse(lines)
    ingredients = Dict()
    allergens = Set()
    allergens_to_ingredient = Dict()

    for line in lines
        m = match(r"([a-z ]+) \(contains ([a-z, ]+)\)", line)
        @assert(m != nothing)
        ing = Set(split(m.captures[1], " "))
        aller = Set(split(m.captures[2], ", "))
        for i in ing
            ingredients[i] = get(ingredients, i, 0) + 1
        end
        union!(allergens, aller)
        for a in aller
            if !haskey(allergens_to_ingredient, a)
                allergens_to_ingredient[a] = deepcopy(ing)
            else
                intersect!(allergens_to_ingredient[a], ing)
            end
        end 
    end

    return (ingredients, allergens, allergens_to_ingredient)
end

function solve(lines)
    ing, aller, aller_to_ing = parse(lines)
    s = 0
    for i in keys(ing)
        if any(x -> i in x, values(aller_to_ing))
            continue
        end 
        s += ing[i]
    end 
    s
end 

function solve2(lines)
    ing, aller, aller_to_ing = parse(lines)
    assignment = Dict()
    if solve2_aux(collect(aller), aller_to_ing, assignment)
        println(assignment)
        return join(map(a->assignment[a], sort(collect(keys(assignment)))), ",")
    end
end
function solve2_aux(allers, aller_to_ing, assignment)
    if length(allers) == 0
        return true
    end 

    if length(aller_to_ing[allers[1]]) == 0
        return false
    end 
    for i in aller_to_ing[allers[1]]
        atoi = deepcopy(aller_to_ing)
        for a in allers[2:length(allers)]
            delete!(atoi[a], i)
        end
        assignment[allers[1]] = i
        if solve2_aux(allers[2:length(allers)], atoi, assignment)
            return true
        end        
    end
    return false
end


println(solve(g))
println(solve2(g))
