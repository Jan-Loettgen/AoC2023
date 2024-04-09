use std::fs;

const N:usize = 110;

fn dir_map(dir: (i32, i32)) -> char {
    match dir {
        (0, 1 ) => '1', // east
        (-1, 0) => '2', // north
        (0, -1) => '3', // west
        (1, 0 ) => '4', // south
        _ => unreachable!("Should never happen."),
    }
}

fn eval_beam(mut to_visit: Vec<((i32, i32), (i32, i32))>, map:[[char; N]; N]) -> i32 {
    let mut visited_map = [['0'; N]; N];
    let mut sum = 0;
    while to_visit.len() > 0 {
        let (c, dir) = to_visit.pop().unwrap();

        if visited_map[c.0 as usize][c.1 as usize] != '0' {
            if visited_map[c.0 as usize][c.1 as usize] == dir_map(dir) {
                continue;
            }
        } else {
            sum += 1;
        }
        visited_map[c.0 as usize][c.1 as usize] = dir_map(dir); // shouldnt add but what if direction isdifferent?
        let new_c = (c.0 + dir.0, c.1 + dir.1);

        if new_c.0 >= N as i32 || new_c.1 >= N as i32 || new_c.0 < 0 || new_c.1 < 0  {
            continue;
        }

        let next_tile = map[new_c.0 as usize][new_c.1 as usize];
        if next_tile == '.' {
            to_visit.push((new_c, dir));
        } else if next_tile == '-' {
            if dir.0 == 0 {
                to_visit.push((new_c, dir));
            } else {
                to_visit.push((new_c, (0, 1)));
                to_visit.push((new_c, (0, -1)));
            }
        } else if next_tile == '|' {
            if dir.1 == 0 {
                to_visit.push((new_c, dir));
            } else {
                to_visit.push((new_c, (1, 0)));
                to_visit.push((new_c, (-1, 0)));
            }
        } else if next_tile == '/' {
            let new_dir = match dir {
                (0, 1) => (-1, 0),
                (-1, 0) => (0, 1),
                (0, -1) => (1, 0),
                (1, 0) => (0, -1),
                _ => unreachable!("Should never happen."),
            };
            to_visit.push((new_c, new_dir));
        } else if next_tile == '\\' {
            let new_dir = match dir {
                (0, 1) => (1, 0),
                (1, 0) => (0, 1),
                (0, -1) => (-1, 0),
                (-1, 0) => (0, -1),
                _ => unreachable!("Should never happen."),
            };
            to_visit.push((new_c, new_dir));
        }
    }
    sum
}

fn main() {
    let contents = fs::read_to_string("inputs/day16.txt").expect("please");

    let mut map = [['.'; N]; N];
    for (i, line) in contents.split("\n").enumerate() {
        for (j, sym) in line.chars().enumerate() {
            map[i][j] = sym;
        }
    }
    // dirs (0, 1) = east, (-1, 0) = north, (0, -1) = west, (1, 0) = south
    let mut to_visit: Vec<((i32, i32), (i32, i32))> = vec![((0, 0), (1, 0))];
    println!("Solution part 1: {}", eval_beam(to_visit, map));

    let mut max_sum = 0;
    for i in 0..(N as i32){
        let sum = eval_beam(vec![((0, i), (1, 0))], map);
            if sum > max_sum {
                max_sum = sum;
            }
        let sum = eval_beam(vec![(((N as i32) - 1, i), (-1, 0))], map);
            if sum > max_sum {
                max_sum = sum;
            }
        let sum = eval_beam(vec![((i, 0), (0, 1))], map);
            if sum > max_sum {
                max_sum = sum;
            }
        let sum = eval_beam(vec![((i, (N as i32) -1), (0, -1))], map);
        if sum > max_sum {
            max_sum = sum;
        }
    }
    println!("Solution part 2: {}", max_sum);
}