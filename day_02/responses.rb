require_relative './solver'


puts 'part 1:' # 8890
puts Solver.new(File.read(File.expand_path('./input.txt', __dir__))).solution
