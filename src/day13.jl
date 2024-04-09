function find_reflection(line, n_smudges = 0)
    n = length(line)
    global bins
    for i in 1:(n-1)
        smudges = 0
        if line[i] == line[i+1] || (abs(line[i] - line[i+1]) in bins)
            if line[i] != line[i+1]
                smudges += 1
            end

            if (i == 1 || i == n-1)
                if smudges == n_smudges
                    return i
                else
                    continue
                end
            end

            j = i - 1
            k = i + 2
            while line[j] == line[k] || ((smudges <= n_smudges) && (abs(line[j] - line[k]) in bins))
                if line[j] != line[k]
                    smudges += 1
                end
                if (j == 1 || k == n)   
                    if smudges == n_smudges
                        return i
                    else
                        break
                    end
                end
                j = j - 1
                k = k + 1
            end
        end
    end
    return 0
end

function hash_mirror(mirror)
    n_rows = length(mirror)
    n_cols = length(mirror[1])

    x_hash = zeros(n_rows) # hashing of rows
    y_hash = zeros(n_cols) # hashing of columns
    for i in 1:n_rows
        for j in 1:n_cols
            if mirror[i][j] == '#'
                x_hash[i] += 2^(n_cols - j)
            end
            if mirror[i][j] == '#'
                y_hash[j] += 2^(n_rows - i)
            end
        end
    end
    return (x_hash, y_hash)
end

f = open("./inputs/day13.txt", "r")
lines = readlines(f)

global bins = [2^(i-1) for i in 1:100]

sum1 = 0
sum2 = 0
global mirror = []
count = 1
for line in lines
    if length(line) == 0
        (x_hash, y_hash) = hash_mirror(mirror)

        global sum1 += 100*find_reflection(x_hash, 0)
        global sum1 += find_reflection(y_hash, 0)
        global sum2 += 100*find_reflection(x_hash, 1)
        global sum2 += find_reflection(y_hash, 1)
        println(count-1, " ",find_reflection(x_hash, 1), " ", find_reflection(x_hash, 0))
        println(x_hash)
        #println(count-1, " ",find_reflection(y_hash, 1), " ", find_reflection(y_hash, 0))
        global mirror = []
        global count += 1
        continue
    end

    push!(mirror, [])
    for c in line
        push!(mirror[end], c)
    end
end

println(sum1)
println(sum2)