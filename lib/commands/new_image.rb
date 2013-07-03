module SimpleImageEditor
  class NewImageCommand < Command
    define_key 'I'
    number_of_arguments 2
    def transform(image, args)
      SimpleImageEditor::Image.new(args[0].to_i, args[1].to_i)
    end
    def validates_format_for(args)
      validates_numericality_of args[0], args[1]
    end
  end
end
