module SimpleImageEditor

  # Holds a list of commands and processes the selected command.
  class CommandRunner
    attr_reader :commands

    # Intializes with an empty list of commands.
    def initialize
      @commands = []
    end

    # Identifies a command in the command line and process the command passing the image.
    # @param image The image object.
    # @param command_line The command line string.
    # @return [Image] A new image after the command has been processed.
    def apply_on(image, command_line)
      command_args = command_line.split
      key = command_args.shift
      command = command_for(key, command_args)
      command.transform(image, command_args)
    end

    # Adds a command to the list.
    # @param key The keyboard key that identifies the command.
    # @return [nil]
    def command(key)
      new_class = Class.new(SimpleImageEditor::Command)
      new_class.define_key key
      commands << new_class
    end

    # Adds a command to the list.
    # @param command_class A class representing a command.
    # @return [nil]
    def add_command(command_class)
      commands << command_class
    end

    private

    # Finds a command given a key and arguments.
    # @param key The keyboard key that identifies the command.
    # @param command_args The arguments passed to the command.
    # @return [Command] Returns a Command if the key is found and the arguments are valid.
    #                   Returns a NullCommand otherwise.
    def command_for(key, command_args)
      command_class = @commands.find do |the_class|
        the_class.key == key
      end
      return command_class.new if validate_command_for(command_class, command_args)
      NullCommand.new
    end

    # Validates that the command exists and the number of arguments is correct.
    # @param command_class The class implementing the command.
    # @param command_args The arguments passed to the command.
    # @return [true] True if the params are correct. False otherwise.
    def validate_command_for(command_class, command_args)
      command_class &&
      (command_args.size == command_class.total_of_arguments) &&
      validate_arguments_for(command_class, command_args)
    end

    # Validates the format of the arguments if a validation block
    # has been defined for the command.
    # @param command_class The class implementing the command.
    # @param command_args The arguments passed to the command.
    # @return [true] True if the params are valid. False otherwise.
    def validate_arguments_for(command_class, command_args)
      return true unless command_class.method_defined? :validates_format_for
      command_class.new.validates_format_for(command_args)
    end

  end
end
