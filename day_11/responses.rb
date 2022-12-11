require_relative './solver'

input = File.read(File.expand_path('./input.txt', __dir__))

puts 'part 1:' # 56595
puts Solver.new(input).monkey_business(rounds: 20)

puts 'part 2:' # ?
puts Solver.new(input).monkey_business(rounds: 20, relief: 1)
