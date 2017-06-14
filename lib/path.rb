require_relative "./robot"

class Path
  def initialize(path = [])
    @path = path.dup
  end

  def <<(destination)
    position = Robot.place(destination)
    @path << position if position
    position
  end

  def current_position
    @path.last
  end

  def to_a
    @path
  end
end
