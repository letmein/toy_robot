# frozen_string_literal: true
require "minitest/autorun"

require_relative "../lib/path"

class TestPath < Minitest::Test
  parallelize_me!

  def test_push_valid_position
    path = Path.new
    path << Position.new(0, 0, :north)
    path << Position.new(0, 1, :north)
    assert_equal Position.new(0, 1, :north), path.current_position
  end

  def test_push_invalid_position
    path = Path.new
    path << Position.new(0, 0, :north)
    path << Position.new(0, 100, :north)
    assert_equal Position.new(0, 0, :north), path.current_position
  end

  def test_to_a
    path = Path.new(['foo'])
    assert_equal ['foo'], path.to_a
  end
end
