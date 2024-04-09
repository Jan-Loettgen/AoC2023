use std::fs;

fn hash(s: &str) -> (usize, usize) {
    let mut val = 0;
    let mut i: usize = 0;
    for c in s.chars(){
        if c == '\n' || c == '-' || c=='=' {
            break
        }
        val += c as usize;
        val = val * 17;
        val = val % 256;
        i += 1
    }
    (val, i)
}

fn find_elem(vec: &Vec<(&str, usize)>, tar:&str) -> Option<usize>{
    for i in 0..vec.len() {
        if vec[i].0 == tar{
            return Some(i);
        }
    }
    return None;
}

fn main() {

    let contents = fs::read_to_string("inputs/day15.txt").expect("please");

    //let mut boxes: [i32; 256] = [0; 256];
    //let mut boxes: [Vec<i32>; 100] = Default::default();

    let mut vec: Vec<Vec<(&str, usize)>> = vec![];
    for i in 0..256 {
        vec.push(vec![]);
    }
    let lines = contents.split(',');
    let mut sum = 0;
    for line in lines {
        let (key, i) = hash(line);
        if line.as_bytes()[i] == b'=' {
            match find_elem(&vec[key], &line[0..i]) {
                Some(x) => vec[key][x] = (&line[0..i], line[i+1..].parse::<usize>().unwrap()),
                None => vec[key].push((&line[0..i], line[i+1..].parse::<usize>().unwrap())),
            };
        } else {    
            match find_elem(&vec[key], &line[0..i]) {
                Some(x) => vec[key].remove(x),
                None => ("s",5 as usize),
            };
        }
    }
    for i in 0..256 {
        for j in 0..vec[i].len() {
        sum += (i+1)*(j+1)*vec[i][j].1;
        }
    }
    println!("{:?}", sum);
}