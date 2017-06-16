require_relative "./robot"

class Game
  def initialize(input, output, path = [])
    @path = path
    @input = input
    @output = output
  end

  def play
    @input.each_line do |line|
      command = line.upcase
      case command
      when /PLACE\s\w+/
        place parse_position(command)
      when /MOVE\s/
        place Robot.move(current_position)
      when /LEFT\s/
        place Robot.left(current_position)
      when /RIGHT\s/
        place Robot.right(current_position)
      when /REPORT\s/
        write current_position.inspect
      when /PATH\s/
        write @path.map(&:inspect).join("\n")
      else
        write "unknown command"
      end
    end
    @path
  end

  private

  def current_position
    @path.last
  end

  def place(position)
    @path << position if Robot.valid_position?(position)
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
