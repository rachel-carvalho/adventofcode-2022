# frozen_string_literal: true
require 'active_support/all'

class Solver
  def initialize(input)
    @input = input
  end

  MARKER_SIZE = 4

  def start_of_packet_marker
    return @start_of_packet_marker unless @start_of_packet_marker.nil?

    characters = @input.chars
    characters.each.with_index(1).each do |letter, position|
      next if position < MARKER_SIZE

      from = position - MARKER_SIZE
      to = from + MARKER_SIZE
      last_4_chars = characters[from...to].uniq
      return @start_of_packet_marker = last_4_chars.join if last_4_chars.count == MARKER_SIZE
    end
  end

  def start_of_packet_index
    @input.index(start_of_packet_marker) + MARKER_SIZE
  end
end
