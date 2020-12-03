f = open("C:\\Users\\Mason Smith\\Documents\\day03input.txt")
g = readlines(f)

function map_row(s)
    map(x -> x == '#', collect(s))   
end 

trees = map(map_row, g)

function f1(trees, right, down)
    n = length(trees)
    r = 1
    c = 0
    width = length(trees[1])
    for y in 1:down:n
        c = c + trees[y][r]
        r = (r + right - 1) % width + 1
    end 
    c
end

println(f1(trees, 3, 1))
println(reduce(*, map(a -> f1(trees, a[1], a[2]), [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)])))