module SimpleImageEditor

  # Holds a list of commands and processes the selected command.
  class CommandSet
    attr_reader :commands

    # Intializes with an empty list of commands.
    # @param image The image object.
    def initialize(image)
      @commands = {}
      @image = image
    end

    # Adds a command to the list.
    # @param key The keyboard key that identifies the command.
    # @return [nil]
    def add_command(key, argument_types=[], &block)
      commands[key] = SimpleImageEditor::Command.new argument_types, block
    end

    # Executes a command in the command line.
    # @param command_line The command line string.
    # @return [Image] A new image after the command has been processed.
    def execute(command_line)
      command_args = command_line.split
      key = command_args.shift
      command = command_for(key, command_args)
      @image = command.transform(@image, command_args)
    end

    private

    # Finds a command given a key and arguments.
    # @param key The keyboard key that identifies the command.
    # @param command_args The arguments passed to the command.
    # @return [Command] Returns a command if the key is found and the arguments are valid. Returns a NullCommand otherwise.
    def command_for(key, command_args)
      command = @commands[key]
      return command if valid_command?(command, command_args)
      NullCommand
    end

    # Validates that the command exists and the number of arguments is correct.
    # @param command The object implementing the command.
    # @param command_args The arguments passed to the command.
    # @return [boolean] True if the params are correct. False otherwise.
    def valid_command?(command, command_args)
      command &&
      (command.number_of_arguments == command_args.size) &&
      command.valid_format?(command_args)
    end
  end
end