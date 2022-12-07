# frozen_string_literal: true

require_relative '../test_helper'
require_relative './solver'

describe Solver do
  before do
    @inputs = [
      "mjqjpqmgbljsphdztnvjfqwrcgsmlb",
      "bvwbjplbgvbhsrlpgdmjqwftvncz",
      "nppdvjthqldpwncqszvftbrmjlhg",
      "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg",
      "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw",
    ]
  end

  describe 'part 1 - find start of packet marker' do
    it 'finds the marker on first input' do
      s = Solver.new(@inputs.first)
      assert_equal 'jpqm', s.start_of_packet_marker
      assert_equal 7, s.start_of_packet_index
    end

    it 'finds the marker on second input' do
      s = Solver.new(@inputs.second)
      assert_equal 'vwbj', s.start_of_packet_marker
      assert_equal 5, s.start_of_packet_index
    end

    it 'finds the marker on third input' do
      s = Solver.new(@inputs.third)
      assert_equal 'pdvj', s.start_of_packet_marker
      assert_equal 6, s.start_of_packet_index
    end

    it 'finds the marker on fourth input' do
      s = Solver.new(@inputs.fourth)
      assert_equal 'rfnt', s.start_of_packet_marker
      assert_equal 10, s.start_of_packet_index
    end

    it 'finds the marker on fifth input' do
      s = Solver.new(@inputs.fifth)
      assert_equal 'zqfr', s.start_of_packet_marker
      assert_equal 11, s.start_of_packet_index
    end
  end

  describe 'part 2 - ?' do
  end
end
