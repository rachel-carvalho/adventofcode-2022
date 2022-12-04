require_relative './solver'

input = File.read(File.expand_path('./input.txt', __dir__))

puts 'part 1:' # 540
puts Solver.new(input).fully_overlapping_pair_count

puts 'part 2:' # ?
# puts Solver.new(input).fully_overlapping_pair_count
