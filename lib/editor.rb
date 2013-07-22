require "simple_image_editor/image_floodfill"
require "simple_image_editor/image"
require "simple_image_editor/command_validatable"
require "simple_image_editor/command"
require "simple_image_editor/null_command"
require "simple_image_editor/command_set"
require "simple_image_editor/image_commands"

module SimpleImageEditor

  # Edits images taking commands using a read-eval-loop.
  class Editor

    # Initialize the application components.
    def initialize(std_input, std_output)
      @std_input = std_input
      @std_output = std_output
      @commands = ImageCommands.new(Image.new, std_output)
      read_eval_loop
    end

    private

    # Start a read-eval-loop.
    def read_eval_loop
      catch :exit do
        loop do
          @commands.execute read_command
        end
      end
      @std_output.puts "Session terminated"
    end

    # The string used as the command prompt.
    COMMAND_PROMPT = '> '

    # Read the command from standard input.
    def read_command
      @std_output.print COMMAND_PROMPT
      @std_input.gets.chomp
    end
  end
end
