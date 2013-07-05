require "image"
require "command_validations"
require "command"
require "null_command"
require "command_runner"
require "image_commands"


module SimpleImageEditor

  # Edits images taking commands using a read-eval-loop.
  class Editor

    # Initialize the application components.
    def initialize
      @image_commands = ImageCommands.new
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
      Kernel.puts "Session terminated"
    end

    # The string used as the command prompt.
    COMMAND_PROMPT = '> '

    # Read the command from standard input.
    def read_command
      Kernel.print COMMAND_PROMPT
      Kernel.gets.chomp
    end
  end
end
