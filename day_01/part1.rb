# https://adventofcode.com/2022/day/1

input_file = "input.txt"
input = File.read(input_file)
elves = input.split("\n\n")
max_calories = elves.map do |elf|
  elf.split("\n").map(&:to_i).sum
end.max
puts max_calories

