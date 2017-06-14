class Position
  attr_reader :x, :y, :facing

  def initialize(x, y, facing)
    @x = x
    @y = y
    @facing = facing
  end

  def ==(other)
    x == other.x && y == other.y && facing == other.facing
  end

  def inspect
    "#{x}, #{y}, #{facing.to_s.upcase}"
  end
end
