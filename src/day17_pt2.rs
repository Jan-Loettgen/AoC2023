use std::fs;



const N     :usize = 141;
const N_I32 :i32 = N as i32;
const L_MIN :i32 = 4;
const L_MAX :i32 = 10;

fn dir_to_tuple(dir: usize) -> Vec<((i32, i32), usize)> {
    let mut v = Vec::new();

    if dir == 0 {
        v.push((( 0,  1), 0));
        v.push(((-1,  0), 1));
        v.push((( 1,  0), 3));
    } else if dir == 1 {
        v.push(((-1,  0), 1));
        v.push((( 0, -1), 2));
        v.push((( 0,  1), 0));
    } else if dir == 2 {
        v.push((( 0, -1), 2));
        v.push((( 1,  0), 3));
        v.push(((-1,  0), 1));
    } else if dir == 3 {
        v.push(((1,  0), 3));
        v.push(((0,  1), 0));
        v.push(((0, -1), 2));
    } 
    return v
}

// k = (d, l), 
// d = 0, 1, 2, 3 (east, north, west, south)
// l = L_min, ..., L_max
fn get_neighbors(i_start:usize, j_start:usize, dir:usize) -> Vec<(usize, usize, usize)> {
    let mut neighbors = Vec::new();
    
    for (step, new_dir) in dir_to_tuple(dir){
        let mut i = (i_start as i32) + step.0*(L_MIN-1);
        let mut j = (j_start as i32) + step.1*(L_MIN-1);
        for _ in L_MIN..L_MAX {
            i = i + step.0;
            j = j + step.1;

            if i < 0 || i >= N_I32 || j<0 || j >= N_I32 {
                break;
            }
            neighbors.push((i as usize, j as usize, new_dir));
        }
    }
    return neighbors
}

fn search(i, j, k, dists, visited) -> u32{
    min_dist = u32::MAX;
    v = Vec::new();
    for (nei_i, nei_j, nei_dir) in get_neighbors(i, j, k){
        let mut dist = u32:MAX
        if visited[nei_i, nei_j, nei_dir] == 2 {
            dist = dists[nei_i, nei_j, nei_dir] + map[nei_i, nei_j];
        } else {
            dist = search(nei_i, nei_j, nei_dir);
        }

        let dist = match visited[nei_i][nei_j][nei_dir] {
            0 => search(nei_i, nei_j, nei_dir),
            1 => ,
            _ => dists[nei_i, nei_j, nei_dir] + map[nei_i, nei_j],
        }

        if dist < min_dist {
            min_dist = dist
        }
    }
    dists[i, j, k] = min_dist;
    return min_dist;
}


fn main() {
    let contents = fs::read_to_string("inputs/day17.txt").expect("please");

    let mut map: [u32; N*N] = [0; N*N];
    for (i, line) in contents.split("\n").enumerate() {
        for (j, sym) in line.as_bytes().iter().enumerate() {
            map[i*N+j] = (sym - b'0') as u32;
        }
    }
    let mut dists:[u32; N*N] = [u32::MAX; N*N];
    let mut prevs:[u32; N*N] = [u32::MAX; N*N];
    let mut visited:[[[u8;  4]; N]; N]  = [[[0; N]; N]; N];
    let mut to_vis = vec![(N*N - 1)];

    println!("{:?}", get_neighbors(0, 0, 0));
}