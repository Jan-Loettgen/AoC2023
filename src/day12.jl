function count_permutations(row, keys)

    global countmap

    if haskey(countmap, (row, keys))
        return countmap[(row, keys)]
    end

    if length(row) - keys[1] < 2
        countmap[(row, keys)] = 0
        return 0
    end

    i = keys[1]+1
    sum = 0
    hash_i = 0

    if '#' in row[1:keys[1]+1]
        hash_i = find_hash(row)
    end

    while i <= length(row) - 1
        if row[i] == '#' && hash_i == 0
            hash_i = i 
            if length(keys) == 1
                sum = 0
            end
        end
        if fits(row[i-keys[1]:i+1])
            if length(keys) == 1
                if !('#' in row[i+1:end])
                    sum += 1
                end
            else
                sum += count_permutations(row[i+1: end], keys[2:end])
            end
        end

        if hash_i != 0 && i-hash_i >= keys[1]
            break #return sum
        end
        i += 1
    end
    countmap[(row, keys)] = sum
    return sum
end

function find_hash(row)
    i = 1
    while row[i] != '#' && i < length(row)
        i += 1
    end
    return i
end

function fits(row)
    global fitmap
    if haskey(fitmap, row)
        return fitmap[row]
    end

    n = length(row) - 2
    if row[1] == '#' || row[end] == '#'
        fitmap[row] = false
        return false
    end

    for i in 1:n
        if row[i+1] == '.'
            fitmap[row] = false
            return false
        end
    end
    fitmap[row] = true
    return true
end

f = open("./inputs/day12.txt", "r")

lines = readlines(f)
global fitmap = Dict()
global countmap = Dict()

sum1 = 0
sum2 = 0
count = 0
for line in lines
    split_line = split(line, ' ')
    row = "." * split_line[1] * "."
    key = [parse(Int64, i) for i in split(split_line[2], ',')]

    global sum1 += count_permutations(row, key)

    key2 = [i for j in 1:5 for i in key]
    row2 = "."
    for i in 1:4
        row2 = row2 * split_line[1] * "?"
    end
    row2 = row2*split_line[1] * "."
    global sum2 += count_permutations(row2, key2)
end
println(sum1)
println(sum2)