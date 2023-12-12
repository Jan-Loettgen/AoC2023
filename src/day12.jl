function count_permutations(pos, key)
    # create an array that is pos but stores the number of unknowns in a row if
    n_blocks = length(key)
    permute_block(pos[1], key)

end

function permute_block(block, key)
    idx = make_idx(block)

    println(block)
    println(key)
    println(idx)

    s = 0
    for k in key
        for i in idx
            if i - k + 1 > 0
            s += i - k + 1
            end
        end
    end

end

function make_idx(block) # [broke, unknown, broke, unknown]
    idx = []
    if block[1] == '?'
        push!(idx, 0)
    end
    active_c = block[1]
    count = 0
    for c in block
        if c == active_c
            count += 1
        else
            push!(idx, count)
            active_c = c
            count = 1
        end
    end
    push!(idx, count)
    return idx
end



f = open("./inputs/day12.txt", "r")

lines = readlines(f)

for line in lines
    split_line = split(line, ' ')
    pos = [i for i in split(split_line[1], '.') if i != ""]
    key = [parse(Int64, i) for i in split(split_line[2], ',')]
    count_permutations(pos, key)
    exit()
end
