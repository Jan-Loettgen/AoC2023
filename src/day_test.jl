global N = 142

function inside(verticies, px, py)
    angle = 0
    for i in range(1, length(verticies))
        dx1 = verticies[i][1] - px
        dy1 = verticies[i][2] - py  

        dx2 = verticies[((i+1)%length(verticies))+1][1] - px
        dy2 = verticies[((i+1)%length(verticies))+1][2] - py       
        theta1 = atan(dy1, dx1)
        theta2 = atan(dy2, dx2)

        dtheta = theta2-theta1

        while (dtheta > pi)
            dtheta -= 2*pi
        end
        while (dtheta < -pi)
            dtheta += 2*pi
        end

        angle += dtheta
    end
    if abs(angle) > 2*pi
        return true
    else
        return false
    end
end

map_outside = Array{Char}(undef, (N, N))
map_inside  = Array{Char}(undef, (N, N))
map         = Array{Char}(undef, (N, N))

for (i,line) in enumerate(readlines(open("inside.txt", "r")))
    for j in range(1, N)
        map_inside[i, j] = line[j]
    end 
end

for (i,line) in enumerate(readlines(open("outside.txt", "r")))
    for j in range(1, N)
        map_outside[i, j] = line[j]
    end 
end


pts_unknown = []
pts_verticies = []
for i in range(1, N)
    for j in range(1, N)
        if map_inside[i, j] == '.' && map_outside[i, j] == '.'
            push!(pts_unknown, (i, j))
            map[i, j] = 'X'
        else
            map[i, j] = map_inside[i, j]
        end

        if map_inside[i, j] == 'J' || map_inside[i, j] == 'F' || map_inside[i, j] == '7' || map_inside[i, j] == 'L'
            push!(pts_verticies, (i, j))
        end
    end
end

xs = 0
for unknown in pts_unknown
    if inside(pts_verticies, unknown[1], unknown[2]) == true
        global xs += 1
    end
end

println(xs+397)