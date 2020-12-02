f = open("C:\\Users\\Mason Smith\\Documents\\day02input.txt")
g = readlines(f)

function parse_password(pwd)
    m = match(r"([0-9]+)-([0-9]+) ([a-z]): ([a-z]+)", pwd)
    return (parse(Int64, m.captures[1]), parse(Int64, m.captures[2]), m.captures[3][1], m.captures[4])
end

function passes1(parsed)
    return parsed[1] <= count(x-> x == parsed[3], parsed[4]) <= parsed[2]
end

function passes2(parsed)
    (first, sec, letter, s) = parsed
    return xor(s[first] == letter, s[sec] == letter)
end

passwords = map(parse_password, g)

println(count(passes1, passwords))
println(count(passes2, passwords))