use itertools::Itertools;
use std::iter::Iterator;

const A: u8 = b'a';
const Z: u8 = b'z';

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
    (c as u8)
        .checked_sub(A)
        .and_then(|x| Z.checked_sub(x))
        .map_or(c, |x| x as char)
}
