f = open("C:\\Users\\Mason Smith\\Documents\\day16input.txt")
g = readlines(f)

function parse_rule(rule_str)
    c = match(r"([a-z ]+): ([0-9]+)-([0-9]+) or ([0-9]+)-([0-9]+)", rule_str).captures[1:5]
    vcat(map(x -> parse(Int, x), c[2:5]), [c[1]])
end

function solve(lines)
    done_rules = false
    on_tickets = false
    i = 1
    rules = []
    good_tickets = 0
    tickets = 0
    errors = 0
    for line in lines
        if !done_rules
            if line == ""
                done_rules = true
                continue
            end 
            push!(rules, parse_rule(line))
        end

        if line == "nearby tickets:"
            on_tickets = true
            continue
        end
        if on_tickets
            nums = map(x->parse(Int, x), split(line, ","))
            all_valid = true
            for num in nums
                valid = false
                for rule in rules
                    if rule[1] <= num <= rule[2] || rule[3] <= num <= rule[4]
                        valid = true
                    end
                end
                if !valid
                    all_valid = false
                    errors += num
                end
            end 
            tickets += 1
            if all_valid
                good_tickets += 1
            end
        end
    end 
    errors
end 

function solve2(lines)
    done_rules = false
    on_tickets = false
    i = 1
    rules = []
    good_tickets = 0
    tickets = 0
    errors = 0
    is_possible = Dict()
    i = 1
    for line in lines
        if !done_rules
            if line == ""
                done_rules = true
                break
            end 
            push!(rules, parse_rule(line))
        end
        i += 1
    end 
    println(rules)

    i += 2
    my_ticket = map(x -> parse(Int, x), split(lines[i], ","))
    i += 1

    println("my_ticket: ")
    println(my_ticket)
    possible = Dict()
    for r in 1:length(rules)
        possible[r] = Set(1:length(my_ticket))
    end 

    for line in lines[i+1:length(lines)]
        if line == "nearby tickets:"
            on_tickets = true
            continue
        end
        if on_tickets
            nums = map(x->parse(Int, x), split(line, ","))
            println(nums)
            all_valid = true


            for n in 1:length(nums)
                num = nums[n]
                valid = false
                for rule in rules
                    if rule[1] <= num <= rule[2] || rule[3] <= num <= rule[4]
                        valid = true
                    end
                end
                if !valid
                    continue
                end 

                for r in 1:length(rules)
                    rule = rules[r]
                    if !(rule[1] <= num <= rule[2] || rule[3] <= num <= rule[4])
                        println("rule ", r, " invalid for num ", n)
                        delete!(possible[n], r)
                    end
                end
            end
        end
    end 

    # reduce the rules
    singletons = Set()
    for _ in 1:length(rules) - 1
        for n in 1:length(my_ticket)
            if n in singletons
                continue
            end
            if length(possible[n]) == 1
                union!(singletons, n)
                x = collect(possible[n])
                for nn in 1:length(my_ticket)
                    if nn == n
                        continue
                    end
                    delete!(possible[nn], x[1])
                end
            end
        end
    end

    prod = 1
    good_rules = Set()
    for r in 1:length(rules)
        rule = rules[r]
        if occursin("departure", rule[5])
            println(r, rule)
            union!(good_rules, [r])
        end
    end
    for n in 1:length(my_ticket)
        println(n, " ", collect(possible[n]))
        for x in possible[n]
            if x in good_rules
                prod *= my_ticket[n]
            end
        end
    end
    prod
end 
println(solve(g))
println(solve2(g))