use std::fmt;

pub fn raindrops(n: u32) -> String {
    use RainSound::*;
    let sounds: &[RainSound] = &[Pling, Plang, Plong];

    match sounds
        .iter()
        .filter_map(|sound| sound.convert(n))
        .collect::<Vec<_>>()
        .join("")
        .as_ref()
    {
        "" => n.to_string(),
        x => x.to_string(),
    }
}

#[derive(Copy, Clone, Debug)]
enum RainSound {
    Pling,
    Plang,
    Plong,
}

impl RainSound {
    fn convert(self, n: u32) -> Option<String> {
        Some(n).filter(|&n| self.test(n)).map(|_| self.to_string())
    }

    fn test(self, n: u32) -> bool {
        n % self.to_u32() == 0
    }

    fn to_u32(&self) -> u32 {
        use RainSound::*;
        match self {
            Pling => 3,
            Plang => 5,
            Plong => 7,
        }
    }
}

impl fmt::Display for RainSound {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{:?}", self)
    }
}
