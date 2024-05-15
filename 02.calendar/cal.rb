#!/usr/bin/env ruby

# frozen_string_literal: true

require 'date'
require 'optparse'

year = Date.today.year
month = Date.today.month

opt = OptionParser.new
opt.on('-y VAL') { |v| year = v.to_i }
opt.on('-m VAL') { |v| month = v.to_i }
opt.parse!(ARGV)

selected_date = Date.new(year, month, 1)
dates = [Array.new(7, 0)]
date_index = selected_date.cwday % 7
dates[0][date_index] = 1
date_index += 1

(2..selected_date.next_month.prev_day.day).each do |date|
  if date_index == 7
    dates << Array.new(7, 0)
    date_index = 0
  end

  dates[-1][date_index] = date
  date_index += 1
end

puts "     #{month.to_s.rjust(2)}月 #{year}"
puts '日 月 火 水 木 金 土'

dates.each do |week|
  week.each do |date|
    date = '' if date.zero?
    print "#{date.to_s.rjust(2)} "
  end
  puts
end
