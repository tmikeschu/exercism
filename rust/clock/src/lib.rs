use modulo::Mod;
use num_integer::Integer;
use std::fmt;

const MINUTES_PER_HOUR: i32 = 60;
const HOURS_PER_DAY: i32 = 1440;

#[derive(Debug, PartialEq)]
pub struct Clock {
    minutes: i32,
}

impl Clock {
    pub fn new(hours: i32, minutes: i32) -> Self {
        Clock {
            minutes: (minutes + MINUTES_PER_HOUR * hours).modulo(HOURS_PER_DAY),
        }
    }

    pub fn add_minutes(&self, minutes: i32) -> Self {
        Clock::new(0, self.minutes + minutes)
    }
}

impl fmt::Display for Clock {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        let (hours, minutes) = self.minutes.div_rem(&MINUTES_PER_HOUR);
        write!(f, "{:02}:{:02}", hours, minutes)
    }
}
