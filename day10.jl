f = open("C:\\Users\\Mason Smith\\Documents\\day10input.txt")
g = readlines(f)


function diffs(a)
    x = Dict()
    a = sort(a)
    x[a[1]] = 1
    x[3] = get(x, 3, 0) + 1
    for i in 2:length(a)
        diff = a[i] - a[i-1]
        x[diff] = get(x, diff, 0) + 1
    end
    x
end

adapters = map(x->parse(Int, x), g)
adapters = sort(adapters)

ans = zeros(Int, length(adapters))
function total(a)
    s = 0
    for i = 1:length(a)
        if a[i] > 3
            break
        end
        s += count_diffs(a, i)
    end 
    return s
end

function count_diffs(a, i)
    if ans[i] > 0
        return ans[i]
    end
    if i == length(a)
        ans[i] = 1
    else
        s = 0
        for j in i+1:min(i+3,length(a))
            if a[j] - a[i] <= 3
                s += count_diffs(a, j)
            end 
        end 
        ans[i] = s
    end
    return ans[i]
end 


d = diffs(adapters)
println(d[3] * d[1])
println(total(adapters))