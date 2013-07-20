module SimpleImageEditor

  # Holds a list of commands and executes the selected command on a target object.
  class CommandSet
    attr_reader :commands

    # Intializes with an empty list of commands.
    # @param target_object The object to apply the commands upon.
    def initialize(target_object)
      @commands = {}
      @target_object = target_object
    end

    # Adds a command to the list.
    # @param key The keyboard key that identifies the command.
    # @param argument_types An array of types to validate the command arguments.
    # @param block A block to execute when the command is called.
    # @return [nil]
    def add_command(key, argument_types=[], &block)
      commands[key] = SimpleImageEditor::Command.new argument_types, block
    end

    # Executes a command in the command line.
    # @param command_line The command line string.
    # @return [object] A new target_object after the command has been processed.
    def execute(command_line)
      command_args = command_line.split
      key = command_args.shift
      command = command_for(key, command_args)
      @target_object = command.transform(@target_object, command_args)
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
