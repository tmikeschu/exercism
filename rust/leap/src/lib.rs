pub fn is_leap_year(year: u64) -> bool {
    let is_evenly_divisible = |n| year % n == 0;

    is_evenly_divisible(4) && (!is_evenly_divisible(100) || is_evenly_divisible(400))
}
