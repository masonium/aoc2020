f = open("C:\\Users\\Mason Smith\\Documents\\day04input.txt")
g = readlines(f)

expected = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

function parse_passports(lines)
    pass = []
    curr = Dict()
    for line in lines
        if line == ""
            append!(pass, [curr])
            curr = Dict()
            continue
        end
        tokens = split(line, " ")
        for t in tokens
            x = split(t,":")[1]
            curr[x] = split(t,":")[2]
        end
    end

    pass = append!(pass, [curr])
    pass
end

pass = parse_passports(g)

function is_valid(p)
    for tok in expected
        if !(tok in keys(p))
            return false
        end 
    end
    return true
end

function is_valid2(p)
    if !is_valid(p)
        return false
    end
    byr = parse(Int64, p["byr"])
    if !(1920 <= byr <= 2002)
        return false
    end
    if !(2010 <= parse(Int64, p["iyr"]) <= 2020)
        return false;
    end
    if !(2020 <= parse(Int64, p["eyr"]) <= 2030)
        return false;
    end
    m = match(r"^([0-9]+)(in|cm)$", p["hgt"])
    if m != nothing
        hgt = parse(Int64, m.captures[1])
        unit = m.captures[2]
        if unit == "cm" && !(150 <= hgt <= 193)
            return false;
        end
        if unit == "in" && !(59 <= hgt <= 76)
            return false
        end
    else
        return false
    end
    if match(r"^#[0-9a-f]{6}$", p["hcl"]) == nothing
        return false
    end
    if !(p["ecl"] in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"])
        return false
    end
    if match(r"^[0-9]{9}$", p["pid"]) == nothing
        return false
    end
    return true
end

println(pass[1])
println(count(is_valid, pass))
println(count(is_valid2, pass))