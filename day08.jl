f = open("C:\\Users\\Mason Smith\\Documents\\day08input.txt")
g = readlines(f)

function inst(x)
    r = split(x, " ")
    if length(r) == 2
        return (r[1],  parse(Int, r[2]))
    else
        return [r[1]]
    end
end

insts = map(inst, g)

function run(insts)
    acc = 0
    idx = 1
    
    ran = Set()
    while true
        inst = insts[idx]
        if idx in ran
            return acc
        end

        union!(ran, Set([idx]))

        if inst[1] == "acc"
            acc += inst[2]
            idx += 1
        elseif inst[1] == "jmp"
            idx += inst[2]
        elseif inst[1] =="nop"
            idx += 1
        end

    end 
end

function run_term(insts, change_idx)
    acc = 0
    idx = 1
    
    ran = Set()
    while idx <= length(insts)
        inst = insts[idx]
        if idx in ran
            return (acc, false)
        end

        union!(ran, Set([idx]))
        i = inst[1]
        if idx == change_idx
            if i == "jmp"
                i = "nop"
            elseif i == "nop"
                i == "jmp"
            end
        end
        if i == "acc"
            acc += inst[2]
            idx += 1
        elseif i == "jmp"
            idx += inst[2]
        elseif i =="nop"
            idx += 1
        end
    end 
    return (acc, true)
end
println(run(insts))

for i  in 1:length(insts)
    a, b = run_term(insts, i)
    if b
        println(a)
        break
    end
end