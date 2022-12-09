require_relative './solver'

input = File.read(File.expand_path('./input.txt', __dir__))

puts 'part 1:' # 6030
puts Solver.new(input).unique_tail_position_count

puts 'part 2:' # 2545
puts Solver.new(input).long_rope_unique_tail_position_count
