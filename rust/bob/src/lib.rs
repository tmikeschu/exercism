use regex::Regex;

const SHOUT: &str = "SHOUT";
const QUESTION: &str = "QUESTION";
const SHOUTING_QUESTION: &str = "SHOUTQUESTION";
const SILENT: &str = "SILENT";

fn shout(s: &str) -> &str {
    if Regex::new(r"[A-Z]").unwrap().is_match(s) && s.to_uppercase() == s {
        SHOUT
    } else {
        ""
    }
}

fn question(s: &str) -> &str {
    if s.trim().ends_with("?") {
        QUESTION
    } else {
        ""
    }
}

fn silence(s: &str) -> &str {
    if s.trim() == "" {
        SILENT
    } else {
        ""
    }
}

pub fn reply(message: &str) -> &str {
    let classification: &str = &format!(
        "{}{}{}",
        shout(message),
        question(message),
        silence(message)
    );

    return match classification {
        SHOUTING_QUESTION => "Calm down, I know what I'm doing!",
        SHOUT => "Whoa, chill out!",
        QUESTION => "Sure.",
        SILENT => "Fine. Be that way!",
        _ => "Whatever.",
    };
}
