#f = open("C:\\Users\\Mason Smith\\Documents\\day15input.txt")
#g = readlines(f)

nums =[1,20,8,12,0,14]

function nth(nums, last)
    x = deepcopy(nums)
    s = Dict()
    for i in 1:(length(nums)-1)
        s[nums[i]] = i
    end
    last_spoken = nums[length(nums)]
    for i in (length(nums)+1):last
        r = 0
        if haskey(s, last_spoken)
            r = i-1 - s[last_spoken]
        else
            r = 0
        end
        s[last_spoken] = i-1
        push!(x, r)
        last_spoken = r
    end
    last_spoken
end

# println(nth([0,3,6],2020))
# println(nth([1,3,2],2020))
# println(nth([3,2,1],2020))
println(nth(nums, 2020))
println(nth(nums, 30000000))