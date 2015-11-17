# Haskell Dates

## Problem

Given a recurring event that has its date of occurrence and two other values,
week and daysOfWeek, to determine when it recurs. Find all recurring dates
between a given start and end date.

Event is modeled as:

```haskell
data Event = Event {
  date :: Day,
  daysOfWeek :: [Int],
  week :: Int
}
```

`Day` is from the `Data.Time` package. `daysOfWeek` is an array of the days of
the week that the event recurs. 0 is Sunday and 6 is Saturday. `week` is a
single integer that describes which week of the month the event recurs. 0 is
every week, 1 is the first week, 2 is the second week, -1 is the last week, -2
is the second to last week, and so on until 5 and -5.

## Given

The event and the start and end dates.

```haskell
now <- utctDay <$> getCurrentTime

let eventDay = addDays (-27) now
let event = Event { date = eventDay, daysOfWeek = [3,5], week = -1 }

let startDay = addDays (-15) now
let endDay = addDays 15 now
```
