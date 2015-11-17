import Data.Time
import Data.Time.Calendar.OrdinalDate (sundayStartWeek)
import Control.Applicative

data Event = Event {
  date :: Day,
  daysOfWeek :: [Int],
  week :: Int
}

-- return the day of the week
dayOfWeek :: Day -> Int
dayOfWeek = snd . sundayStartWeek

-- return the month of the day
toMonth :: Day -> Int
toMonth = middle . toGregorian
  where middle (_, x, _) = x

-- for example: 1 = first day occurance in month (first Wednesday)
-- 2 = second occurance (second Wednesday)
weekDayOfMonth :: Day -> Int
weekDayOfMonth day
  | toMonth lastWeek /= month = 1
  | otherwise = (1+) $ weekDayOfMonth lastWeek 
  where 
    month = toMonth day
    lastWeek = addDays (-7) day

-- for example: -1 = last day occurance in month (last Wednesday)
-- -2 = second to last occurance (second to last Wednesday)
weekDayOfMonth' :: Day -> Int
weekDayOfMonth' day
  | toMonth nextWeek /= month = -1
  | otherwise = (-1+) $ weekDayOfMonth' nextWeek 
  where 
    month = toMonth day
    nextWeek = addDays 7 day

-- return Days that fall within the recurring week  
filterWeekFromDays :: Int -> [Day] -> [Day]
filterWeekFromDays week days
  | week == 0 = days
  | week > 0 = filter (validateWeek . weekDayOfMonth) days
  | week < 0 = filter (validateWeek . weekDayOfMonth') days
  where validateWeek = (==week)
