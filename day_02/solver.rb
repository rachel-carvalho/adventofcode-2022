# frozen_string_literal: true

class Round
  SHAPES = {
    A: :rock,
    X: :rock,
    B: :paper,
    Y: :paper,
    C: :rock,
    Z: :scissors,
  }

  SHAPE_SCORE = {
    rock: 1,
    paper: 2,
    scissors: 3,
  }
  OUTCOME_SCORE = {
    loss: 0,
    draw: 3,
    win: 6,
  }

  attr_reader :opponent_choice, :player_choice, :outcome, :choice_score, :outcome_score, :total_score
end

class Solver
  attr_reader :input, :rounds

  def initialize(input)
    @input = input
    @rounds = []
  end

  def solution

  end
end
