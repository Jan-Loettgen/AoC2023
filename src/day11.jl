N = 140
gal_shift = 999999
using Formatting
f = open("./inputs/day11.txt", "r")
lines = readlines(f)

map = Array{Int8}(undef, (N, N))
for (i, line) in enumerate(lines)
    for j in range(1, N)
        if line[j] == '#'
            map[i, j] = 0
        else
            map[i, j] = 1
        end
    end
end

thick_cols = []
thick_rows = []
for i in range(1, N)
    row_galaxy = false
    col_galaxy = false
    for j in range(1, N)
        if map[i, j] == 0
            row_galaxy = true
        end
        if map[j, i] == 0
            col_galaxy = true
        end 
    end
    if row_galaxy == false
        push!(thick_rows, (i))
    end

    if col_galaxy == false
        push!(thick_cols, (i))
    end
end

i_offset = 0
galaxies = []
for i in range(1, N)
    if i in thick_rows
        global i_offset += gal_shift
    end
    j_offset = 0
    for j in range(1, N)
        if j in thick_cols
            j_offset += gal_shift
        end
        if map[i, j] == 0
            push!(galaxies, (i+i_offset, j+j_offset))
        end
    end
end

println("thick cols: ", thick_cols, ". Thick rows: ", thick_rows)
distances = Array{Int64}(undef, (length(galaxies), length(galaxies)))
sum = 0
for (i, gal1) in enumerate(galaxies)
    for (j, gal2) in enumerate(galaxies)
        distances[i, j] = abs(gal1[1]-gal2[1]) + abs(gal1[2] - gal2[2])
        global sum += distances[i, j]
    end
end

println("part 1 solution :", format(sum /2)) ## too high

println(distances[1, 2])
println(galaxies[1], "->", galaxies[2])