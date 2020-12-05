f = open("C:\\Users\\Mason Smith\\Documents\\day05input.txt")
g = readlines(f)

function parse_seat(s)
    row = s[1:7]
    val = 0
    for r in row
        val = val * 2 + ((r == 'F') ? 0 : 1)
    end

    seat = s[8:10]
    sv = 0
    for c in seat
        sv = sv * 2 + ((c == 'L') ? 0 : 1)
    end 
    val * 8 + sv
end 

seats = sort(map(parse_seat, g))
println(seats)
println(reduce(max, seats))

function find_seat(seats)
    s = reduce(min, seats)
    for f in seats
        if f - s != 0
            return f-1
        end
        s+=1
    end
end

println(find_seat(seats))