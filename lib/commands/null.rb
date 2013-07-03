module SimpleImageEditor
  class NullCommand
    def transform(image=nil, args=nil)
      image
    end
  end
end
