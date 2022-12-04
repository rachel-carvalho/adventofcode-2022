# frozen_string_literal: true

require_relative '../test_helper'
require_relative './solver'

describe Solver do
  before do
    @input = \
      "2-4,6-8\n" \
      "2-3,4-5\n" \
      "5-7,7-9\n" \
      "2-8,3-7\n" \
      "6-6,4-6\n" \
      "2-6,4-8"
  end

  describe 'part 1 - sections that fully contain the other' do
    it 'parses 6 pairs' do
      s = Solver.new(@input)
      assert_equal 6, s.pairs.count
    end

    it 'expands each pair section range' do
      s = Solver.new(@input)
      pair = s.pairs.first
      assert_equal 2..4, pair.first_section_range
      assert_equal 6..8, pair.second_section_range
    end

    it 'detects full overlaps of sections' do
      s = Solver.new(@input)
      assert_equal false, s.pairs.first.fully_overlap?
      assert_equal false, s.pairs.second.fully_overlap?
      assert_equal false, s.pairs.third.fully_overlap?
      assert_equal true, s.pairs.fourth.fully_overlap?
      assert_equal true, s.pairs.fifth.fully_overlap?
      assert_equal false, s.pairs[5].fully_overlap?
    end

    it 'counts pairs that overlap completely' do
      s = Solver.new(@input)
      assert_equal 2, s.fully_overlapping_pair_count
    end
  end

  describe 'part 2 - sections that have any overlap' do
    it 'detects any overlaps of sections' do
      s = Solver.new(@input)
      assert_equal false, s.pairs.first.overlap?
      assert_equal false, s.pairs.second.overlap?
      assert_equal true, s.pairs.third.overlap?
      assert_equal true, s.pairs.fourth.overlap?
      assert_equal true, s.pairs.fifth.overlap?
      assert_equal true, s.pairs[5].overlap?
    end

    it 'counts pairs that overlap in any way' do
      s = Solver.new(@input)
      assert_equal 4, s.overlapping_pair_count
    end
  end
end
