# frozen_string_literal: true
require 'active_support/all'

class Solver
  def initialize(input)
    @input = input
  end

  PACKET_MARKER_SIZE = 4
  MESSAGE_MARKER_SIZE = 14

  def start_of_packet_marker
    @start_of_packet_marker ||= find_marker(PACKET_MARKER_SIZE)
  end

  def start_of_packet_index
    @input.index(start_of_packet_marker) + PACKET_MARKER_SIZE
  end

  def start_of_message_marker
    @start_of_message_marker ||= find_marker(MESSAGE_MARKER_SIZE)
  end

  def start_of_message_index
    @input.index(start_of_message_marker) + MESSAGE_MARKER_SIZE
  end

  private

  def find_marker(marker_size)
    characters = @input.chars
    characters.each.with_index(1).each do |letter, position|
      next if position < marker_size

      from = position - marker_size
      to = from + marker_size
      last_4_chars = characters[from...to].uniq
      return last_4_chars.join if last_4_chars.count == marker_size
    end
  end
end
