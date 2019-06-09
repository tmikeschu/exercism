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
        .collect::<Vec<_>>()
        .as_slice()
        .chunks(5)
        .map(|el| {
            el.iter()
                .map(|c| c.to_string())
                .collect::<Vec<_>>()
                .join("")
        })
        .collect::<Vec<_>>()
        .join(" ")
}

/// "Decipher" with the Atbash cipher.
pub fn decode(cipher: &str) -> String {
    cipher
        .replace(" ", "")
        .chars()
        .map(|c| flip_char(c).to_string())
        .collect::<String>()
}

fn flip_char(c: char) -> char {
    ASCII_LOWER
        .iter()
        .position(|&x| x == c)
        .map(|i| ASCII_LOWER[25 - i])
        .unwrap_or(c)
}
