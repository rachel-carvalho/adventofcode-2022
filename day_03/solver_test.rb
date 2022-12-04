# frozen_string_literal: true

require_relative '../test_helper'
require_relative './solver'

describe Solver do
  before do
    @input = \
      "vJrwpWtwJgWrhcsFMMfFFhFp\n" \
      "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL\n" \
      "PmmdzqPrVvPwwTWBwg\n" \
      "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn\n" \
      "ttgJtRGJQctTZtZT\n" \
      "CrZsJsPPZsGzwwsLwLmpwMDw"
  end

  describe 'part 1 - sum of priorities of repeated items' do
    it 'parses 6 rucksacks' do
      s = Solver.new(@input)
      assert_equal 6, s.rucksacks.count
    end

    describe 'first rucksack' do
      it 'splits compartment items' do
        s = Solver.new(@input)
        rucksack = s.rucksacks.first
        assert_equal 'vJrwpWtwJgWrhcsFMMfFFhFp'.split(''), rucksack.all_items
        assert_equal 'vJrwpWtwJgWr'.split(''), rucksack.first_compartment
        assert_equal 'hcsFMMfFFhFp'.split(''), rucksack.second_compartment
      end

      it 'finds repeated item in both compartments' do
        s = Solver.new(@input)
        rucksack = s.rucksacks.first
        assert_equal 'p', rucksack.repeated_item
        assert_equal 16, rucksack.repeated_item_priority
      end
    end

    describe 'second rucksack' do
      it 'splits compartment items' do
        s = Solver.new(@input)
        rucksack = s.rucksacks.second
        assert_equal 'jqHRNqRjqzjGDLGL'.split(''), rucksack.first_compartment
        assert_equal 'rsFMfFZSrLrFZsSL'.split(''), rucksack.second_compartment
      end

      it 'finds repeated item in both compartments' do
        s = Solver.new(@input)
        rucksack = s.rucksacks.second
        assert_equal 'L', rucksack.repeated_item
        assert_equal 38, rucksack.repeated_item_priority
      end
    end

    describe 'third rucksack' do
      it 'splits compartment items' do
        s = Solver.new(@input)
        rucksack = s.rucksacks.third
        assert_equal 'PmmdzqPrV'.split(''), rucksack.first_compartment
        assert_equal 'vPwwTWBwg'.split(''), rucksack.second_compartment
      end

      it 'finds repeated item in both compartments' do
        s = Solver.new(@input)
        rucksack = s.rucksacks.third
        assert_equal 'P', rucksack.repeated_item
        assert_equal 42, rucksack.repeated_item_priority
      end
    end

    it 'finds repeated item in both compartments in fourth rucksack' do
      s = Solver.new(@input)
      rucksack = s.rucksacks.fourth
      assert_equal 'v', rucksack.repeated_item
      assert_equal 22, rucksack.repeated_item_priority
    end

    it 'finds repeated item in both compartments in fifth rucksack' do
      s = Solver.new(@input)
      rucksack = s.rucksacks.fifth
      assert_equal 't', rucksack.repeated_item
      assert_equal 20, rucksack.repeated_item_priority
    end

    it 'finds repeated item in both compartments in sixth rucksack' do
      s = Solver.new(@input)
      rucksack = s.rucksacks[5]
      assert_equal 's', rucksack.repeated_item
      assert_equal 19, rucksack.repeated_item_priority
    end

    it 'sums all repeated item priorities' do
      assert_equal 157, Solver.new(@input).repeated_item_priority_sum
    end
  end

  describe 'part 2 - sum of priorities of badges per 3 rucksack group' do
    it 'parses 2 groups' do
      s = Solver.new(@input)
      assert_equal 2, s.groups.count
    end

    it 'finds first groups badge' do
      s = Solver.new(@input)
      assert_equal 'r', s.groups.first.badge
    end

    it 'finds second groups badge' do
      s = Solver.new(@input)
      assert_equal 'Z', s.groups.second.badge
    end

    it 'finds group badge priorities' do
      s = Solver.new(@input)
      assert_equal 18, s.groups.first.badge_priority
      assert_equal 52, s.groups.second.badge_priority
    end

    it 'sums all badge priorities' do
      assert_equal 70, Solver.new(@input).badge_priority_sum
    end
  end
end
