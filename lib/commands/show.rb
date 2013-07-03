module SimpleImageEditor
  class ShowCommand < Command
    define_key 'S'
    def transform(image, args=nil)
      DisplayImage.display(image)
      image
    end
  end

  private

  class DisplayImage
    def self.display(image)
      table = image.to_a.transpose
      display = "=>\n"
      table.each { |row| display << row.join.concat("\n") if row }
      display << "\n"
      Kernel.puts display
    end
  end
end
