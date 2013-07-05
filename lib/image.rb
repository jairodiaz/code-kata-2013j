module SimpleImageEditor

  # Represents an image
  class Image
    WHITE_COLOUR = 'O'

    attr_accessor :content, :width, :height, :flood_fill
    alias_method :to_a, :content

    # Delegates the fill methods to object FloodFill
    extend Forwardable
    def_delegator :@flood_fill, :fill_region
    def_delegator :@flood_fill, :draw_border

    # Create a new M x N image with all pixels coloured white
    def initialize(width=0, height=0)
      @width, @height = width, height
      @flood_fill = SimpleImageEditor::FloodFill.new(self)
      clear
    end

    # Clears the table, setting all pixels to white
    def clear
      @content = Array.new(@width) { Array.new(@height) { WHITE_COLOUR } }
      self
    end

    # Colours the pixel (X,Y) with colour C
    def colour(x, y, c)
      @content[x-1][y-1] = c
      self
    end

    # Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
    def vertical(x, y1, y2, c)
      @content[ x-1 ][ (y1-1)..(y2-1) ] = Array.new(y2 - y1 + 1){ c }
      self
    end

    #  Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
    def horizontal(x1, x2, y, c)
      @content = @content.transpose
      vertical(y, x1, x2, c)
      @content = @content.transpose
      self
    end
  end
end
