module SimpleImageEditor
  class CommandRunner
    @list_of_classes = []

    class << self
      attr_reader :list_of_classes

      def apply_on(image, command_line)
        command_args = command_line.split
        command_id = command_args.shift
        command = command_for(command_id, command_args)
        command.transform(image, command_args)
      end

      def command(identifier)
        new_class = Class.new(SimpleImageEditor::Command)
        new_class.define_key identifier
        SimpleImageEditor::CommandRunner.list_of_classes << new_class
      end

      private

      def command_for(command_id, command_args)
        command_class = @list_of_classes.find do |the_class|
          the_class.id == command_id
        end
        return command_class.new if validate_command_for(command_class, command_args)
        NullCommand.new
      end

      def validate_command_for(command_class, command_args)
        command_class &&
        (command_args.size == command_class.total_of_arguments) &&
        validate_arguments_for(command_class, command_args)
      end

      def validate_arguments_for(command_class, command_args)
        return true unless command_class.method_defined? :validates_format_for
        command_class.new.validates_format_for(command_args)
      end
    end
  end
end
