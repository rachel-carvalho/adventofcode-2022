# frozen_string_literal: true
require 'active_support/all'

class Solver
  def initialize(input)
    @input = input
  end

  def commands
    @commands ||= Command.parse_output(@input.split("\n"))
  end

  def root_dir
    @root_dir ||= Elf::FileSystem.new(commands).tap(&:parse_directories).tree.values.first
  end
end

class Command
  COMMAND_PREFIX = "$ "

  def self.parse_output(lines)
    commands = []
    last_command = nil
    lines.each_with_index do |line, index|
      next unless line.start_with?(COMMAND_PREFIX)

      if last_command
        commands << last_command.merge(output: lines[(last_command[:index] + 1)...index])
      end

      last_command = { command: line[COMMAND_PREFIX.length..], index: index }
    end

    if last_command
      commands << last_command.merge(output: lines[(last_command[:index] + 1)...lines.count])
    end

    commands.map { |cmd| parse(**cmd.except(:index)) }
  end

  def self.parse(command:, output:)
    executable, *arguments = command.split(' ')
    new(executable, arguments, output.presence)
  end

  attr_reader :executable, :arguments, :output

  def initialize(executable, arguments, output)
    @executable = executable
    @arguments = arguments
    @output = output
  end

  def cd?
    executable == 'cd'
  end
end

module Elf
  class FileSystem
    attr_reader :commands, :tree

    def initialize(commands)
      @commands = commands
      @tree = {}
    end

    def parse_directories
      position = []
      commands.each do |command|
        if command.cd?
          dir_name, _ = command.arguments
          if dir_name == '..'
            position.pop
          else
            position << dir_name
          end
          initialize_directory(position)
        else
          dir = tree.dig(*position)
          command.output.each do |line|
            if line.start_with?('dir ')
              initialize_directory(position + [line[4..]])
            else
              size, name = line.split(' ')
              dir.children << File.new(name: name, size: size.to_i)
            end
          end
        end
      end
    end

    def initialize_directory(position)
      d = tree
      position.each do |k|
        d[k] ||= Directory.init(name: k)
        d = d[k]
      end
    end
  end

  class Directory < Hash
    attr_accessor :name, :children

    def self.init(name:, children: [])
      new.tap do |d|
        d.name = name
        d.children = children
      end
    end

    def []=(key, value)
      super(key, value).tap do
        children << value
      end
    end

    def to_s(*args)
      "<Directory name: #{name}, children: #{children} - #{super(*args)}>"
    end

    def size
      @size ||= children.sum(&:size)
    end
  end

  class File
    attr_reader :name, :size

    def initialize(name:, size:)
      @name = name
      @size = size
    end
  end
end
