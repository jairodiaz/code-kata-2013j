module SimpleImageEditor
  class HorizontalCommand < Command
    define_key 'H'
    number_of_arguments 4
    def transform(image, args)
      image.horizontal(args[0].to_i, args[1].to_i, args[2].to_i, args[3])
    end
    def validates_format_for(args)
      validates_numericality_of(args[0], args[1], args[2]) &&
      validates_color_for(args[3])
    end
  end

  SimpleImageEditor::CommandRunner.add_command HorizontalCommand
end
