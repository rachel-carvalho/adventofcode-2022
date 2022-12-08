# frozen_string_literal: true

require_relative '../test_helper'
require_relative './solver'

describe Solver do
  before do
    @input = '''$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k'''
  end

  describe 'part 1 - find directories and sizes, list ones with <= 100k' do
    describe 'commands' do
      it 'parses first command and output' do
        s = Solver.new(@input)
        command = s.commands.first
        assert_equal 'cd', command.executable
        assert_equal ['/'], command.arguments
        assert_nil command.output
      end

      it 'parses second command and output' do
        s = Solver.new(@input)
        command = s.commands.second
        assert_equal 'ls', command.executable
        assert_equal [], command.arguments
        assert_equal ['dir a', '14848514 b.txt', '8504156 c.dat', 'dir d'], command.output
      end

      it 'parses third command and output' do
        s = Solver.new(@input)
        command = s.commands.third
        assert_equal 'cd', command.executable
        assert_equal ['a'], command.arguments
        assert_nil command.output
      end

      it 'parses fourth command and output' do
        s = Solver.new(@input)
        command = s.commands.fourth
        assert_equal 'ls', command.executable
        assert_equal [], command.arguments
        assert_equal ['dir e', '29116 f', '2557 g', '62596 h.lst'], command.output
      end

      it 'parses fifth command and output' do
        s = Solver.new(@input)
        command = s.commands.fifth
        assert_equal 'cd', command.executable
        assert_equal ['e'], command.arguments
        assert_nil command.output
      end

      it 'parses sixth command and output' do
        s = Solver.new(@input)
        command = s.commands[5]
        assert_equal 'ls', command.executable
        assert_equal [], command.arguments
        assert_equal ['584 i'], command.output
      end

      it 'parses seventh command and output' do
        s = Solver.new(@input)
        command = s.commands[6]
        assert_equal 'cd', command.executable
        assert_equal ['..'], command.arguments
        assert_nil command.output
      end

      it 'parses eighth command and output' do
        s = Solver.new(@input)
        command = s.commands[7]
        assert_equal 'cd', command.executable
        assert_equal ['..'], command.arguments
        assert_nil command.output
      end

      it 'parses nineth command and output' do
        s = Solver.new(@input)
        command = s.commands[8]
        assert_equal 'cd', command.executable
        assert_equal ['d'], command.arguments
        assert_nil command.output
      end

      it 'parses tenth command and output' do
        s = Solver.new(@input)
        command = s.commands[9]
        assert_equal 'ls', command.executable
        assert_equal [], command.arguments
        assert_equal ['4060174 j', '8033020 d.log', '5626152 d.ext', '7214296 k'], command.output
      end
    end

    describe 'directories' do
      it 'parses the root dir' do
        s = Solver.new(@input)
        assert_equal '/', s.root_dir.name
        assert_equal 4, s.root_dir.children.count
        assert_equal 48381165, s.root_dir.size
      end

      it 'parses dir a' do
        s = Solver.new(@input)
        dir = s.root_dir.children.first
        assert_equal 'a', dir.name
        assert_equal 4, dir.children.count
        assert_equal 94853, dir.size
      end

      it 'parses dir d' do
        s = Solver.new(@input)
        dir = s.root_dir.children.fourth
        assert_equal 'd', dir.name
        assert_equal 4, dir.children.count
        assert_equal 24933642, dir.size
      end

      it 'parses dir e' do
        s = Solver.new(@input)
        dir = s.root_dir.children.first.children.first
        assert_equal 'e', dir.name
        assert_equal 1, dir.children.count
        assert_equal 584, dir.size
      end

      it 'flattens directories' do
        s = Solver.new(@input)
        assert_equal ['/', 'a', 'e', 'd'], s.root_dir.flat_directories.map(&:name)
      end

      it 'filters directories with less than 100k in size' do
        s = Solver.new(@input)
        assert_equal ['a', 'e'], s.small_directories.map(&:name)
      end
    end
  end

  describe 'part 2 - find smallest size directory that will free up 30m' do
    it 'calculates current free space' do
      s = Solver.new(@input)
      assert_equal 21618835, s.root_dir.current_free_space
    end

    it 'calculates space that needs to be freed' do
      s = Solver.new(@input)
      assert_equal 8381165, s.need_to_free
    end

    it 'finds which directory to delete that will free the space needed' do
      s = Solver.new(@input)
      assert_equal 'd', s.directory_to_delete.name
      assert_equal 24933642, s.directory_to_delete.size
    end
  end
end
