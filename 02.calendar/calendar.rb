#!/usr/bin/env ruby

require 'date'
require 'optparse'

class Calendar
    attr_reader :year, :month, :day_of_week, :days

    def initialize(year: nil, month: nil)
        @day = year.nil? || month.nil? ? Date.today : Date.new(year, month, 1)
        @year = @day.year
        @month = @day.month
        @day_of_week = ['日', '月', '火', '水', '木', '金', '土']
        @days = []

        days << Array.new(7) {|i| i = 0}
        day_index = Date.new(@year, @month, 1).cwday % 7
        days[-1][day_index] = 1
        day_index += 1
        max_day = @day.next_month.prev_day.day

        (2..max_day).each do |day|
            if day_index == 7
                @days << Array.new(7) {|i| i = 0}
                day_index = 0
            end

            @days[-1][day_index] = day
            day_index += 1
        end
    end

    def display_calendar
        puts "     #{month.to_s.rjust(2)}月  #{year}"
        puts day_of_week.join(' ')

        days.each do |week|
            week.each do |day|
                day='' if day == 0
                print day.to_s.rjust(2) + ' '
            end
            puts
        end
    end
end

opt = OptionParser.new

year = Date.today.year
month = Date.today.month

opt.on('-y VAL'){|v| year = v.to_i}
opt.on('-m VAL'){|v| month = v.to_i}
opt.parse!(ARGV)

if year < 1 || month < 1 || month > 12
    puts 'invalid option'
    exit
end

Calendar.new(year: year, month: month).display_calendar


