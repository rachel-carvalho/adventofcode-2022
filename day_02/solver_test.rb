# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'active_support/all'

require_relative './solver'

describe Solver do
  before do
    @input = \
      "A Y\n" \
      "B X\n" \
      "C Z"
  end

  it 'parses the first round' do
    s = Solver.new(@input)

    round1 = s.rounds.first

    assert_equal :rock, round1.opponent_choice
    assert_equal :paper, round1.player_choice
    assert_equal :win, round1.outcome
    assert_equal 2, round1.choice_score
    assert_equal 6, round1.outcome_score
    assert_equal 8, round1.total_score
  end

  it 'parses the second round' do
    s = Solver.new(@input)

    round2 = s.rounds.second

    assert_equal :paper, round2.opponent_choice
    assert_equal :rock, round2.player_choice
    assert_equal :loss, round2.outcome
    assert_equal 1, round2.choice_score
    assert_equal 0, round2.outcome_score
    assert_equal 1, round2.total_score
  end

  it 'parses the third round' do
    s = Solver.new(@input)

    round3 = s.rounds.third

    assert_equal :scissors, round3.opponent_choice
    assert_equal :scissors, round3.player_choice
    assert_equal :draw, round3.outcome
    assert_equal 3, round3.choice_score
    assert_equal 3, round3.outcome_score
    assert_equal 6, round3.total_score
  end

  it 'calculates solution' do
    s = Solver.new(@input)
    assert_equal 15, s.solution
  end
end
