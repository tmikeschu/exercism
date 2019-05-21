pub fn brackets_are_balanced(string: &str) -> bool {
    let mut openers = Vec::new();

    for c in string.chars() {
        match c {
            '(' | '[' | '{' => openers.push(c),
            ')' | ']' | '}' => {
                if is_not_balanced(&mut openers, c) {
                    return false;
                }
            }
            _ => (),
        }
    }

    openers.is_empty()
}

fn is_not_balanced(openers: &mut Vec<char>, closer: char) -> bool {
    openers
        .pop()
        .and_then(closer_for)
        .filter(|expected| *expected == closer)
        .is_none()
}

const BRACKETS: &str = "()[]{}";
fn closer_for(opener: char) -> Option<char> {
    BRACKETS
        .find(opener)
        .and_then(|index| BRACKETS.chars().skip(index + 1).next())
}
