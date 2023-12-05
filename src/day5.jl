
@time begin
f = open("/home/bucketking/Documents/fun/AoC2023/inputs/day5.txt", "r")

j= 0
mappings = []
for (i, line) in enumerate(readlines(f) )

    if i == 1
        global seeds = [parse(Int64, a) for a in split(line)[2:end]]
    end

    if length(line) == 0
        push!(mappings, [])
        global j += 1
    elseif isnumeric(line[1])
        push!(mappings[j], [parse(Int64, a) for a in split(line, " ")])
    end
end

seeds2 = Array{Int64}(undef, length(seeds))
for (i, seed) in enumerate(seeds)
    val = seed
    for maping in mappings
        for map in maping
            if (val >= map[2]) &&  (val < map[2]+map[3])
                val = map[1] +  (val-map[2])
            break
            end
        end
    end
    seeds2[i] = val
end

println(minimum(seeds2))
ranges = []

for i in range(0, length(seeds)/2 - 1)
    push!(ranges, (seeds[Int64((2*i) + 1)], seeds[Int64((2*i) + 1)] + seeds[Int64((2*i) + 2)]))
end

# range = (0, max_seed)



#println(seeds)
#println(max_seeds)

close(f)
end


