# frozen_string_literal: true
require 'active_support/all'

class Round
  SHAPES = {
    A: :rock,
    X: :rock,
    B: :paper,
    Y: :paper,
    C: :scissors,
    Z: :scissors,
  }.stringify_keys

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

  OUTCOMES = {
    -1 => :loss,
    0 => :draw,
    1 => :win,
  }

  attr_reader :opponent_choice, :player_choice

  def self.parse_input(input)
    input.split("\n").map { |line| parse(line) }
  end

  def self.parse(line)
    opponent, player = line.split(' ')
    new(SHAPES[opponent], SHAPES[player])
  end

  def initialize(opponent_choice, player_choice)
    @opponent_choice = opponent_choice
    @player_choice = player_choice
  end

  def outcome
    return @outcome unless @outcome.nil?

    opponent_score = SHAPE_SCORE[opponent_choice]
    player_score = choice_score

    if opponent_choice == :scissors && player_choice == :rock
      player_score += 3
    elsif player_choice == :scissors && opponent_choice == :rock
      opponent_score += 3
    end

    @outcome = OUTCOMES[player_score - opponent_score]
  end

  def choice_score
    SHAPE_SCORE[player_choice]
  end

  def outcome_score
    OUTCOME_SCORE[outcome]
  end

  def total_score
    choice_score + outcome_score
  end
end

class Solver
  def initialize(input)
    @input = input
  end

  def rounds_from_choices
    @rounds_from_choices ||= Round.parse_input(@input)
  end

  def score_from_choices
    rounds_from_choices.map(&:total_score).sum
  end

  def rounds_from_outcomes
    @rounds_from_outcomes ||= Round.parse_input(@input)
  end

  def score_from_outcomes
    rounds_from_outcomes.map(&:total_score).sum
  end
end
