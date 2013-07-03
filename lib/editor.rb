require "image"
require "command_runner"
require "command_validations"
require "command"
require "commands/null"
require "commands/exit"
require "commands/new_image"
require "commands/clear"
require "commands/show"
require "commands/colour"
require "commands/vertical"
require "commands/horizontal"
require "commands/fill"
require "commands/draw_border"

module SimpleImageEditor
  class Editor

    def initialize
      image = Image.new
      while image = Command.run_for(image, ask_which_command)
      end
      Kernel.puts "Session terminated"
    end

    private

    COMMAND_PROMPT = '> '

    def ask_which_command
      Kernel.print COMMAND_PROMPT
      Kernel.gets.chomp
    end

  end
end
