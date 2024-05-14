#!/usr/bin/env ruby

# frozen_string_literal: true

def cal_result(scores)
  shots = devide_to_shots(scores)
  next_points = cal_next_points(shots)
  result = 0
  9.times { |i| result += cal_point(i + 1, [shots[i], next_points[i]]) }
  result += cal_point(10, shots[9])
  result
end

def devide_to_shots(scores)
  shots = []
  9.times do
    if scores[0] == 10
      shots << [10, 0]
      scores.shift
    else
      shots << [scores[0], scores[1]]
      scores.shift(2)
    end
  end
  shots << scores
end

def cal_next_points(shots)
  next_points = []
  8.times do |i|
    next_point = [shots[i + 1][0]]
    next_point << (next_point[0] == 10 ? shots[i + 2][0] : shots[i + 1][1])
    next_points << next_point
  end
  next_points << [shots[9][0], shots[9][1]]
end

def cal_point(game, points)
  return points.sum if game == 10

  point = points[0].sum
  point += points[1][0] if points[0].sum == 10
  point += points[1][1] if points[0][0] == 10
  point
end

scores = ARGV[0].split(',').map { |s| s == 'X' ? 10 : s.to_i }
result = cal_result(scores)

puts result
