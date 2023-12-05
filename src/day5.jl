f = open("/home/luca/Desktop/fun/AoC2023/inputs/day5.txt", "r")
 
# do some file operations

# to count total lines in the file
line_count = 0             

# for line in readlines(f)


# end
lines = readlines(f) 

j= 0
mappings = []
for (i, line) in enumerate(lines)
    #println(line)

    if i == 1
        seeds = [parse(Int64, a) for a in split(line)[2:end]]
    end

    if line == "\n"
        mappings.append!([])
        j += 1
    elseif isnumeric(line[0])
        mappings[j].append!([parse(Int64, a) for a in split(line, " ")])
        
    end


end
#print(lines)
#print(split(lines,"\n"))


# close the file instance
close(f)



