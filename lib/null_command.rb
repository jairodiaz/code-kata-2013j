module SimpleImageEditor
  class NullCommand
    def self.transform(image=nil, args=nil)
      image
    end
  end
end
