task default: %w[test]

desc "Run tests"
task :test do
  Dir.glob("test/test_*.rb") { |f| require_relative(f) }
end

desc "Start the game"
task :play do
  require_relative "lib/game"
  game = Game.new($stdin, $stdout)
  puts "Available commands: PLACE x,y,facing | MOVE | LEFT | RIGHT | REPORT | PATH"
  puts "Press Ctrl+C to exit"
  game.play
end
