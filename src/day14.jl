function solve_pt1(field)
    n_cols = length(field[1])
    n_rows = length(field)
    global sum = 0
    for col in 1:n_cols
        place = n_rows
        for row in 1:n_rows
            if field[row][col] == '#'
                place = (n_rows - row)
            elseif field[row][col] == 'O'
                global sum += place
                place = place - 1
            end
        end
    end
    return sum
end

function count_pt2(field)
    n_cols = length(field[1])
    n_rows = length(field)
    global sum = 0
    for col in 1:n_cols
        for row in 1:n_rows
            if field[row][col] == 'O'
                global sum += n_rows - row + 1
            end
        end
    end
    return sum
end
function cycle(field)
    n_cols = length(field[1])
    n_rows = length(field)
    
    for col in 1:n_cols # north
        place = 1
        for row in 1:n_rows
            if field[row][col] == '#'
                place = row + 1
            elseif field[row][col] == 'O'
                field[row][col] = '.'
                field[place][col] = 'O'
                place = place + 1
            end
        end
    end

    for row in 1:n_rows # west
        place = 1
        for col in 1:n_cols
            if field[row][col] == '#'
                place = col + 1
            elseif field[row][col] == 'O'
                field[row][col] = '.'
                field[row][place] = 'O'
                place = place + 1
            end
        end
    end

    for col in 1:n_cols # south
        place = n_rows
        for row in 1:n_rows
            if field[n_rows - row + 1][col] == '#'
                place = n_rows - row
            elseif field[n_rows - row + 1][col] == 'O'
                field[n_rows - row + 1][col] = '.'
                field[place][col] = 'O'
                place = place - 1
            end
        end
    end

    for row in 1:n_rows # west
        place = n_cols
        for col in 1:n_cols
            if field[row][n_cols - col + 1] == '#'
                place = n_cols - col
            elseif field[row][n_cols - col + 1] == 'O'
                field[row][n_cols - col + 1] = '.'
                field[row][place] = 'O'
                place = place - 1
            end
        end
    end

    return field
end

function print_field(field)
    n_rows = length(field)
    for i in range(1, n_rows)
        println(join(field[i]))
    end
end

function compare_cycles(c1, c2)
    for item in c1
        if !(item in c2)
            return false
        end
    end
    return true
end

f = open("./inputs/day14.txt", "r")
lines = readlines(f)

global field = []

for (i,line) in enumerate(lines)
    push!(field, [])
    for (j, sym) in enumerate(line)
        push!(field[end], sym)
    end
end

println(solve_pt1(field))

t = 1000000000
cycles = [99646, 99641, 99630, 99623, 99618, 99621, 99625, 99652, 99654]
loads = Array{Int64, 1}(undef, length(cycles))
global i = 1
while i < t
    cycle(field)
    load = count_pt2(field)
    loads[i % length(cycles) + 1] = load

    if compare_cycles(loads, cycles)
        break
    end
    global i += 1
end
println(cycles[(t % length(cycles)) + 1])