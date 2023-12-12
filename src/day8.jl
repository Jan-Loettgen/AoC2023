using DataStructures
using Formatting
f = open("./inputs/day8.txt", "r")

lines = readlines(f)

net = Dict()
instructions = []
for (i,line) in enumerate(lines)

    if i == 1 
        global instructions = split(line, "")
    elseif i >= 3 
        #println(line)
        src = line[1:3]
        dstl = line[8:10]
        dstr = line[13:15]
        net[src] = (dstl, dstr)
    end
end

curr_node = "AAA"
i = 0
while (curr_node != "ZZZ")
    #println(curr_node, "---", instructions[1+(i % length(instructions))])
    if instructions[1+(i % length(instructions))] == "L"
        global curr_node = net[curr_node][1]
    else
        global curr_node = net[curr_node][2]
    end
    global i = i + 1
end
println("part 1 solution: ", i)


i = 0
curr_nodes = collect(filter(x -> x[3] == 'A', keys(net)))
cycles = zeros(Int64, (length(curr_nodes), 1))
while (0 in cycles)
    for (j, curr_node) in enumerate(curr_nodes)
        if instructions[1+(i % length(instructions))] == "L"
            curr_nodes[j] = net[curr_node][1]
        else
            curr_nodes[j] = net[curr_node][2]
        end

        if curr_nodes[j][end] in "Z" && cycles[j] == 0
            cycles[j] = i+1
        end
    end

    global i = i + 1
end
println("part 2 solution:", lcm(cycles))