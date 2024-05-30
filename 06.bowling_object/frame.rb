# frozen_string_literal: true

require './shot'

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_mark, second_mark, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def strike?
    return nil if @third_shot.invalid?

    @first_shot.mark == 'X'
  end

  def spare?
    return nil if @third_shot.invalid?

    !strike? && @first_shot.score + @second_shot.score == 10
  end

  def score(next_frame = nil, next_next_frame = nil)
    score = @first_shot.score + @second_shot.score + @third_shot.score
    score += next_frame.first_shot.score if spare? || strike?
    score += (next_frame.strike? ? next_next_frame.first_shot.score : next_frame.second_shot.score) if strike?
    score
  end
end
