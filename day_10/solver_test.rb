# frozen_string_literal: true

require_relative '../test_helper'
require_relative './solver'

describe Solver do
  before do
    @input = '''
noop
addx 3
addx -5
'''.strip
    @input2 = '''
addx 15
addx -11
addx 6
addx -3
addx 5
addx -1
addx -8
addx 13
addx 4
noop
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx -35
addx 1
addx 24
addx -19
addx 1
addx 16
addx -11
noop
noop
addx 21
addx -15
noop
noop
addx -3
addx 9
addx 1
addx -3
addx 8
addx 1
addx 5
noop
noop
noop
noop
noop
addx -36
noop
addx 1
addx 7
noop
noop
noop
addx 2
addx 6
noop
noop
noop
noop
noop
addx 1
noop
noop
addx 7
addx 1
noop
addx -13
addx 13
addx 7
noop
addx 1
addx -33
noop
noop
noop
addx 2
noop
noop
noop
addx 8
noop
addx -1
addx 2
addx 1
noop
addx 17
addx -9
addx 1
addx 1
addx -3
addx 11
noop
noop
addx 1
noop
addx 1
noop
noop
addx -13
addx -19
addx 1
addx 3
addx 26
addx -30
addx 12
addx -1
addx 3
addx 1
noop
noop
noop
addx -9
addx 18
addx 1
addx 2
noop
noop
addx 9
noop
noop
noop
addx -1
addx 2
addx -37
addx 1
addx 3
noop
addx 15
addx -21
addx 22
addx -6
addx 1
noop
addx 2
addx 1
noop
addx -10
noop
noop
addx 20
addx 1
addx 2
addx 2
addx -6
addx -11
noop
noop
noop
'''.strip
  end

  describe 'part 1 - find signal strengths at every 40th cycle from 20' do
    describe 'instructions' do
      it 'parses first instruction' do
        s = Solver.new(@input)
        assert_equal :noop, s.instructions.first.type
        assert_equal 1, s.instructions.first.cycles
        assert_nil s.instructions.first.argument
      end

      it 'parses second instruction' do
        s = Solver.new(@input)
        assert_equal :addx, s.instructions.second.type
        assert_equal 2, s.instructions.second.cycles
        assert_equal 3, s.instructions.second.argument
      end
    end

    describe 'cpu' do
      it 'initializes register with 1, cycle with 0' do
        s = Solver.new(@input)
        assert_equal 1, s.cpu.register
        assert_equal 1, s.cpu.cycle
      end

      it 'executes first instruction' do
        s = Solver.new(@input)
        s.cpu.execute(s.instructions.first)
        assert_equal 1, s.cpu.register
        assert_equal 2, s.cpu.cycle
      end

      it 'executes second instruction' do
        s = Solver.new(@input)
        s.cpu.execute(*s.instructions[0..1])
        assert_equal 4, s.cpu.register
        assert_equal 4, s.cpu.cycle
      end

      it 'executes third instruction' do
        s = Solver.new(@input)
        s.cpu.execute(*s.instructions)
        assert_equal -1, s.cpu.register
        assert_equal 6, s.cpu.cycle
      end

      it 'finds register value at specific cycle' do
        s = Solver.new(@input)
        s.cpu.execute(*s.instructions)
        assert_equal 4, s.cpu.register_value_at_cycle(5)
      end
    end

    it 'finds signal strengths for every 40 cycles' do
      s = Solver.new(@input2)
      assert_equal [420, 1140, 1800, 2940, 2880, 3960], s.signal_strengths
    end
  end

  describe 'part 2 - ?' do
  end
end
