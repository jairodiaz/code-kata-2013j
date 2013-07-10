module SimpleImageEditor

  #Implements validation methods for a command.
  module CommandValidatable
    # Returns true if the arguments is a numbers between 1 and 250.
    # @param args The argument to be checked.
    # @return [boolean].
    def validates_numericality_of(arg)
      arg.to_i >= 1 && arg.to_i <= 250
    end

    # Returns true if the argument is a valid color (a capital letter).
    # @param args The arg to be checked.
    # @return [boolean].
    def validates_color_for(arg)
      !! (arg =~ /[A-Z]/)
    end

    # Returns true if all the arguments are of valid type or there is no argument_type information.
    # @param args The arguments to be checked.
    # @return [boolean].
    def validates_format_for(args)
      return true if self.argument_types.nil?
      args.each_with_index do |arg, index|
        result = if self.argument_types[index] == Integer
          validates_numericality_of(arg)
        else
          validates_color_for(arg)
        end
        return false unless result
      end
      true
    end
  end
end
