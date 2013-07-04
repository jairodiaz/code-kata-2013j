module SimpleImageEditor
  class ClearCommand < Command
    define_key 'C'
    def transform(image, args=nil)
      image.clear
    end
  end
end

