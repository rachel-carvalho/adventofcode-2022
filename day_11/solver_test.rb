# frozen_string_literal: true

require_relative '../test_helper'
require_relative './solver'

describe Solver do
  before do
    @input = '''
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1
'''.strip
  end

  describe 'part 1 - calculate monkey business level' do
    describe 'monkeys' do
      it 'parses 4 monkeys' do
        s = Solver.new(@input)
        assert_equal 4, s.monkeys.count
        assert_equal 4, Monkey.all_monkeys.count
      end

      it 'parses first monkey' do
        s = Solver.new(@input)
        monkey = s.monkeys.first
        assert_equal [79, 98], monkey.items
        assert_equal ['*', 19], monkey.operation
        assert_equal 23, monkey.divisible_by
        assert_equal [2, 3], monkey.destination_monkeys
      end

      it 'parses third monkey' do
        s = Solver.new(@input)
        monkey = s.monkeys.third
        assert_equal [79, 60, 97], monkey.items
        assert_equal ['*'], monkey.operation
        assert_equal 13, monkey.divisible_by
        assert_equal [1, 3], monkey.destination_monkeys
      end
    end

    # it 'calculates monkey business after 20 rounds' do
    #   s = Solver.new(@input)
    #   assert_equal 10605, s.monkey_business(rounds: 20)
    # end
  end

  describe 'part 2 - ?' do
  end
end
