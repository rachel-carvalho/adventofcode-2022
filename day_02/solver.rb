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
    X: :loss,
    Y: :draw,
    Z: :win,
  }.stringify_keys

  OUTCOMES_FROM_CHOICES = {
    -1 => :loss,
    0 => :draw,
    1 => :win,
  }

  attr_reader :opponent_choice, :player_choice

  def self.parse_input(input, from_choice: true)
    input.split("\n").map do |line|
      if from_choice
        parse_from_choice(line)
      else
        parse_from_outcome(line)
      end
    end
  end

  def self.parse_from_choice(line)
    opponent, player = line.split(' ')
    new(SHAPES[opponent], SHAPES[player], nil)
  end

  def self.parse_from_outcome(line)
    opponent, outcome = line.split(' ')
    new(SHAPES[opponent], nil, OUTCOMES[outcome])
  end

  def initialize(opponent_choice, player_choice, outcome)
    @opponent_choice = opponent_choice
    @player_choice = player_choice
    @outcome = outcome
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

    @outcome = OUTCOMES_FROM_CHOICES[player_score - opponent_score]
  end

  def player_choice
    return @player_choice unless @player_choice.nil?

    outcomes = OUTCOME_SCORE.keys
    choice_offset = outcomes.index(outcome) - outcomes.index(:draw)

    shapes = SHAPE_SCORE.keys
    @player_choice = shapes[(shapes.index(opponent_choice) + choice_offset) % shapes.length]
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
    @rounds_from_choices ||= Round.parse_input(@input, from_choice: true)
  end

  def score_from_choices
    rounds_from_choices.map(&:total_score).sum
  end

  def rounds_from_outcomes
    @rounds_from_outcomes ||= Round.parse_input(@input, from_choice: false)
  end

  def score_from_outcomes
    rounds_from_outcomes.map(&:total_score).sum
  end
end
