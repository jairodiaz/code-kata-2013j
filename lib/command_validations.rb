module SimpleImageEditor
  module CommandValidations
    def validates_numericality_of(*args)
      args = args.map{ |arg| arg.to_i }
      args.each { |arg| return false if arg < 1 || arg > 250 }
      true
    end
    def validates_color_for(arg)
      !! (arg =~ /[A-Z]/)
    end
  end
end
