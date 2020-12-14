f = open("C:\\Users\\Mason Smith\\Documents\\day12input.txt")
g = readlines(f)

function dir_change(dir, num_turns)
    d = dir
    for _ in 1:num_turns
        d = [-d[2], d[1]]
    end
    d
end 

function run_commands(cmds)
    dir = [1, 0]
    loc = [0, 0]
    for cmd in cmds
        d, r = cmd
        if d == 'N'
            loc[2] += r
        elseif d == 'S'
            loc[2] -= r
        elseif d == 'E'
            loc[1] += r
        elseif d == 'W'
            loc[1] -= r
        elseif d == 'L'
            dir = dir_change(dir, r / 90)
        elseif d == 'R'
            dir = dir_change(dir, 4 - (r/90))
        elseif d == 'F'
            loc = [loc[1] + dir[1] * r, loc[2] + dir[2] * r]
        end
    end 
    return loc
end

function rotate_way(way, ship, nt)
    rel = way .- ship
    rel = dir_change(rel, nt)
    ship .+ rel
end

function run_commands2(cmds)
    loc = [0, 0]
    way = [10, 1]
    for cmd in cmds
        d, r = cmd
        if d == 'N'
            way[2] += r
        elseif d == 'S'
            way[2] -= r
        elseif d == 'E'
            way[1] += r
        elseif d == 'W'
            way[1] -= r
        elseif d == 'L'
            way = dir_change(way, r / 90)
        elseif d == 'R'
            way = dir_change(way,  4 - (r/90))
        elseif d == 'F'
            loc = [loc[1] + way[1] * r, loc[2] + way[2] * r]
        end
    end 
    return loc
end

cmds = map(x -> (x[1], parse(Int, x[2:length(x)])), g)
loc = run_commands(cmds)
println(abs(loc[1]) + abs(loc[2]))

loc2 = run_commands2(cmds)
println(abs(loc2[1]) + abs(loc2[2]))