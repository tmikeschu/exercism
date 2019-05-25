pub fn verse(n: i32) -> String {
  format!(
    "{} of beer on the wall, {} of beer.\n{}",
    capitalize(bottles_of_beer(n)),
    bottles_of_beer(n),
    take_down(n)
  )
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
        c.to_string().to_uppercase(),
        s.chars().skip(1).collect::<String>()
      )
    })
    .unwrap_or(s)
}

fn take_down(n: i32) -> String {
  match n {
    0 => "Go to the store and buy some more, 99 bottles of beer on the wall.\n".to_string(),
    _ => format!(
      "Take {} down and pass it around, {} of beer on the wall.\n",
      if n == 1 { "it" } else { "one" },
      bottles_of_beer(n - 1)
    ),
  }
}

pub fn sing(start: i32, end: i32) -> String {
  (end..start + 1)
    .rev()
    .map(|i| verse(i))
    .collect::<Vec<_>>()
    .join("\n")
}
