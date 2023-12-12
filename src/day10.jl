global N = 142

function check_point(map, pi, pj)

    for i in range(i, N)

    end

f = open("./inputs/day10.txt", "r")

lines = readlines(f)

map = Array{Char}(undef, (N, N))
map_clean = Array{Char}(undef, (N, N))

for (i,line) in enumerate(lines)
    for j in range(1, N)
        map[i, j] = line[j]
        map_clean[i, j] = '.'

        if map[i, j] == 'S'
            global cur_i = i
            global cur_j = j
        end
    end 
end

dir = 3 #[0=right, 1 = up, 2 = left, 3 = down]
angle = 180
map_clean[cur_i, cur_j] = map[cur_i, cur_j]
cur_i = cur_i + 1 
cur_j = cur_j 
steps = 0


corners = []
while true
    global map_clean[cur_i, cur_j] = map[cur_i, cur_j]
    if map[cur_i, cur_j] == '|' # up or down
        if dir == 1
            global cur_i = cur_i - 1
        else
            global cur_i = cur_i + 1
        end

    elseif map[cur_i, cur_j] == '-' # left or right
        if dir == 0
            global cur_j = cur_j + 1
        else
            global cur_j = cur_j - 1
        end

    elseif map[cur_i, cur_j] == 'F' # down or right
        if dir == 1
            global cur_j = cur_j + 1
            global dir = 0
        else
            global cur_i = cur_i + 1
            global dir = 3
        end

    elseif map[cur_i, cur_j] == 'L' # up or right
        if dir == 3
            global cur_j = cur_j + 1
            global dir = 0
        else
            global cur_i = cur_i - 1
            global dir = 1
        end
    elseif map[cur_i, cur_j] == 'J' # up or left
        if dir == 0
            global cur_i = cur_i - 1
            global dir = 1
        else
            global cur_j = cur_j - 1
            global dir = 2
        end
    elseif map[cur_i, cur_j] == '7' # down or left
        if dir == 1
            global cur_j = cur_j - 1
            global dir = 2
        else
            global cur_i = cur_i + 1
            global dir = 3
        end
    elseif map[cur_i, cur_j] == 'S'
        break
    end
    global steps += 1

    # include all points on the left of the line as source points.
    if dir == 0 && map_clean[cur_i-1, cur_j] == '.'
        map_clean[cur_i-1, cur_j] = '~'
    elseif dir == 1 && map_clean[cur_i, cur_j-1] == '.'
        map_clean[cur_i, cur_j-1] = '~'
    elseif dir == 2 && map_clean[cur_i+1, cur_j] == '.'
        map_clean[cur_i+1, cur_j] = '~'
    elseif dir == 3 && map_clean[cur_i, cur_j+1] == '.'
        map_clean[cur_i, cur_j+1] = '~'
    end



    
end

to_check = []
for i in range(1, N)
    for j in range(1, N)
        if map_clean[i, j] == '~'
            push!(to_check, (i, j))
        end
    end
end

while length(to_check) > 0
    (i, j) = pop!(to_check)

    map_clean[i, j] = 'I'

    if i > 1 && map_clean[i - 1, j] == '.'
            push!(to_check, (i - 1, j))
            map_clean[i - 1, j] = '~'
    end
    
    if i < N && map_clean[i + 1, j] == '.'
            push!(to_check, (i + 1, j))
            map_clean[i + 1, j] = '~'
    end

    if j > 1
        if map_clean[i, j - 1] == '.'
            push!(to_check, (i, j - 1))
            map_clean[i, j - 1] = '~'
        end

    end
    
    if j < N && map_clean[i, j + 1] == '.'
        push!(to_check, (i, j + 1))
        map_clean[i, j + 1] = '~'
    end

end

sum = 0
for i in range(1, N)
    for j in range(1, N)
        if map_clean[i, j] == 'I'
            global sum += 1
        end
    end
end

#println(sum)
#println(N*N - sum - steps - 1)

for i in range(1, N)
    println(join(map_clean[i, :]))
end