require_relative './solver'

input = File.read(File.expand_path('./input.txt', __dir__))

puts 'part 1:' # 1477771
puts Solver.new(input).small_directories.sum(&:size)

puts 'part 2:' # 3579501
puts Solver.new(input).directory_to_delete.size
