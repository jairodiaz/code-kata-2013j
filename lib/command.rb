module SimpleImageEditor

  # Represents a command.
  class Command
    include SimpleImageEditor::CommandValidations

    class << self
    attr_reader :key

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
    end
  end
end
