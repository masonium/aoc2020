f = open("C:\\Users\\Mason Smith\\Documents\\day14input.txt")
g = readlines(f)

function parse_mask(m)
    function r(x)
        if x == '1'
            return 1
        elseif x == '0'
            return 0
        else 
            return -01
        end
    end
    reverse([r(c) for c in m])
end

function get_bits(val, n)
    arr = zeros(n)
    i = 1
    while val > 0
        arr[i] = val % 2
        val = val ÷ 2
        i += 1
    end
    arr
end

function to_val(bits)
    sum(map(x ->Int( x[2] * 2 ^ (x[1]-1)), enumerate(bits)))
end

function all_addrs(bits)
    for i in 1:36
        if bits[i] < 0
            bits0 = deepcopy(bits)
            bits0[i] = 0
            bits1 = deepcopy(bits)
            bits1[i] = 1
            return vcat(all_addrs(bits0), all_addrs(bits1))
        end
    end    
    return [to_val(bits)]
end

function run(inst)
    d = Dict()

    mask = []
    for line in inst
        x = split(line, " = ")
        a = x[1]
        b = x[2]
        if a == "mask"
            mask = parse_mask(b)
        else
            loc = parse(Int, split(split(a, "[")[2], "]")[1])
            #  loc = parse(Int, match(r"mem\[(.*)\]", a).captures[1])
            val = parse(Int, b)
            bits = get_bits(val, 36)
            for i in 1:36
                if mask[i] >= 0
                    bits[i] = mask[i]
                end
            end
            d[loc] = to_val(bits)
        end 
    end 
    sum(values(d))
end

function run2(inst)
    d = Dict()
    locs = Set()
    mask = []
    for line in inst
        x = split(line, " = ")
        a = x[1]
        b = x[2]
        if a == "mask"
            mask = parse_mask(b)
        else
            loc = parse(Int, split(split(a, "[")[2], "]")[1])
            #  loc = parse(Int, match(r"mem\[(.*)\]", a).captures[1])
            val = parse(Int, b)
            masked_loc = get_bits(loc, 36)
            for i in 1:36
                if mask[i] < 0
                    masked_loc[i] = -1
                elseif mask[i] > 0
                    masked_loc[i] = 1
                end
            end
            addrs = all_addrs(masked_loc)
            for addr in addrs
                d[addr] = val
            end
        end 
    end 

    sum(values(d))
end


println(run(g))
println(run2(g))
println([1] + [2])