f = open("C:\\Users\\Mason Smith\\Documents\\day09input.txt")
g = readlines(f)


function check_list(nums)
    sum_map = Dict()

    for i = 26:length(nums)
        all_nums = Set()
        for j = (i-25):(i-1)
            for k = (i-25):(j-1)
                union!(all_nums, Set([nums[j]+nums[k]]))
            end
        end
        if !(nums[i] in all_nums)
            return nums[i]
        end
    end
end

function find_sum(nums, target)
    prefix = [0]
    for i = 1:length(nums)
        push!(prefix, prefix[i] + nums[i])
    end 

    for i = 2:length(nums)
        for j = i+2:length(nums)
            if prefix[j] - prefix[i-1] == target
                println(nums[i+1:j+1])
                println(sum(nums[i-1:j-1]))
                return min(nums[i-1:j-1]...) + max(nums[i-1:j-1]...)
            end
            
            if prefix[j] - prefix[i-1] > target
                break
            end
        end
    end
end
nums = map(x-> parse(Int, x), g)
ans = check_list(nums)
println(ans)
println(find_sum(nums, ans))