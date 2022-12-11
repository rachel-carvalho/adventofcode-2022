# frozen_string_literal: true

require_relative '../test_helper'
require_relative './solver'
require 'benchmark/ips'

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

  # describe 'part 1 - calculate monkey business level' do
  #   describe 'monkeys' do
  #     it 'parses 4 monkeys' do
  #       s = Solver.new(@input)
  #       assert_equal 4, s.monkeys.count
  #       assert_equal 4, Monkey.all.count
  #     end
  #
  #     it 'parses first monkey' do
  #       s = Solver.new(@input)
  #       monkey = s.monkeys.first
  #       assert_equal [79, 98], monkey.items
  #       assert_equal ['*', 19], monkey.operation
  #       assert_equal 23, monkey.divisible_by
  #       assert_equal [2, 3], monkey.destination_monkeys
  #     end
  #
  #     it 'parses third monkey' do
  #       s = Solver.new(@input)
  #       monkey = s.monkeys.third
  #       assert_equal [79, 60, 97], monkey.items
  #       assert_equal ['*'], monkey.operation
  #       assert_equal 13, monkey.divisible_by
  #       assert_equal [1, 3], monkey.destination_monkeys
  #     end
  #
  #     it 'first monkey throws' do
  #       s = Solver.new(@input)
  #       monkey0 = s.monkeys[0]
  #       monkey3 = s.monkeys[3]
  #       monkey0.throw!
  #       assert_equal [], monkey0.items
  #       assert_equal [74, 500, 620], monkey3.items
  #       assert_equal 2, monkey0.inspected_item_count
  #     end
  #   end
  #
  #   it 'plays 1 round' do
  #     s = Solver.new(@input)
  #     s.play!
  #     assert_equal [20, 23, 27, 26], s.monkeys.first.items
  #     assert_equal [2080, 25, 167, 207, 401, 1046], s.monkeys.second.items
  #     assert_equal [], s.monkeys.third.items
  #     assert_equal [], s.monkeys.fourth.items
  #   end
  #
  #   it 'plays 3 rounds' do
  #     s = Solver.new(@input)
  #     s.play!(rounds: 3)
  #     assert_equal [16, 18, 21, 20, 122], s.monkeys.first.items
  #     assert_equal [1468, 22, 150, 286, 739], s.monkeys.second.items
  #     assert_equal [], s.monkeys.third.items
  #     assert_equal [], s.monkeys.fourth.items
  #   end
  #
  #   it 'plays 20 rounds' do
  #     s = Solver.new(@input)
  #     s.play!(rounds: 20)
  #     assert_equal [10, 12, 14, 26, 34], s.monkeys.first.items
  #     assert_equal 101, s.monkeys.first.inspected_item_count
  #     assert_equal [245, 93, 53, 199, 115], s.monkeys.second.items
  #     assert_equal 95, s.monkeys.second.inspected_item_count
  #     assert_equal [], s.monkeys.third.items
  #     assert_equal 7, s.monkeys.third.inspected_item_count
  #     assert_equal [], s.monkeys.fourth.items
  #     assert_equal 105, s.monkeys.fourth.inspected_item_count
  #   end
  #
  #   it 'calculates monkey business after 20 rounds' do
  #     s = Solver.new(@input)
  #     assert_equal 10605, s.monkey_business(rounds: 20)
  #   end
  # end

  describe 'part 2 - no relief, 10 000 rounds' do
    # it 'plays 1 round with no relief' do
    #   s = Solver.new(@input)
    #   s.play!(relief: 1)
    #   assert_equal [2, 4, 3, 6], s.monkeys.map(&:inspected_item_count)
    # end
    #
    # it 'plays 20 rounds with no relief' do
    #   s = Solver.new(@input)
    #   s.play!(rounds: 20, relief: 1)
    #   assert_equal [99, 97, 8, 103], s.monkeys.map(&:inspected_item_count)
    # end

    # it 'plays 755 rounds with no relief' do
    #   s = Solver.new(@input)
    #   m = Benchmark.measure { s.play!(rounds: 755, relief: 1) }
    #   assert_operator m.real, '<', 4
    # end

    it 'divides' do
      _, n, d = File.read('day_11/large_num').split("\t")
      # 256678 digits
      number = n.to_i
      div = d.to_i

      modulo = -> {(number % div).zero?}
      other = -> {
        # TODO: long division with strings
        false
      }

      assert_equal modulo.call, other.call

      Benchmark.ips do |benchmark|
        benchmark.report("modulo") { modulo.call }
        benchmark.report("other") { other.call }

        benchmark.compare!
      end
    end

    # it 'plays 10 000 rounds with no relief' do
    #   s = Solver.new(@input)
    #   s.play!(rounds: 10_000, relief: 1)
    #   assert_equal [52166, 47830, 1938, 52013], s.monkeys.map(&:inspected_item_count)
    # end
    #
    # it 'calculates monkey business after 10 000 rounds with no relief' do
    #   s = Solver.new(@input)
    #   assert_equal 2_713_310_158, s.monkey_business(rounds: 20, relief: 1)
    # end
  end
end
