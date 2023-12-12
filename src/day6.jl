using Formatting

f = open("./inputs/day6.txt", "r")
 
# do some file operations

# to count total lines in the file          
 
lines = readlines(f)
times_txt = split(lines[1], " ")
distances_txt = split(lines[2], " ")
deleteat!(times_txt, findall(x->x=="", times_txt))
deleteat!(distances_txt, findall(x->x=="", distances_txt))
times = [parse(Int64, x) for x in times_txt[2:end]]
distances = [parse(Int64, x) for x in distances_txt[2:end]]

sum = 1
for i in range(1, length(times))
    count = 0
    for j in range(1, times[i])
        d = j * (times[i] - j)
    
        if d > distances[i]
            count += 1
        end 
    end
    global sum *= count
end

time2 = parse(Int64, join(times_txt[2:end]))
dist2 = parse(Int64, join(distances_txt[2:end]))

a = -1
b = time2
c = -dist2

root1 = (-b + sqrt(b^2 - 4*a*c))/(2*a)
root2 = (-b - sqrt(b^2 - 4*a*c))/(2*a)
sum2 = ceil(root2) - ceil(root1)

println("Solution part 1:", sum)
println("Solution part 2:", format(sum2))
# close the file instance
close(f)



