module SimpleImageEditor

  # Holds a group of commands to manipulate images.
  class ImageCommands < CommandRunner

    # Creates the image commands
    def initialize
      super

      command 'C' do |image|
        image.clear
      end

      command 'X' do |image|
        nil
      end

      command 'S' do |image|
        DisplayImage.display(image)
        image
      end

    end
  end

  private

  # Display the image to standard output
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
