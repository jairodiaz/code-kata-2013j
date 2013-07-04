module SimpleImageEditor
  class Image
    WHITE_COLOUR = 'O'

    attr_accessor :content
    alias_method :to_a, :content

    def initialize(width=0, height=0)
      @width, @height = width, height
      clear
    end

    def clear
      @content = Array.new(@width) { Array.new(@height) { WHITE_COLOUR } }
      self
    end

    def colour(x, y, c)
      @content[x-1][y-1] = c
      self
    end

    def vertical(x, y1, y2, c)
      @content[ x-1 ][ (y1-1)..(y2-1) ] = Array.new(y2 - y1 + 1){ c }
      self
    end

    def horizontal(x1, x2, y, c)
      @content = @content.transpose
      vertical(y, x1, x2, c)
      @content = @content.transpose
      self
    end

    def fill_region(x, y, new_colour, old_colour=nil, border_colour=nil)
      if old_colour.nil?
        x -= 1; y -= 1
        old_colour = @content[x][y]
      end

      if (@content[x][y] != old_colour)
        colour_border(x, y, new_colour, border_colour) if border_colour
        return
      end

      @content[x][y] = new_colour

      fill_region(x-1, y, new_colour, old_colour, border_colour) if x > 0
      fill_region(x, y-1, new_colour, old_colour, border_colour) if y > 0
      fill_region(x+1, y, new_colour, old_colour, border_colour) if x < @width - 1
      fill_region(x, y+1, new_colour, old_colour, border_colour) if y < @height - 1
      self
    end

    def colour_border(x, y, new_colour, border_colour)
      @content[x][y] = border_colour if (@content[x][y] != new_colour) &&
                                        (@content[x][y] == WHITE_COLOUR)
    end

    def draw_border(x, y, border_colour)
      original_colour = @content[x-1][y-1]
      temp_colour = '.'

      fill_region(x, y, temp_colour, nil, border_colour)

      @content.map { |column| column.map! { |colour| colour == temp_colour ? original_colour : colour } }
      self
    end
  end
end
