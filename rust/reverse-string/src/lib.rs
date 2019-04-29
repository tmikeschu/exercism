pub fn reverse(input: &str) -> String {
    let mut output = String::with_capacity(input.len());

    for c in input.chars() {
        output.insert_str(0, &c.to_string())
    }

    output
}
