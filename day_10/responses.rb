require_relative './solver'

input = File.read(File.expand_path('./input.txt', __dir__))

puts 'part 1:' # 14060
puts Solver.new(input).signal_strengths.sum

puts 'part 2:' # ?
# puts Solver.new(input).signal_strengths
