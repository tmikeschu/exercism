pub fn find() -> Option<u32> {
    for a in 200..600 {
        for b in 200..600 {
            for c in 282..600 {
                if a + b + c == 1000 {
                    if is_triplet(a, b, c) {
                        return Some(a * b * c);
                    }
                }
            }
        }
    }

    None
}

fn is_triplet(a: u32, b: u32, c: u32) -> bool {
    let a2 = a.pow(2);
    let b2 = b.pow(2);
    let c2 = c.pow(2);
    a2 + b2 == c2 || b2 + c2 == a2 || a2 + c2 == b2
}
