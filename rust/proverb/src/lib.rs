pub fn build_proverb(list: &[&str]) -> String {
    match list {
        &[] => String::new(),
        _ => {
            let mut proverb = list
                .windows(2)
                .map(|w| format!("For want of a {} the {} was lost.", w[0], w[1]))
                .collect::<Vec<_>>();
            proverb.push(format!("And all for the want of a {}.", list[0]));
            proverb.join("\n")
        }
    }
}
