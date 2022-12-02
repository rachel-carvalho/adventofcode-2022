require_relative './solver'

puts 'part 1:' # 8890
puts Solver.new(File.read(File.expand_path('./input.txt', __dir__))).score_from_choices

puts 'part 2:' # 10238
puts Solver.new(File.read(File.expand_path('./input.txt', __dir__))).score_from_outcomes
