#!/usr/bin/env ruby

# frozen_string_literal: true

def calculate_result(scores)
  frames = divide_into_frames(scores)
  bonus_points = calculate_bonus_points(frames)
  (0..9).sum { |i| calculate_point(frames[i], bonus_points[i]) }
end

def divide_into_frames(scores)
  frames = []
  9.times do
    frames << (scores[0] == 10 ? [scores.shift, 0] : [scores.shift, scores.shift])
  end
  frames << scores
end

def calculate_bonus_points(frames)
  bonus_points = []
  8.times do |i|
    next_point = frames[i + 1][0]
    bonus_points << [next_point, (next_point == 10 ? frames[i + 2][0] : frames[i + 1][1])]
  end
  bonus_points << [frames[9][0], frames[9][1]]
end

def calculate_point(frame_point, bonus_point = nil)
  return frame_point.sum if bonus_point.nil?

  point = frame_point.sum
  point += bonus_point[0] if frame_point.sum == 10
  point += bonus_point[1] if frame_point[0] == 10
  point
end

scores = ARGV[0].split(',').map { |s| s == 'X' ? 10 : s.to_i }
result = calculate_result(scores)

puts result
