require_relative './solver'

input = File.read(File.expand_path('./input.txt', __dir__))

puts 'part 1:' # 1825
puts Solver.new(input).visible_tree_count

puts 'part 2:' # 235200
puts Solver.new(input).highest_scenic_score

