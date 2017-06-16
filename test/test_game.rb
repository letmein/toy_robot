# frozen_string_literal: true
require "minitest/autorun"
require "stringio"

require_relative "../lib/game"

class TestGame < Minitest::Test
  def test_play_acceptance_a
    output = StringIO.new
    input = StringIO.new <<~EOF
      PLACE 0,0,NORTH
      MOVE
      REPORT
    EOF
    expected_output = <<~EOF
      0, 1, NORTH
    EOF

    game = Game.new(input, output)
    game.play

    assert_equal expected_output, output.string
  end

  def test_play_acceptance_b
    output = StringIO.new
    input = StringIO.new <<~EOF
      PLACE 0,0,NORTH
      LEFT
      REPORT
    EOF
    expected_output = <<~EOF
      0, 0, WEST
    EOF

    game = Game.new(input, output)
    game.play

    assert_equal expected_output, output.string
  end

  def test_play_acceptance_c
    output = StringIO.new
    input = StringIO.new <<~EOF
      PLACE 1,2,EAST
      MOVE
      MOVE
      LEFT
      MOVE
      REPORT
    EOF
    expected_output = <<~EOF
      3, 3, NORTH
    EOF

    game = Game.new(input, output)
    game.play

    assert_equal expected_output, output.string
  end

  def test_play_hardcore
    output = StringIO.new
    input = StringIO.new <<~EOF
      LEFT
      RIGHT
      MOVE
      PLACE 1,1,EAST
      MOVE
      MOVE
      REPORT
      PLACE 5,1,WEST
      REPORT
      PLACE 2,3,SOUTH
      MOVE
      MOVE
      MOVE
      REPORT
      LEFT
      MOVE
      REPORT
      RIGHT
      MOVE
      REPORT
    EOF
    expected_output = <<~EOF
      3, 1, EAST
      3, 1, EAST
      2, 0, SOUTH
      3, 0, EAST
      3, 0, SOUTH
    EOF

    game = Game.new(input, output)
    game.play

    assert_equal expected_output, output.string
  end
end
