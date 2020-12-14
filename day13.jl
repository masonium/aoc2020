f = open("C:\\Users\\Mason Smith\\Documents\\day13input.txt")
g = readlines(f)

earliest = parse(Int, g[1])
nums = [parse(Int, x) for x in split(g[2], ",") if x != "x"]
println(nums)
r = min([(x - earliest % x, x) for x in nums]...)
println(r[1] * r[2])

nums_place = [(x[1], parse(Int, x[2])) for x in enumerate(split(g[2], ",")) if x[2] != "x"]
println(nums_place)
spacing = prod(x[2] for x in nums_place)
function solve(nums_place)
    i::Int64 = 1
    p::Int64 = 1
    j = 1
    while true
        y = true
        rest = nums_place[j:length(nums_place)]
        for c in rest
            r = (i + c[1]) % c[2]
            if r != 0
                # println([c[1], c[2], (i + c[1]) % c[2]])
                # i += (c[2] - r)
                y = false
                break
            end
            p *= c[2]
            println(p)
            j += 1
        end
        if y
            for c in nums_place
                println([c[1], c[2], (i + c[1]) % c[2]])
            end 
            println(i)
            break
        end
        i += p
    end 
    i + 1
end
println(solve(nums_place))
