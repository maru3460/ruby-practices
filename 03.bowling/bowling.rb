#!/usr/bin/env ruby

def cal_point(game: 1, points: nil)
  return 'invalid input' if points.nil? || game < 1 || game > 10

  return points.sum if game == 10

  point = points[0].sum
  point += points[1][0] if points[0].sum == 10
  if points[0][0] == 10
    point += points[1][1]
    point += points[2][0] if points[1][0] == 10 && game != 9
  end
  point
end

score = ARGV[0]
scores = score.split(',')
shots = []
9.times do
  if scores[0] == 'X'
    shots << [10, 0]
    scores.delete_at(0)
  else
    shots << [scores[0].to_i, scores[1].to_i]
    2.times { scores.delete_at(0) }
  end
end
shots << scores.map { |n| n == 'X' ? 10 : n.to_i }

point = 0
8.times { |i| point += cal_point(game: i + 1, points: shots[i..(i + 2)]) }
point += cal_point(game: 9, points: shots[8..9])
point += cal_point(game: 10, points: shots[9])
puts point

