use regex::Regex;

const SHOUT: &str = "SHOUT";
const SHOUT_RESPONSE: &str = "Whoa, chill out!";

const QUESTION: &str = "QUESTION";
const QUESTION_RESPONSE: &str = "Sure.";

const SHOUTING_QUESTION: &str = "SHOUTQUESTION";
const SHOUTING_QUESTION_RESPONSE: &str = "Calm down, I know what I'm doing!";

const SILENT: &str = "SILENT";
const SILENT_RESPONSE: &str = "Fine. Be that way!";

const DEFAULT_RESPONSE: &str = "Whatever.";

pub fn reply(message: &str) -> &str {
    let classification_classifiers: Vec<(&str, Box<Fn(&str) -> bool>)> = vec![
        (SHOUTING_QUESTION, Box::new(is_shouting_question)),
        (SHOUT, Box::new(is_shout)),
        (QUESTION, Box::new(is_question)),
        (SILENT, Box::new(is_silent)),
    ];

    get_response(
        classification_classifiers
            .iter()
            .find(|(_, classifier)| classifier(message))
            .map_or("", |(classification, _)| classification),
    )
}

fn is_shout(s: &str) -> bool {
    Regex::new(r"[A-Z]").unwrap().is_match(s) && s.to_uppercase() == s
}

fn is_question(s: &str) -> bool {
    s.trim().ends_with("?")
}

fn is_silent(s: &str) -> bool {
    s.trim().is_empty()
}

fn is_shouting_question(s: &str) -> bool {
    is_shout(s) && is_question(s)
}

fn get_response(s: &str) -> &str {
    return match s {
        SHOUTING_QUESTION => SHOUTING_QUESTION_RESPONSE,
        SHOUT => SHOUT_RESPONSE,
        QUESTION => QUESTION_RESPONSE,
        SILENT => SILENT_RESPONSE,
        _ => DEFAULT_RESPONSE,
    };
}
