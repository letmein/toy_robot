require_relative "./robot"

class Game
  def initialize(input, output)
    @input = input
    @output = output
  end

  def play
    path = []
    @input.each_line do |line|
      command = line.upcase
      case command
      when /PLACE\s\w+/
        place path, parse_position(command)
      when /MOVE\s/
        place path, Robot.move(path.last)
      when /LEFT\s/
        place path, Robot.left(path.last)
      when /RIGHT\s/
        place path, Robot.right(path.last)
      when /REPORT\s/
        write path.last.inspect
      when /PATH\s/
        write @path.map(&:inspect).join("\n")
      else
        write "unknown command"
      end
    end
    path
  end

  private

  def place(path, position)
    path << position if Robot.valid_position?(position)
  end

  def write(str)
    @output.write("#{str}\n")
  end

  def parse_position(command)
    m = /PLACE\s+(\d),\s*(\d),\s*(\w+)/.match(command)
    return unless m
    Position.new(m[1].to_i, m[2].to_i, m[3].to_s.downcase.to_sym)
  end
end
