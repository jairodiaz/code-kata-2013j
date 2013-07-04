module SimpleImageEditor

  # Represents a command.
  class Command
    include SimpleImageEditor::CommandValidations

    # Makes the class method transform accessible to instances.
    # @param image The image to be processed.
    # @param args The arguments required for the block to process the image.
    # @returns[Image].
    def transform(image, *args); self.class.transform(image, *args); end

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

    # Returns true if all the arguments are of valid type.
    # @param args The arguments to be checked.
    # @return [boolean].
    def validates_format_for(args)
      return true if self.class.argument_types.nil?
      args.each_with_index do |arg, index|
        result = self.class.argument_types[index] == Integer ? validates_numericality_of(arg)
                                                             : validates_color_for(arg)
        return false unless result
      end
      true
    end

  end
end
