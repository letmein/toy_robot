require_relative "./robot"
require_relative "./path"

class Game
  def initialize(path, input, output)
    @path = path
    @input = input
    @output = output
  end

  def play
    @input.each_line do |line|
      command = line.upcase
      case command
      when /PLACE\s\w+/
        @path << parse_position(command)
      when /MOVE\s/
        @path << Robot.move(@path.current_position)
      when /LEFT\s/
        @path << Robot.left(@path.current_position)
      when /RIGHT\s/
        @path << Robot.right(@path.current_position)
      when /REPORT\s/
        write @path.current_position.inspect
      when /PATH\s/
        write @path.to_a.map(&:inspect).join("\n")
      else
        write "unknown command"
      end
    end
    @path.to_a
  end

  private

  def write(str)
    @output.write("#{str}\n")
  end

  def parse_position(command)
    m = /PLACE\s+(\d),\s*(\d),\s*(\w+)/.match(command)
    return unless m
    Position.new(m[1].to_i, m[2].to_i, m[3].to_s.downcase.to_sym)
  end
end
