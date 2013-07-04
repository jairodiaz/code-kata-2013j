module SimpleImageEditor
  class FillCommand < Command
    define_key 'F'
    number_of_arguments 3
    def transform(image, args)
      image.fill_region(args[0].to_i, args[1].to_i, args[2])
    end
    def validates_format_for(args)
      validates_numericality_of(args[0], args[1]) &&
      validates_color_for(args[2])
    end
  end
end
