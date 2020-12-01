use std::fs;

fn main() {
    let contents = fs::read_to_string("input.txt").expect("Something went wrong reading the file");
    let numbers = contents.lines();
    let vec: Vec<&str> = numbers.collect();
    for one in &vec {
        for two in &vec {
            let o = match one.parse::<i32>() {
                Ok(o) => o,
                Err(_e) => -1,
            };
            let t = match two.parse::<i32>() {
                Ok(t) => t,
                Err(_e) => -1,
            };
            if o + t == 2020 {
                println!("{}", o * t);
            }
        }
    }
}
