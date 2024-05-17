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

first_date = Date.new(year, month, 1)
last_date = Date.new(year, month, -1)
dates = []
(first_date..last_date).each do |date|
  if date.sunday? || date.day == 1
    dates << []
  end
  dates[-1][date.wday] = date.day
end

puts "     #{month.to_s.rjust(2)}月 #{year}"
puts '日 月 火 水 木 金 土'

dates.each do |week|
  week.each do |date|
    print "#{date.to_s.rjust(2)} "
  end
  puts
end
