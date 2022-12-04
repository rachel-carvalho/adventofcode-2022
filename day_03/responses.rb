require_relative './solver'

input = File.read(File.expand_path('./input.txt', __dir__))

puts 'part 1:' # 8349
puts Solver.new(input).repeated_item_priority_sum

puts 'part 2:' # 2681
puts Solver.new(input).badge_priority_sum
