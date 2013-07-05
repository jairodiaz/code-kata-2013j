module SimpleImageEditor
  module CommandValidations
    # Returns true if all the arguments are numbers between 1 and 250.
    # @param args The arguments to be checked.
    # @return [boolean].
    def validates_numericality_of(*args)
      args = args.map(&:to_i)
      args.all? { |arg| arg >= 1 and arg <= 250 }
    end

    # Returns true if the argument is a valid color (a capital letter).
    # @param args The arg to be checked.
    # @return [boolean].
    def validates_color_for(arg)
      !! (arg =~ /[A-Z]/)
    end

    # Returns true if all the arguments are of valid type.
    # @param args The arguments to be checked.
    # @return [boolean].
    def validates_format_for(args)
      return true if self.argument_types.nil?
      args.each_with_index do |arg, index|
        result = self.argument_types[index] == Integer ? validates_numericality_of(arg)
                                                             : validates_color_for(arg)
        return false unless result
      end
      true
    end
  end
end
