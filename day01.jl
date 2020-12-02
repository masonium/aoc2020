f = open("C:\\Users\\Mason Smith\\Documents\\day01input.txt")
g = readlines(f)

nums = map(x->parse(Int64, x), g)

function part1(nums)
    d = Dict()
    for x in nums
        if haskey(d, 2020 - x)
            println(x * (2020-x))
        end
        d[x] = x
    end
end

function part2(nums)
    n = length(nums)
    twosum=Dict()
    d=Dict()
    found = false
    for i in 1:n
        if found
            break
        end
        rem = 2020 - nums[i]
        if haskey(twosum, rem) 
            (a, b) = get(twosum, rem, (0,0))
            println((nums[i], a, b))
            println(nums[i]*a*b)
            break
        end 
        for j in 1:i-1 
            twosum[ nums[i]+nums[j] ] = (nums[i], nums[j])
        end
    end
end

part1(nums)
part2(nums)