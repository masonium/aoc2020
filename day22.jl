f = open("C:\\Users\\Mason Smith\\Documents\\day22input.txt")
g = readlines(f)
println(occursin("player", "player1"))
function parse_line(line)

end

function parse_cards(lines)
    players = [[],[]]

    idx = 0
    for line in lines
        if line == ""
            continue
        end
        if occursin("Player", line)
            idx += 1
        else
            push!(players[idx], parse(Int, line))
        end
    end
    
players
end

function recur_combat(players)
    player_hist = [[],[]]
    
    winner = 0
    first = 0
    second = 0

    while length(players[1]) > 0 && length(players[2]) > 0
        if players[1] in player_hist[1] || players[2] in player_hist[2]
            
            return (1, players[1])
        end

        push!(player_hist[1], deepcopy(players[1]))
        push!(player_hist[2], deepcopy(players[2]))

        a = popat!(players[1], 1)
        b = popat!(players[2], 1)

        if length(players[1]) < a || length(players[2]) < b 
            winner = a > b ? 1 : 2
            first = max(a, b)
            second = min(a, b)
        else
            # recur
            (winner, p) = recur_combat([deepcopy(players[1][1:a]), deepcopy(players[2][1:b])])
            if winner == 1
                first = a
                second = b
            elseif winner == 2
                first = b
                second = a
            else
                @assert(false)
            end
        end

        push!(players[winner], first)
        push!(players[winner], second)
    end
    
    return (winner, players[winner])
end

function solve(lines, part)
    if part == 1
        players = parse_cards(lines)
        winner = 0
        while length(players[1]) > 0 && length(players[2]) > 0
            a = popat!(players[1], 1)
            b = popat!(players[2], 1)
            winner = a > b ? 1 : 2
            push!(players[winner], max(a, b))
            push!(players[winner], min(a,b))
        end

        return sum(map(x -> x[1] * x[2], enumerate(reverse(players[winner]))))    

    end     

    if part == 2
        players = parse_cards(lines)
        (_, win) = recur_combat(players)
        
        return sum(map(x -> x[1] * x[2], enumerate(reverse(win))))  
    end 

end


println(solve(g, 1))
println(solve(g, 2))