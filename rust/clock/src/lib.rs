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
            minutes: Clock::sanitize_minutes(minutes + MINUTES_PER_HOUR * hours),
        }
    }

    pub fn add_minutes(&self, minutes: i32) -> Self {
        Clock::new(0, self.minutes + minutes)
    }

    fn sanitize_minutes(minutes: i32) -> i32 {
        if minutes < 0 {
            Clock::sanitize_minutes(HOURS_PER_DAY + minutes)
        } else {
            minutes % HOURS_PER_DAY
        }
    }
}

impl fmt::Display for Clock {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        let hours = self.minutes / MINUTES_PER_HOUR;
        let minutes = self.minutes % MINUTES_PER_HOUR;
        write!(f, "{:02}:{:02}", hours, minutes)
    }
}
