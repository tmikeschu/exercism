use regex::Regex;

fn is_shouting(s: &str) -> bool {
    Regex::new(r"[A-Z]").unwrap().is_match(s) && s.to_uppercase() == s
}

fn is_asking(s: &str) -> bool {
    s.trim().ends_with("?")
}

pub fn reply(message: &str) -> &str {
    if message.trim() == "" {
        "Fine. Be that way!"
    } else if is_shouting(message) && is_asking(message) {
        "Calm down, I know what I'm doing!"
    } else if is_shouting(message) {
        "Whoa, chill out!"
    } else if is_asking(message) {
        "Sure."
    } else {
        "Whatever."
    }
}
