use std::fmt;

#[derive(Debug, PartialEq)]
pub struct Clock {
    hours: i32,
    minutes: i32,
}

impl Clock {
    pub fn new(hours: i32, minutes: i32) -> Self {
        let (adjusted_minutes, rollover_hours) = Clock::sanitize_minutes(minutes);
        let adjusted_hours = Clock::sanitize_hours(hours + rollover_hours);

        Clock {
            hours: adjusted_hours,
            minutes: adjusted_minutes,
        }
    }

    pub fn add_minutes(&self, minutes: i32) -> Self {
        Clock::new(self.hours, self.minutes + minutes)
    }

    fn sanitize_hours(hours: i32) -> i32 {
        if hours < 0 {
            Clock::sanitize_hours(24 + hours)
        } else {
            hours % 24
        }
    }

    fn sanitize_minutes(minutes: i32) -> (i32, i32) {
        let hours = minutes / 60;
        let remaining_minutes = minutes % 60;

        if minutes < 0 {
            let offset_minutes = 60 + remaining_minutes;
            let offset_hours = offset_minutes / 60;

            (offset_minutes % 60, hours + offset_hours - 1)
        } else {
            (remaining_minutes, hours)
        }
    }
}

impl fmt::Display for Clock {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{:02}:{:02}", self.hours, self.minutes)
    }
}
