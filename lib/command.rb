module SimpleImageEditor

  # Represents a command.
  class Command
    extend SimpleImageEditor::CommandValidations

    class << self
      attr_reader :key
      attr_accessor :block, :argument_types

      # Defines the keyboard key that identifies the command.
      # @param key The keyboard key.
      def define_key(key)
        @key = key
      end

      # Defines the number of arguments that the command requires.
      # @param number The number of arguments.
      def number_of_arguments(number)
        @number_of_arguments = number
      end

      # Returns the total number of arguments or 0 if not specified for the command.
      # @returns[Integer].
      def total_of_arguments
        @number_of_arguments || 0
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
end
