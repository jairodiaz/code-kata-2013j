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

      command 'F', [Integer, Integer, String] do |image, args|
        image.fill_region(args[0].to_i, args[1].to_i, args[2])
      end

      command 'B' , [Integer, Integer, String] do |image, args|
        image.draw_border(args[0].to_i, args[1].to_i, args[2])
      end

      command 'H', [Integer, Integer, Integer, String] do |image, args|
        image.horizontal(args[0].to_i, args[1].to_i, args[2].to_i, args[3])
      end

      command 'V', [Integer, Integer, Integer, String] do |image, args|
        image.vertical(args[0].to_i, args[1].to_i, args[2].to_i, args[3])
      end

      command 'I', [Integer, Integer] do |image, args|
        SimpleImageEditor::Image.new(args[0].to_i, args[1].to_i)
      end

      command 'L', [Integer, Integer, String] do |image, args|
        image.colour(args[0].to_i, args[1].to_i, args[2])
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
