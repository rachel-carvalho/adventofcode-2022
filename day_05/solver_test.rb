# frozen_string_literal: true

require_relative '../test_helper'
require_relative './solver'

describe Solver do
  before do
    @input = \
      "    [D]    \n" \
      "[N] [C]    \n" \
      "[Z] [M] [P]\n" \
      " 1   2   3 \n" \
      "\n" \
      "move 1 from 2 to 1\n" \
      "move 3 from 1 to 3\n" \
      "move 2 from 2 to 1\n" \
      "move 1 from 1 to 2"
  end

  describe 'part 1 - moving one crate at a time' do
    it 'parses 3 stacks' do
      s = Solver.new(@input)
      assert_equal 3, s.stacks.count
    end

    it 'parses stack contents' do
      s = Solver.new(@input)
      assert_equal ['Z', 'N'], s.stacks.first
      assert_equal ['M', 'C', 'D'], s.stacks.second
      assert_equal ['P'], s.stacks.third
    end

    it 'parses 7 single crate movements' do
      s = Solver.new(@input)
      assert_equal 7, s.single_crate_movements.count
      assert_equal [1, 0], s.single_crate_movements.first
      assert_equal [0, 2], s.single_crate_movements.second
      assert_equal [0, 2], s.single_crate_movements.third
      assert_equal [0, 2], s.single_crate_movements.fourth
      assert_equal [1, 0], s.single_crate_movements.fifth
      assert_equal [1, 0], s.single_crate_movements[5]
      assert_equal [0, 1], s.single_crate_movements[6]
    end

    it 'executes movements' do
      s = Solver.new(@input)
      s.move_crates_one_at_a_time!
      assert_equal ['C'], s.stacks.first
      assert_equal ['M'], s.stacks.second
      assert_equal ['P', 'D', 'N', 'Z'], s.stacks.third
    end

    it 'finds top crate for each stack' do
      s = Solver.new(@input)
      s.move_crates_one_at_a_time!
      assert_equal 'CMZ', s.top_crates
    end
  end

  describe 'part 2 - move multiple crates at once' do
    it 'parses 4 multi crate movements' do
      s = Solver.new(@input)
      assert_equal 4, s.multi_crate_movements.count
      assert_equal [1, 1, 0], s.multi_crate_movements.first
      assert_equal [3, 0, 2], s.multi_crate_movements.second
      assert_equal [2, 1, 0], s.multi_crate_movements.third
      assert_equal [1, 0, 1], s.multi_crate_movements.fourth
    end

    it 'executes movements' do
      s = Solver.new(@input)
      s.move_crates_many_at_a_time!
      assert_equal ['M'], s.stacks.first
      assert_equal ['C'], s.stacks.second
      assert_equal ['P', 'Z', 'N', 'D'], s.stacks.third
    end

    it 'finds top crate for each stack' do
      s = Solver.new(@input)
      s.move_crates_many_at_a_time!
      assert_equal 'MCD', s.top_crates
    end
  end
end
