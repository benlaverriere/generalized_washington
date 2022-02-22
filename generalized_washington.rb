#!/usr/bin/env ruby

require 'date'

$target_year = 2022
birthdays = [Date.new($target_year, 1, 1), Date.new($target_year, 12, 31), Date.new($target_year, 3, 1),
             Date.new($target_year, 3, 11)]

def average(dates)
  Date.ordinal($target_year, dates.map(&:yday).sum / dates.size)
end

def min_distance(dates)
  costs = {}
  (1..366).each do |yday|
    comparison_date = Date.ordinal($target_year, yday).to_date
    per_date_costs = dates.map do |target_date|
      diff1 = comparison_date - target_date
      diff2 = target_date - comparison_date
      diff = [diff1.to_i.abs, diff2.to_i.abs].min
      puts [diff, diff.to_i, diff.to_i.abs].join(' / ')
      diff.to_i.abs
    end
    puts [yday, per_date_costs.join(',')].join(': ')
    costs[yday] = per_date_costs.sum
    # puts costs[yday]
  rescue Date::Error
    print "No day #{yday} in year #{$target_year}\n"
  end
  Date.ordinal($target_year, costs.key(costs.values.min))
end

puts average(birthdays).strftime('%B %-e')
puts min_distance(birthdays).strftime('%B %-e')
