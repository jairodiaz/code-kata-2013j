module SimpleImageEditor

  # A command that does nothing. Used by default when commands are not found.
  class NullCommand
    def self.transform(image=nil, args=nil)
      image
    end
  end
end
