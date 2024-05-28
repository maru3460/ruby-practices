#!/usr/bin/env ruby

# frozen_string_literal: true

require 'optparse'

COLUMNS = 3
COLUMN_WIDTH = 30

def display_files(files)
  files = sort_for_display(files)
  files.each do |file_set|
    puts file_set.map { |file| file.to_s + ' ' * calc_margin_length(file) }.join
  end
end

def calc_margin_length(file_name)
  return 0 if file_name.nil?

  COLUMN_WIDTH - (file_name.length + file_name.scan(/[^ -~｡-ﾟ\s]/).length)
end

def sort_for_display(files)
  rows = files.length / COLUMNS
  rows += 1 unless (files.length % COLUMNS).zero?
  sorted_files = Array.new(rows) { [] }
  files = files.sort

  COLUMNS.times do
    rows.times do |row|
      sorted_files[row] << files.shift
    end
  end

  sorted_files
end

opt = OptionParser.new

all = false
opt.on('-a') { all = true }
opt.parse!(ARGV)

files = all ? Dir.entries('.') : Dir.glob('*')
display_files(files)
