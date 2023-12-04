f = open("/home/luca/Desktop/fun/AoC2023/inputs/day4.txt", "r")
 
# do some file operations

# to count total lines in the file
line_count = 0             
 
sum1 = 0
wins = zeros((214,))
copies = ones(Int64, (214,))

for lines in readlines(f) 
    lines = split(lines,": ")[2]
    # print the line
    lines = split(lines, '|')
    win_nums = split(lines[1], ' ')
    nums     = split(lines[2], ' ')
    
    deleteat!(win_nums, findall(x->x=="",win_nums))
    deleteat!(nums, findall(x->x=="",nums))


    count = 0
    for num in nums
        if num in win_nums
            #win_nums.pop(num)
            count = count + 1
            end
    end

    wins[line_count + 1] += count

    if count > 0
        global sum1 += 2^(count-1)
    end


    #println(count)
    for i in range(0,count-1)
        copies[line_count+i+2] += copies[line_count+1]
    end


    # increment line_count
    global line_count += 1 
end

println(sum1)
println(sum(copies))
# close the file instance
close(f)



