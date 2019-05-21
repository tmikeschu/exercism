const OPENERS: &str = "{([";
const CLOSERS: &str = "})]";
const BRACKETS: &str = "{}()[]";

pub fn brackets_are_balanced(string: &str) -> bool {
    let mut openers = Vec::new();

    for c in string.chars() {
        if OPENERS.contains(c) {
            openers.push(c);
        } else if CLOSERS.contains(c)
            && openers
                .pop()
                .and_then(closer_for)
                .filter(|expected_closer| *expected_closer == c)
                .is_none()
        {
            return false;
        }
    }

    openers.is_empty()
}

fn closer_for(bracket: char) -> Option<char> {
    BRACKETS
        .find(bracket)
        .and_then(|index| BRACKETS.chars().skip(index + 1).next())
}
