pub fn verse(n: i32) -> String {
  format!(
    "{} of beer on the wall, {} of beer.\n{}, {} of beer on the wall.\n",
    capitalize(bottles_of_beer(n)),
    bottles_of_beer(n),
    take_down(n),
    bottles_of_beer(next_number(n))
  )
}

pub fn sing(start: i32, end: i32) -> String {
  (end..start + 1)
    .rev()
    .map(verse)
    .collect::<Vec<_>>()
    .join("\n")
}

fn bottles_of_beer(n: i32) -> String {
  match n {
    0 => String::from("no more bottles"),
    1 => String::from("1 bottle"),
    x => format!("{} bottles", x),
  }
}

fn capitalize(s: String) -> String {
  s.chars()
    .nth(0)
    .map(|c| {
      format!(
        "{}{}",
        c.to_uppercase(),
        s.chars().skip(1).collect::<String>()
      )
    })
    .unwrap_or(s)
}

fn next_number(n: i32) -> i32 {
  match n {
    0 => 99,
    _ => n - 1,
  }
}

fn take_down(n: i32) -> String {
  match n {
    0 => String::from("Go to the store and buy some more"),
    _ => format!(
      "Take {} down and pass it around",
      if n == 1 { "it" } else { "one" },
    ),
  }
}
