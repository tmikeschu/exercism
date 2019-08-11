pub fn factors(n: u64) -> Vec<u64> {
    match n {
        1 => vec![],
        2 => vec![2],
        mut x => {
            let mut sieve = (1..=n).flat_map(|x| (2 * x..n).filter(move |y| y % x == 0));
            let mut fs = Vec::new();
            let mut f = sieve.next().unwrap();

            loop {
                if x == 1 {
                    break;
                }

                if x % f == 0 {
                    fs.push(f);
                    x = x / f;
                } else {
                    f = sieve.next().unwrap()
                }
            }
            fs
        }
    }
}
