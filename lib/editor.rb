require "image_floodfill"
require "image"
require "command_validatable"
require "command"
require "null_command"
require "command_set"
require "image_commands"


module SimpleImageEditor

  # Edits images taking commands using a read-eval-loop.
  class Editor

    # Initialize the application components.
    def initialize(std_input, std_output)
      @std_input = std_input
      @std_output = std_output
      @image_commands = ImageCommands.new std_output
      @image = Image.new
      read_eval_loop
    end

    private

    # Start a read-eval-loop.
    def read_eval_loop
      loop do
        selected_command = read_command
        @image = @image_commands.apply_on @image, selected_command
        break if @image.nil?
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
