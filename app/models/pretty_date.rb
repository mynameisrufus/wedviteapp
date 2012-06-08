# %a - The abbreviated weekday name (``Sun'')
# %A - The  full  weekday  name (``Sunday'')
# %b - The abbreviated month name (``Jan'')
# %B - The  full  month  name (``January'')
# %c - The preferred local date and time representation
# %C - Century (20 in 2009)
# %d - Day of the month (01..31)
# %D - Date (%m/%d/%y)
# %e - Day of the month, blank-padded ( 1..31)
# %F - Equivalent to %Y-%m-%d (the ISO 8601 date format)
# %h - Equivalent to %b
# %H - Hour of the day, 24-hour clock (00..23)
# %I - Hour of the day, 12-hour clock (01..12)
# %j - Day of the year (001..366)
# %k - hour, 24-hour clock, blank-padded ( 0..23)
# %l - hour, 12-hour clock, blank-padded ( 0..12)
# %L - Millisecond of the second (000..999)
# %m - Month of the year (01..12)
# %M - Minute of the hour (00..59)
# %n - Newline (\n)
# %N - Fractional seconds digits, default is 9 digits (nanosecond)
#         %3N  millisecond (3 digits)
#         %6N  microsecond (6 digits)
#         %9N  nanosecond (9 digits)
# %p - Meridian indicator (``AM''  or  ``PM'')
# %P - Meridian indicator (``am''  or  ``pm'')
# %r - time, 12-hour (same as %I:%M:%S %p)
# %R - time, 24-hour (%H:%M)
# %s - Number of seconds since 1970-01-01 00:00:00 UTC.
# %S - Second of the minute (00..60)
# %t - Tab character (\t)
# %T - time, 24-hour (%H:%M:%S)
# %u - Day of the week as a decimal, Monday being 1. (1..7)
# %U - Week  number  of the current year,
#         starting with the first Sunday as the first
#         day of the first week (00..53)
# %v - VMS date (%e-%b-%Y)
# %V - Week number of year according to ISO 8601 (01..53)
# %W - Week  number  of the current year,
#         starting with the first Monday as the first
#         day of the first week (00..53)
# %w - Day of the week (Sunday is 0, 0..6)
# %x - Preferred representation for the date alone, no time
# %X - Preferred representation for the time alone, no date
# %y - Year without a century (00..99)
# %Y - Year with century
# %z - Time zone as  hour offset from UTC (e.g. +0900)
# %Z - Time zone name
# %% - Literal ``%'' character
#
#  t = Time.now                        #=> 2007-11-19 08:37:48 -0600
#  t.strftime("Printed on %m/%d/%Y")   #=> "Printed on 11/19/2007"
#  t.strftime("at %I:%M%p")            #=> "at 08:37AM"

# def flourished_date input
#   "Saturday the Seventh of April Two Thousand and Twelve"
# end

# def flourished_time input
#   "twelve fourty five in the afternoon"
# end

class PrettyDate
  module Helpers
    def ordinalize number
      if (11..13).include?(number.to_i % 100)
        "#{number}th"
      else
        case number.to_i % 10
          when 1; "#{number}st"
          when 2; "#{number}nd"
          when 3; "#{number}rd"
          else    "#{number}th"
        end
      end
    end
  end

  extend Helpers

  class MissingStyleError < StandardError; end

  class DuplicateStyleError < StandardError; end

  @@styles = {}

  def self.register_style n, p
    raise DuplicateStyleError unless @@styles[n].nil?
    @@styles[n] = p
  end

  def initialize datetime
    @datetime = datetime
  end

  def self.style datetime
    new datetime
  end

  def with index
    raise MissingStyleError unless (style = @@styles[index])
    style.call(@datetime)
  end

  def self.call datetime, index
    @@styles[index].call(datetime)
  end

  # 12:45pm
  register_style 1, proc { |datetime|
    meridian = datetime.strftime('%p').downcase
    hour     = datetime.strftime('%I').to_i
    minute   = datetime.strftime '%M'

    minute.to_i > 0 ? "#{hour}:#{minute}#{meridian}" : "#{hour}#{meridian}"
  }

  # 27.01.2012
  register_style 2, proc { |datetime, sep = '.'|
    datetime.strftime "%m#{sep}%d#{sep}%Y"
  }

  # 27.01.2012 10:45pm
  register_style 3, proc { |datetime, sep = '.'|
    datetime.strftime "%m#{sep}%d#{sep}%Y #{call(datetime, 1)}"
  }

  # 27.01.2012
  register_style 4, proc { |datetime, sep = '.'|
    datetime.strftime "%d#{sep}%m#{sep}%Y"
  }

  # 27.01.2012 10:45pm
  register_style 5, proc { |datetime, sep = '.'|
    datetime.strftime "%d#{sep}%m#{sep}%Y #{call(datetime, 1)}"
  }

  # 27.01.2012 10:45pm
  register_style 6, proc { |datetime, sep = '.'|
    hour   = datetime.strftime('%I').to_i
    minute = datetime.strftime('%M').to_i
    if minute != 0
      call(datetime, 1)
    else
      parts = [hour, "o'clock"]
      parts << "in the morning" if hour < 12
      parts.join ' '
    end
  }

  # Friday 6th January 2012
  register_style 7, proc { |datetime|
    day_name = datetime.strftime '%A'
    day      = ordinalize datetime.day
    month    = datetime.strftime '%B'
    year     = datetime.year
    "#{day_name} #{day} #{month} #{year}"
  }

  # 4:15pm, Friday 6th January 2012
  register_style 8, proc { |datetime|
    "#{call(datetime, 1)}, #{call(datetime, 7)}"
  }
end
