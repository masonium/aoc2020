
mutable struct Node
    value::Int64
    next::Int64
    prev::Int64
end

function solve2(part)
    cups::Array{Int64} = [1, 5, 7, 6, 2, 3, 9, 8, 4]
    if part == 1
        N=9
        M=100
    else 
        N=1000000
        M=10*N  
    end
    nodes::Array{Node} = [Node(i <= 9 ? cups[i] : i,mod1(i+1, N), mod1(i-1, N)) for i in 1:N]
    current = 1
    for j in 1:M
        cl = nodes[current].value
        selected = []
        next = nodes[current].next
        for k in 1:3
            push!(selected, nodes[next].value)
            next = nodes[next].next
        end
        last = nodes[next].prev
        after_last = next

        next_label = mod1(cl - 1, N)
        while next_label in selected
            next_label = mod1(next_label - 1, N)
        end
        # remove and insert
        f = 0
        nc = 0
        if next_label > 9
            nc = next_label
        else
            nc = findall(x -> x == next_label, cups)[1]
        end
        after_nc = nodes[nc].next
        after_current = nodes[current].next
        nodes[nc].next = after_current
        nodes[after_current].prev = nc
        nodes[last].next = after_nc
        nodes[after_nc].prev = last
        
        nodes[current].next = after_last
        nodes[after_last].prev = current

        current = after_last
    end
    if part == 1
        x=findall(x->x.value == 1, nodes)[1]
        for i in 1:8
            x = nodes[x].next
            print(nodes[x].value)
        end
        return
    end

    x = findall(x->x.value == 1, nodes)[1]
    n = nodes[x].next
    nn = nodes[n].next
    return nodes[n].value * nodes[nn].value
end 

function solve(part)
    cups::Array{Int64} = [1, 5, 7, 6, 2, 3, 9, 8, 4]
    # cups = [3,8,9,1,2,5,4,6,7]
    current = 1
    if part == 1
        N=9  
        NC=100
    else
        N=1000000
        NC=N*10
        alt_cups = collect(1:N)
        for i in 1:9
            alt_cups[i] = cups[i]
        end
        cups = alt_cups
    end
    for j in 1:NC
        cl = cups[current]
        if mod(j, 10) == 0
            print(".")
        end
        a = popat!(cups, mod1(current+1, length(cups)))
        b = popat!(cups, mod1(current+1, length(cups)))
        c = popat!(cups, mod1(current+1, length(cups)))
        next_label = mod1(cl-1, N)
        while next_label in [a, b, c]
            next_label = mod1(next_label - 1, N) 
        end
        p = findall(x -> x == next_label, cups)[1]
        insert!(cups, p+1, c)
        insert!(cups, p+1, b)
        insert!(cups, p+1, a)
        newc = findall(x->x==cl, cups)[1]
        #if newc != current
            #println("current moved ", current, " to ", newc)
        #end 
        current = mod1(newc+1, N)
        #cups = circshift(cups, N-current+1)
        #current = 1
    end 
 

    if part == 1
        a = findall(x -> x == 1, cups)[1]
        println(a)
        println(cups)
        x = [cups[mod1(a+i, 9)] for i in 1:8]
        return x
    end
    if part == 2
        a = findall(x -> x == 1, cups)[1]
        return cups[mod1(a+1, 9)] * cups[mod1(a+2, 9)]
    end 
end

#println(solve(1))
#println(solve(2))

println(solve2( 1))
println(solve2(2))