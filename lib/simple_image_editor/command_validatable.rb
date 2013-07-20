module SimpleImageEditor

  #Implements validation methods for a command.
  module CommandValidatable

    # Returns true if all the arguments are of valid type or there is nothing to validate.
    # @param args The arguments to be checked.
    # @return [boolean].
    def valid_format?(args)
      # No validation required
      return true if self.argument_types.nil?

      args.each_with_index do |arg, index|
        return false unless valid_argument_at_index(arg, index)
      end

      true
    end

    # Returns true if the arguments is a numbers between 1 and 250.
    # @param args The argument to be checked.
    # @return [boolean].
    def valid_number?(arg)
      arg.to_i >= 1 && arg.to_i <= 250
    end

    # Returns true if the argument is a valid color (a capital letter).
    # @param args The arg to be checked.
    # @return [boolean].
    def valid_color?(arg)
      !! (arg =~ /[A-Z]/)
    end

    # Returns true if a given argument is valid applying the rigth validation rule.
    # @param arg The argument to be validated.
    # @param index The argument position in the parameter list to determine the validation rule.
    # @return [boolean].
    def valid_argument_at_index(arg, index)
      if self.argument_types[index] == Integer
          valid_number?(arg)
        else
          valid_color?(arg)
        end
      end
    end
end
