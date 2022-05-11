#!/usr/bin/env ruby

require 'date'

# 'A date, represented by the zero-indexed ordinal of its position within a 366-day year'
class Day
  attr_reader :day_number

  def initialize(day_number)
    @day_number = day_number
  end

  def -(other)
    return @day_number - other.day_number if other.respond_to? :day_number

    false
  end

  def ==(other)
    return @day_number == other.day_number if other.respond_to? :day_number

    false
  end

  def to_s
    to_date.strftime('%B %-e')
  end

  def to_date
    Date.ordinal(2024, @day_number)
  end
end

birthdays = [Day.new(1), Day.new(366), Day.new(90), Day.new(95)]

def average(dates)
  Day.new(dates.map(&:day_number).sum / dates.size)
end

def min_distance(dates)
  costs = {}
  (1..366).each do |yday|
    comparison_date = Day.new(yday)
    per_date_costs = dates.map do |target_date|
      diff1 = comparison_date - target_date
      diff2 = target_date - comparison_date
      diff = [diff1.to_i.abs, diff2.to_i.abs].min
      # puts [diff, diff.to_i, diff.to_i.abs].join(' / ')
      diff.to_i.abs
    end
    # puts [yday, per_date_costs.join(',')].join(': ')
    costs[yday] = per_date_costs.sum
    # puts costs[yday]
  end
  Day.new(costs.key(costs.values.min))
end

def represent(dates, special_dates = [])
  puts((1..366).map do |date|
    day = Day.new(date)
    next '*' if special_dates.include?(day)
    next '|' if dates.include?(day)

    '.'
  end.join(''))
end

puts "Averaging: #{birthdays.join(', ')}"
average_day = average(birthdays)
min_distance_day = min_distance(birthdays)
puts represent(birthdays, [average_day, min_distance_day])
puts average_day
puts min_distance_day
