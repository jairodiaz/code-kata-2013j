module SimpleImageEditor
  class Command
    include SimpleImageEditor::CommandValidations

    class << self
    attr_reader :id

      def define_key(id)
        @id = id
      end

      def number_of_arguments(number)
        @number_of_arguments = number
      end

      def total_of_arguments
        @number_of_arguments || 0
      end
    end
  end
end
