#!/usr/bin/env ruby

# frozen_string_literal: true

class Bowling
  attr_reader :scores, :shots, :next_points, :result

  def initialize(score)
    @scores = score.split(',').map { |s| char_to_point(s) }
    tmp = []
    @scores.each { |n| tmp << n }
    @shots = devide_to_shots(tmp)
    @next_points = cal_next_points
    @result = cal_result
  end

  def display
    p @scores
    p @shots
    p @next_points
    p @result
  end

  def cal_result
    result = 0
    9.times { |i| result += cal_point(game: i + 1, points: [shots[i], next_points[i]]) }
    result += cal_point(game: 10, points: shots[9])
    result
  end

  private

  def char_to_point(char)
    if char == 'X'
      10
    else
      char.to_i
    end
  end

  def devide_to_shots(scores)
    shots = []
    9.times do
      if scores[0] == 10
        shots << [10, 0]
        scores.delete_at(0)
      else
        shots << [scores[0], scores[1]]
        2.times { scores.delete_at(0) }
      end
    end
    shots << scores
  end

  def cal_next_points
    next_points = []
    8.times do |i|
      tmp1 = [shots[i + 1][0]]
      tmp2 = tmp1[0] == 10 ? shots[i + 2][0] : shots[i + 1][1]
      tmp1 << tmp2
      # 上2行について、tmp1 << tmp1[0] == 10 ? shots[i + 2][0] : shots[i + 1][1]とすると
      # tmp1 << tmp1[0]と同じ結果になってしまいます。なぜでしょうか？
      next_points << tmp1
    end
    next_points << [shots[9][0], shots[9][1]]
  end

  def cal_point(game: 1, points: nil)
    return points.sum if game == 10

    point = points[0].sum
    point += points[1][0] if points[0].sum == 10
    point += points[1][1] if points[0][0] == 10
    point
  end
end

bowling = Bowling.new(ARGV[0])
puts bowling.result
