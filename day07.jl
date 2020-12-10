f = open("C:\\Users\\Mason Smith\\Documents\\day07input.txt")
g = readlines(f)

function rules_map(lines)
    contained_in = Dict()
    contains_bags = Dict()

    function parse_bag_count(l)
        toks = split(l, " ")
        return (parse(Int, toks[1]), toks[2] * " " * toks[3])
    end

    for line in lines
        x, c = split(line, " contain ")
        if c == "no other bags."
            continue
        end
        color_x = rsplit(x, " "; limit=2)[1]

        colors_c = split(c, ", ") .|> parse_bag_count
        contains_bags[color_x] = colors_c .|> x -> [x[2], x[1]]
        for cc in colors_c
            r = get(contained_in, cc[2], [])
            push!(r, (color_x, cc[1]))
            contained_in[cc[2]] = r
        end
    end

    (contained_in, contains_bags)
end

function count_contains(color, rules)
    colors = Set()
    queue = map(x -> x[1], get(rules, color, []))

    while length(queue) > 0
        c = pop!(queue)
        push!(colors, c)
        union!(queue, map(x->x[1], get(rules, c, [])))
    end
    length(colors)
end 

function count_bags(color, rules)::Int64
    s = 0
    for x in get(rules, color, [])
        s += x[2] * (1 + count_bags(x[1], rules))
    end

    s
end

# rules = rules_map(["light red bags contain 1 bright white bag, 2 muted yellow bags.", "dark orange bags contain 3 bright white bags, 4 muted yellow bags."])
rules, rules_c = rules_map(g)
#print(rules)
println(count_contains("shiny gold", rules))
println(count_bags("shiny gold", rules_c))

a, b = rules_map(["dark blue bags contain 2 dark violet bags.", "dark violet bags contain no other bags.", "dark green bags contain 2 dark blue bags, 3 dark violet bags."])
println(count_bags("dark green", b))