#!/usr/bin/env ruby

# frozen_string_literal: true

COLUMNS = 3
COLUMN_WIDTH = 30

def display_files(file_array)
  file_array.each_slice(COLUMNS) do |files|
    puts files.map { |file| file + ' ' * calc_margin_length(file) }.join
  end
end

def calc_margin_length(file_name)
  COLUMN_WIDTH - file_name.gsub(/[^ -~｡-ﾟ\s]/, 'aa').length
end

all_files = Dir.entries('.')
normal_files = all_files.reject { |file| file[0] == '.' }

display_files(normal_files)
