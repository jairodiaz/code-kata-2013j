module SimpleImageEditor
  module CommandValidations

    # Returns true if all the arguments are numbers between 1 and 250.
    # @param args The arguments to be checked.
    # @return [boolean].
    def validates_numericality_of(*args)
      args = args.map{ |arg| arg.to_i }
      args.each { |arg| return false if arg < 1 || arg > 250 }
      true
    end

    # Returns true if the argument is a valid color (a capital letter).
    # @param args The arg to be checked.
    # @return [boolean].
    def validates_color_for(arg)
      !! (arg =~ /[A-Z]/)
    end
  end
end
