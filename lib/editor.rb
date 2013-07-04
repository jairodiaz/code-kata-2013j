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

    # Initialize the application components
    def initialize
      @command_runner = CommandRunner.new

      commands = [ColourCommand, ClearCommand, DrawBorderCommand,
                  ExitCommand, FillCommand, HorizontalCommand,
                  NewImageCommand, ShowCommand, VerticalCommand]

      commands.map { |command| @command_runner.add_command command }

      @image = Image.new
      read_eval_loop
    end

    private

    # Start a read-eval-loop.
    def read_eval_loop
      loop do
        selected_command = read_command
        @image = @command_runner.apply_on @image, selected_command
        break if @image.nil?
      end
      Kernel.puts "Session terminated"
    end

    # The string used as the command prompt
    COMMAND_PROMPT = '> '

    # Read the command from standart input
    def read_command
      Kernel.print COMMAND_PROMPT
      Kernel.gets.chomp
    end
  end
end
