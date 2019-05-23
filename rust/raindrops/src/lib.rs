pub fn raindrops(n: u32) -> String {
    transform(n).unwrap_or(n.to_string()).to_string()
}

fn transform(n: u32) -> Option<String> {
    let transformers: &[&dyn Fn(u32) -> Option<&'static str>] = &[&pling, &plang, &plong];

    match transformers
        .iter()
        .filter_map(|transformer| transformer(n))
        .collect::<Vec<_>>()
        .as_slice()
    {
        [] => None,
        x => Some(x.join("")),
    }
}

const PLING: &str = "Pling";
fn pling(n: u32) -> Option<&'static str> {
    Some(n).filter(|n| n % 3 == 0).map(|_| PLING)
}

const PLANG: &str = "Plang";
fn plang(n: u32) -> Option<&'static str> {
    Some(n).filter(|n| n % 5 == 0).map(|_| PLANG)
}

const PLONG: &str = "Plong";
fn plong(n: u32) -> Option<&'static str> {
    Some(n).filter(|n| n % 7 == 0).map(|_| PLONG)
}
