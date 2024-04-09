use std::fs;

const N     :usize = 141;
const L     :usize = 3;
const FOUR_L :usize = 4*L;

fn dir_to_tuple(dir: usize) -> Vec<(i32, i32)> {
    let mut v = Vec::new();

    if dir == 0 {
        v.push(( 0,  1));
        v.push((-1,  0));
        v.push(( 1,  0));
    } else if dir == 1 {
        v.push((-1,  0));
        v.push(( 0, -1));
        v.push(( 0,  1));
    } else if dir == 2 {
        v.push(( 0, -1));
        v.push(( 1,  0));
        v.push((-1,  0));
    } else if dir == 3 {
        v.push((1,  0));
        v.push((0,  1));
        v.push((0, -1));
    } 
    return v
}

fn check_bounds(i:usize, j:usize) -> bool {
    if i < N && j < N {
        return true
    }
    return false
} 

fn get_neighbors((i, j, k): (usize, usize, usize)) -> Vec<(usize, usize, usize)> {
    let mut neighbors = Vec::new();

    let dir = k/L;
    let steps = dir_to_tuple(dir);
    for (n, step) in steps.iter().enumerate() {
        let new_i = ((i as i32) + step.0) as usize;
        let new_j = ((j as i32) + step.1) as usize;
        if check_bounds(new_i, new_j) {
            if n == 0 && (k+1) % L > 0 {
                neighbors.push((new_i, new_j, k+1));
            } else if n == 1 {
                neighbors.push((new_i, new_j, (dir+1)*L % FOUR_L));
            } else if n == 2{
                neighbors.push((new_i, new_j, (dir+3)*L % FOUR_L));
            }
        }
    }
    neighbors
}

fn get_min_elem(v : &mut Vec<(usize, usize, usize)>, dists:[[[u32; FOUR_L]; N]; N]) -> (usize, usize, usize) {
    let mut min_d = u32::MAX;
    let mut min_elem = 0;
    for (elem, (i, j, k)) in v.iter().enumerate() {
        if dists[*i][*j][*k] < min_d {
            min_d = dists[*i][*j][*k];
            min_elem = elem;
        }
    }
    v.remove(min_elem)
}

fn main() {
    let contents = fs::read_to_string("inputs/day17.txt").expect("please");

    let mut map: [[u32; N] ;N] = [[0; N]; N];
    for (i, line) in contents.split("\n").enumerate() {
        for (j, sym) in line.as_bytes().iter().enumerate() {
            map[i][j] = (sym - b'0') as u32;
        }
    }
    let mut visited: [[[u8; FOUR_L]; N]; N] = [[[0; FOUR_L]; N]; N]; // 0 not visited, 1 == in queue, 2 == visited
    let mut dists:[[[u32; FOUR_L]; N]; N] = [[[u32::MAX; FOUR_L]; N]; N];
    let mut v = Vec::new();

    visited[0][0][0] = 2;
    dists[0][0][0] = 0;

    visited[0][1][0] = 1;
    visited[1][0][9] = 1;
    dists[0][1][0] = map[0][1];
    dists[1][0][9] = map[1][0];
    v.push((0, 1, 0));
    v.push((1, 0, 9));

    while v.len() > 0 {
        let (cur_i, cur_j, cur_k) = get_min_elem(&mut v, dists);
        visited[cur_i][cur_j][cur_k] = 2;
        let dist = dists[cur_i][cur_j][cur_k];

        for (nei_i, nei_j, nei_k) in get_neighbors((cur_i, cur_j, cur_k)) {
            //println!("cur : {:?}, neighbor: {:?}", (cur_i, cur_j, cur_k), (nei_i, nei_j, nei_k));
            if visited[nei_i][nei_j][nei_k] == 2 {
                continue;
            }

            let ten_dist = dist + map[nei_i][nei_j];
            if ten_dist < dists[nei_i][nei_j][nei_k] {
                dists[nei_i][nei_j][nei_k] = ten_dist;
            }
            if visited[nei_i][nei_j][nei_k] == 0 {
                v.push((nei_i, nei_j, nei_k));
                visited[nei_i][nei_j][nei_k] = 1;
            }
        }
    }
    println!("{:?}", dists[N-1][N-1])
}