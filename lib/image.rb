module SimpleImageEditor

  # Represents an image
  class Image
    WHITE_COLOUR = 'O'

    attr_accessor :content
    alias_method :to_a, :content

    # Create a new M x N image with all pixels coloured white
    def initialize(width=0, height=0)
      @width, @height = width, height
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

    # Fill the region R with the colour C. R is defined as: Pixel (X,Y) belongs to R.
    # Any other pixel which is the same colour as (X,Y) and shares a common side with any
    # pixel in R also belongs to this region.
    def fill_region(x, y, new_colour, old_colour=nil, border_colour=nil)
      # The recursive algorithm. Starting at x and y, changes any adjacent
      # characters that match old_colour to new_colour.
      # This algorithm was taken from:
      # http://inventwithpython.com/blog/2011/08/11/recursion-explained-with-the-flood-fill-algorithm-and-zombies-and-cats/

      # Adjust algorithm coordinates because the image first pixel is (1,1)
      # but the algorith requires (0,0).
      if old_colour.nil?
        x -= 1; y -= 1
        old_colour = @content[x][y]
      end

      # Base case. If the current x, y character is not the old_colour,
      # then do nothing. However, the current character may be a border
      # so check it.
      if (@content[x][y] != old_colour)
        colour_border(x, y, new_colour, border_colour) if border_colour
        return
      end

      @content[x][y] = new_colour

      # Recursive calls. Make a recursive call as long as we are not on the
      # boundary (which would cause an Error).
      fill_region(x-1, y, new_colour, old_colour, border_colour) if x > 0
      fill_region(x, y-1, new_colour, old_colour, border_colour) if y > 0
      fill_region(x+1, y, new_colour, old_colour, border_colour) if x < @width - 1
      fill_region(x, y+1, new_colour, old_colour, border_colour) if y < @height - 1
      self
    end

    # Colours the border of a region.
    def colour_border(x, y, new_colour, border_colour)
      @content[x][y] = border_colour if (@content[x][y] != new_colour) &&
                                        (@content[x][y] == WHITE_COLOUR)
    end

    # Draw a border around the region R with the colour C. R is defined as: Pixel (X,Y) belongs to R.
    # Any other pixel which is the same colour as (X,Y) and shares a common side with any pixel in R also
    # belongs to this region.
    def draw_border(x, y, border_colour)
      original_colour = @content[x-1][y-1]
      temp_colour = '.'

      fill_region(x, y, temp_colour, nil, border_colour)

      @content.map { |column| column.map! { |colour| colour == temp_colour ? original_colour : colour } }
      self
    end
  end
end
