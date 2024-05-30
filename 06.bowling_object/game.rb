#!/usr/bin/env ruby

# frozen_string_literal: true

require './frame'

class Game
  def initialize(scores)
    scores = scores.split(',')

    @frames = []
    9.times { @frames << (scores[0] == 'X' ? Frame.new(scores.shift, '0') : Frame.new(scores.shift, scores.shift)) }
    @frames << Frame.new(scores.shift, scores.shift, scores.shift)
  end

  def score
    10.times.sum { |i| @frames[i].score(@frames[i + 1], @frames[i + 2]) }
  end
end

puts Game.new(ARGV[0]).score
