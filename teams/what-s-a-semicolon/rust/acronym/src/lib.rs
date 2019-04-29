pub fn abbreviate(phrase: &str) -> String {
    let words: Vec<&str> = phrase.split(&[' ', ',', '-'][..]).collect();
    let mut output = String::from("");

    for word in words {
        for (i, c) in word.chars().enumerate() {
            if i == 0 || (char_is_upper(&c) && !last_was_uppercase(word.chars())) {
                output.push(c)
            }
        }
    }

    return output.to_uppercase();
}

fn last_was_uppercase(chars: std::str::Chars) -> bool {
    match chars.last() {
        Some(c) => char_is_upper(&c),
        None => false,
    }
}

fn char_is_upper(c: &char) -> bool {
    c.to_uppercase().to_string() == c.to_string()
}
