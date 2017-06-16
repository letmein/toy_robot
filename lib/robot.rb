require_relative "./position"

module Robot
  MAX_X = 4
  MAX_Y = 4
  WEST = :west
  EAST = :east
  NORTH = :north
  SOUTH = :south

  def self.valid_position?(position)
    position &&
    (0..MAX_X).member?(position.x) &&
      (0..MAX_Y).member?(position.y) &&
      [WEST, EAST, NORTH, SOUTH].member?(position.facing)
  end

  def self.move(position)
    return unless position
    dx = case position.facing
         when WEST then -1
         when EAST then 1
         else 0
         end
    dy = case position.facing
         when NORTH then 1
         when SOUTH then -1
         else 0
         end
    Position.new(position.x + dx, position.y + dy, position.facing)
  end

  def self.left(position)
    return unless position
    facing = case position.facing
             when WEST then SOUTH
             when SOUTH then EAST
             when EAST then NORTH
             when NORTH then WEST
             end
    Position.new(position.x, position.y, facing)
  end

  def self.right(position)
    return unless position
    facing = case position.facing
             when WEST then NORTH
             when NORTH then EAST
             when EAST then SOUTH
             when SOUTH then WEST
             end
    Position.new(position.x, position.y, facing)
  end
end
