#!/usr/bin/env ruby

# frozen_string_literal: true

COLUMNS = 3
COLUMN_WIDTH = 30

def display_files(files)
  files = sort_for_display(files)
  files.each do |file_set|
    puts file_set.map { |file| file + ' ' * calc_margin_length(file) }.join
  end
end

def calc_margin_length(file_name)
  COLUMN_WIDTH - (file_name.length + file_name.scan(/[^ -~｡-ﾟ\s]/).length)
end

def sort_for_display(files)
  rows = (files.length % 3).zero? ? files.length / 3 : files.length / 3 + 1
  sorted_files = Array.new(rows) { [] }
  files = files.sort

  2.times do
    rows.times do |row|
      sorted_files[row] << files.shift
    end
  end
  files.each_with_index do |file, index|
    sorted_files[index] << file
  end

  sorted_files
end

display_files(Dir.glob('*'))
