use std::collections::HashSet;

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let lowered = word.to_lowercase();
    let sorted = sort(&lowered);

    possible_anagrams
        .iter()
        .cloned()
        .filter(|possible_anagram| {
            let lowered2 = possible_anagram.to_lowercase();
            sort(&lowered2) == sorted && lowered2 != lowered
        })
        .collect()
}

fn sort(s: &str) -> Vec<char> {
    let mut letters = s.chars().collect::<Vec<char>>();
    letters.sort();
    letters
}
