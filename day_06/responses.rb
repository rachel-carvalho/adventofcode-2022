require_relative './solver'

input = File.read(File.expand_path('./input.txt', __dir__))

puts 'part 1:' # 1080
puts Solver.new(input).start_of_packet_index

puts 'part 2:' # 3645
puts Solver.new(input).start_of_message_index

