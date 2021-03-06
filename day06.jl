f = open("C:\\Users\\Mason Smith\\Documents\\day06input.txt")
g = readlines(f)


function parse_groups(lines, init, red)
    total = 0
    curr = init
    for line in lines
        if line == ""
            total += length(curr)
            curr = init
            continue
        end
        curr = red(curr, Set([c for c in line]))
    end

    total += length(curr)
    total
end

println(parse_groups(g, Set(), union))
println(parse_groups(g, Set([c for c in "qwertyuiopasdfghjklzxcvbnm"]), intersect))


# ----------------
# Second version
# ----------------
f = open("C:\\Users\\Mason Smith\\Documents\\day06input.txt")
h = read(f, String)

groups = split(h, "\n\n")

function parse_group(group, redf)
    length(redf(map(Set, split(group, "\n"))...))
end

println(sum(map(x -> parse_group(x, union), groups)))
println(sum(map(x -> parse_group(x, intersect), groups)))
