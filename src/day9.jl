using DataStructures
using Formatting

function get_child(parent)
    child = Array{Int64, 1}(undef, length(parent)-1)
    for i in range(1,length(child))
        child[i] = parent[i+1] - parent[i]
    end
    return child
end

function next_element1(series)

    if all(x -> x==0, series)
        return 0
    else
        if haskey(known_nexts, series)
            child_next = known_nexts[series]
        else
            child_next = next_element1(get_child(series))
            known_nexts[series] = child_next
        end
        return child_next + series[end]
    end
end

function next_element2(series)

    if all(x -> x==0, series)
        return 0
    else
        if haskey(known_prevs, series)
            child_prev = known_prevs[series]
        else
            child_prev = next_element2(get_child(series))
            known_prevs[series] = child_prev
        end
        return series[1] - child_prev
    end
end

f = open("./inputs/day9.txt", "r")

lines = readlines(f)

known_nexts = Dict() # Maps a series to its child
known_prevs = Dict() # Maps a series to its child

sum1 = 0
sum2 = 0
for (i,line) in enumerate(lines)
    series =  [parse(Int64, i) for i in split(line, " ")]
    global sum1 += next_element1(series)
    global sum2 += next_element2(series)
end 

println("Solution part 1: ", sum1)
println("Solution part 1: ", sum2)