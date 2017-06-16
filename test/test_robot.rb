# frozen_string_literal: true
require "minitest/autorun"

require_relative "../lib/robot"

class TestRobot < Minitest::Test
  parallelize_me!

  def test_validate
    refute Robot.valid_position?(nil)
    refute Robot.valid_position?(Position.new(-1, 0, :west))
    refute Robot.valid_position?(Position.new(0, -1, :west))
    refute Robot.valid_position?(Position.new(5, 0, :west))
    refute Robot.valid_position?(Position.new(0, 5, :west))
    refute Robot.valid_position?(Position.new(0, 0, :whatever))

    assert Robot.valid_position?(Position.new(0, 0, :north))
    assert Robot.valid_position?(Position.new(0, 4, :north))
    assert Robot.valid_position?(Position.new(4, 0, :north))
  end

  def test_move
    assert_nil Robot.move(nil)
    assert_equal Position.new(0, 0, :south), Robot.move(Position.new(0, 1, :south))
    assert_equal Position.new(0, 1, :north), Robot.move(Position.new(0, 0, :north))
    assert_equal Position.new(0, 0, :west), Robot.move(Position.new(1, 0, :west))
    assert_equal Position.new(1, 0, :east), Robot.move(Position.new(0, 0, :east))
  end

  def test_left
    assert_nil Robot.left(nil)
    assert_equal Position.new(0, 0, :south), Robot.left(Position.new(0, 0, :west))
    assert_equal Position.new(0, 0, :east), Robot.left(Position.new(0, 0, :south))
    assert_equal Position.new(0, 0, :north), Robot.left(Position.new(0, 0, :east))
    assert_equal Position.new(0, 0, :west), Robot.left(Position.new(0, 0, :north))
  end

  def test_right
    assert_nil Robot.right(nil)
    assert_equal Position.new(0, 0, :north), Robot.right(Position.new(0, 0, :west))
    assert_equal Position.new(0, 0, :east), Robot.right(Position.new(0, 0, :north))
    assert_equal Position.new(0, 0, :south), Robot.right(Position.new(0, 0, :east))
    assert_equal Position.new(0, 0, :west), Robot.right(Position.new(0, 0, :south))
  end
end

