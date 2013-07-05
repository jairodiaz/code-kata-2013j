module SimpleImageEditor

  # Implements the floodfill algorithm to fill up an image
  module FloodFill
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
                                        (@content[x][y] == SimpleImageEditor::Image::WHITE_COLOUR)
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
