module SimpleImageEditor

  # Holds a group of commands to manipulate images.
  class ImageCommands < CommandSet

    # Creates the image commands.
    # @param image The image to apply to the commands to.
    # @param std_output The standard output to display the image to.
    def initialize(image, std_output=nil)
      super(image)

      add_command 'I', [Integer, Integer] do |image, args|
        SimpleImageEditor::Image.new(args[0].to_i, args[1].to_i)
      end

      add_command 'X' do |image|
        throw :exit
      end

      add_command 'S' do |image|
        display = "=>\n"
        image.to_a.transpose.each { |row| display << row.join.concat("\n") if row }
        display << "\n"
        std_output.puts display
        image
      end

      add_command 'C' do |image|
        image.clear
      end

      add_command 'L', [Integer, Integer, String] do |image, args|
        image.colour(args[0].to_i, args[1].to_i, args[2])
      end

      add_command 'V', [Integer, Integer, Integer, String] do |image, args|
        image.vertical(args[0].to_i, args[1].to_i, args[2].to_i, args[3])
      end

      add_command 'H', [Integer, Integer, Integer, String] do |image, args|
        image.horizontal(args[0].to_i, args[1].to_i, args[2].to_i, args[3])
      end

      add_command 'F', [Integer, Integer, String] do |image, args|
        image.fill_region(args[0].to_i, args[1].to_i, args[2])
      end

      add_command 'B' , [Integer, Integer, String] do |image, args|
        image.draw_border(args[0].to_i, args[1].to_i, args[2])
      end
    end
  end
end
