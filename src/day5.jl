
#@time begin
f = open("./inputs/day5.txt", "r")

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

println("solution part1: ",minimum(seeds2))
seed_ranges = []

for i in range(0, length(seeds)/2 - 1)
    push!(seed_ranges, (seeds[Int64((2*i) + 1)], seeds[Int64((2*i) + 1)] + seeds[Int64((2*i) + 2)]))
end


sorted_mappings = []
for i in range(1, length(mappings))
    push!(sorted_mappings, sort!(mappings[i], by = x ->x[2]))
end


# new_ranges = []

# println(seed_ranges[2])
# #println(mappings[1])

dst_ranges = []
lowest = 10000000000
for seed_range in seed_ranges                   # iterate over seed ranges
    next_ranges = [seed_range]

    for mapping in sorted_mappings
        cur_ranges = next_ranges
        next_ranges = []
        for cur_range in cur_ranges
            unmaped = true
            p1 = cur_range[1]
            p2 = cur_range[2]

            fmap = mapping[1]
            lmap = mapping[end]

            #low cut
            if p2 <= fmap[2]
                push!(next_ranges, (p1, p2))
                continue
            elseif p1 < fmap[2]
                push!(next_ranges, (p1, fmap[2]))
                p1 = fmap[2]
            end

            #high cut
            if p1 > (lmap[2]+lmap[3])
                push!(next_ranges, (p1, p2))
                continue
            elseif p2 > (lmap[2]+lmap[3])
                push!(next_ranges, (lmap[2]+lmap[3], p2))
                p2 = lmap[2]+lmap[3]
            end

            for map in mapping
                m1 = map[2]
                m2 = map[2] + map[3]
                ds = map[1] - map[2]

                d1 = p1 - m1
                d2 = p2 - m2

                if p1 > m2
                    continue
                elseif p2 < m1
                    continue
                else
                    if d1 >= 0 && d2 >= 0 # (p1, m2) is mapped
                        push!(next_ranges, (p1+ds, m2+ds)) 
                        p1 = m2
                    elseif d1 >= 0 && d2 < 0 # (p1, p2) is mapped
                        push!(next_ranges, (p1+ds, p2+ds))
                        p1 = p2
                        continue
                    # elseif d1 <= 0 && d2 >= 0
                    #     @assert false
                    #     push!(next_ranges, (m1+ds, m2+ds)) # (m1, m2) is mapped
                    #     p1 = m2
                    else
                        push!(next_ranges, (p1, m1))
                        p1 = p2
                        continue
                        #push!(next_ranges, (m1+ds, p2+ds)) # (m1, p2) is mapped
                    end
                end
            end
        end
        ##println(next_ranges)
    end

    lowest_seed = next_ranges[1][1]
    for range in next_ranges
        if range[1] < lowest_seed
            lowest_seed = range[1]
        end
    end
    
    if lowest_seed < lowest
        global lowest = lowest_seed
    end
end

println("Solution part 2: ", lowest)
close(f)


