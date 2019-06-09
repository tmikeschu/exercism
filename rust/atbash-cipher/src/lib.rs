use itertools::Itertools;
use std::iter::Iterator;

const ASCII_LOWER: [char; 26] = [
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's',
    't', 'u', 'v', 'w', 'x', 'y', 'z',
];

/// "Encipher" with the Atbash cipher.
pub fn encode(plain: &str) -> String {
    plain
        .to_lowercase()
        .chars()
        .filter(char::is_ascii_alphanumeric)
        .map(flip_char)
        .chunks(5)
        .into_iter()
        .map(Iterator::collect::<String>)
        .collect::<Vec<_>>()
        .join(" ")
}

/// "Decipher" with the Atbash cipher.
pub fn decode(cipher: &str) -> String {
    cipher.replace(" ", "").chars().map(flip_char).collect()
}

fn flip_char(c: char) -> char {
    ASCII_LOWER
        .iter()
        .position(|&x| x == c)
        .map_or(c, |i| ASCII_LOWER[25 - i])
}
