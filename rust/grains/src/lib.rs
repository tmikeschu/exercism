pub fn square(s: u32) -> u64 {
    if !(1..=64).contains(&s) {
        panic!("Square must be between 1 and 64")
    }
    (2 as u64).pow(s - 1) as u64
}

pub fn total() -> u64 {
    (1..=64).map(square).sum()
}
