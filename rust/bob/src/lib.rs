pub fn reply(message: &str) -> &str {
    classify(message).map_or("Whatever.", Classification::respond)
}

#[derive(Copy, Clone)]
enum Classification {
    Question,
    Shout,
    ShoutingQuestion,
    Silent,
}

fn classify(message: &str) -> Option<Classification> {
    use Classification::*;
    let classifications: &[Classification] = &[ShoutingQuestion, Shout, Question, Silent];

    classifications.iter().find(|c| c.test(message)).map(|c| *c)
}

impl Classification {
    fn test(self, message: &str) -> bool {
        use Classification::*;

        let predicate: &dyn Fn(&str) -> bool = match self {
            Question => &is_question,
            Shout => &is_shout,
            ShoutingQuestion => &is_shouting_question,
            Silent => &is_silent,
        };

        predicate(message)
    }

    fn respond<'a>(self) -> &'a str {
        use Classification::*;
        match self {
            Question => "Sure.",
            Shout => "Whoa, chill out!",
            ShoutingQuestion => "Calm down, I know what I'm doing!",
            Silent => "Fine. Be that way!",
        }
    }
}

fn is_shout(s: &str) -> bool {
    !s.chars().any(char::is_lowercase) && s.chars().any(char::is_alphabetic)
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
