module SimpleImageEditor
  class Command
    include SimpleImageEditor::CommandValidations
    extend SimpleImageEditor::CommandRunner

    @list_of_classes = []

    class << self
      attr_reader :list_of_classes, :id

      def define_key(id)
        @id = id
      end

      def number_of_arguments(number)
        @number_of_arguments = number
      end

      def total_of_arguments
        @number_of_arguments || 0
      end

      def inherited(subclass)
        Command.list_of_classes << subclass
      end
    end
  end
end
