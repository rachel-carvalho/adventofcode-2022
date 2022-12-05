require_relative './solver'

input = File.read(File.expand_path('./input.txt', __dir__))

puts 'part 1:' # VWLCWGSDQ
puts Solver.new(input).tap(&:move_crates_one_at_a_time!).top_crates

puts 'part 2:' # ?
puts Solver.new(input).tap(&:move_crates_many_at_a_time!).top_crates
