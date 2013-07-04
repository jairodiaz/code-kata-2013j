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

  # Edits images taking commands using a read-eval-loop.
  class Editor
    class << self

      # Start a read-eval-loop.
      def read_eval_loop
        image = Image.new
        loop do
          input_command = read_command
          image = Command.apply_on image, input_command
          break if image.nil?
        end
        Kernel.puts "Session terminated"
      end

      private

      # The string used as the command prompt
      COMMAND_PROMPT = '> '

      # Read the command from standart input
      def read_command
        Kernel.print COMMAND_PROMPT
        Kernel.gets.chomp
      end

    end
  end
end
