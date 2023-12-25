function find_mirror(line)
    n = length(line)

    for i in 1:(n-1)
        if line[i] == line[i+1]
            if i == 1 || i == n-1
                return i
            end

            j = i - 1
            k = i + 2
            while line[j] == line[k]
                if j == 1 || k == n
                    return i
                end
                j = j - 1
                k = k + 1
            end
        end
    end
    return 0
end

function find_smudge(line)
    n = length(line)
    global bins

    smudge_avail = true
    for i in 1:(n-1)
        if line[i] == line[i+1] || (abs(line[i] - line[i+1]) in bins)
            if i == 1 || i == n-1
                return i
            end

            if line[i] != line[i+1]
                smudge_avail = false
            end

            j = i - 1
            k = i + 2
            while line[j] == line[k] || (smudge_avail && (abs(line[i] - line[i+1]) in bins))
                if line[j] != line[k]
                    smudge_avail = false
                end
                if j == 1 || k == n
                    return i
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

f = open("./inputs/day13_sample.txt", "r")
lines = readlines(f)

global bins = [2^(i-1) for i in 1:100]

sum1 = 0
sum2 = 0
global mirror = []
count = 1
for line in lines
    if length(line) == 0
        (x_hash, y_hash) = hash_mirror(mirror)
        #println(find_smudge(x_hash))

        global sum1 += 100*find_mirror(x_hash)
        global sum1 += find_mirror(y_hash)
        global sum2 += 100*find_smudge(x_hash)

        #if find_smudge(x_hash) != find_mirror(x_hash)
            println(count, " ", find_mirror(x_hash)," ", find_smudge(x_hash)," ", x_hash)
        #end
        #println(count," ", find_smudge(x_hash), " - ",x_hash)
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