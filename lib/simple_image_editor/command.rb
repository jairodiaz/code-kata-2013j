module SimpleImageEditor

  # Represents a command.
  class Command
    include SimpleImageEditor::CommandValidatable

    attr_accessor :block, :number_of_arguments, :argument_types


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
    # @param image The image to be processed.
    # @param args The arguments required for the block to process the image.
    # @returns[Image].
    def transform(image, *args)
      block.call(image, *args)
    end

  end
end
