module SimpleImageEditor

  # Represents a command.
  class Command
    include SimpleImageEditor::CommandValidatable

    attr_accessor :key, :block, :argument_types, :number_of_arguments

    # Executes a predefined block that implements the command functionalty.
    # @param image The image to be processed.
    # @param args The arguments required for the block to process the image.
    # @returns[Image].
    def transform(image, *args)
      block.call(image, *args)
    end

  end
end
