module SimpleImageEditor

  # Represents a command.
  class Command
    include SimpleImageEditor::CommandValidatable

    attr_accessor :number_of_arguments, :argument_types

    # Initializes a new command.
    # @param argument_types An array containing the type of parameters for validation.
    # @param block A block to execute when the command is called.
    # @returns[Command].
    def initialize(argument_types, block)
      @argument_types = argument_types
      @number_of_arguments = argument_types.size
      @block = block
    end

    # Executes a predefined block that implements the command functionalty.
    # @param target_object The target_object to be modified by the command.
    # @param args Additional arguments for the block to process the target_object.
    # @returns[Image].
    def transform(target_object, *args)
      @block.call(target_object, *args)
    end

  end
end
