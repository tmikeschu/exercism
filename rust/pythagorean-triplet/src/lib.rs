use rayon::iter::{IntoParallelIterator, ParallelIterator};
use std::collections::HashSet;

pub fn find(n: u32) -> HashSet<[u32; 3]> {
    (1..(n / 3))
        .into_par_iter()
        .filter_map(|a| {
            let bc = n - a;
            let b = (bc.pow(2) - a.pow(2)) / (bc * 2);
            let c = bc - b;

            if is_triplet(a, b, c) {
                Some([a, b, c])
            } else {
                None
            }
        })
        .collect::<HashSet<_>>()
}

fn is_triplet(a: u32, b: u32, c: u32) -> bool {
    a < b && a.pow(2) + b.pow(2) == c.pow(2)
}
