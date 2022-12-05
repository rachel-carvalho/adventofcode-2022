require_relative './solver'

input = File.read(File.expand_path('./input.txt', __dir__))

puts 'part 1:' # ?
puts Solver.new(input).move_and_find_top_crates

puts 'part 2:' # ?
# puts Solver.new(input).move_and_find_top_crates
