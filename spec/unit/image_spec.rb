require 'spec_helper'

describe SimpleImageEditor::Image do

  describe "#new" do
    it "should create an image of given width and height" do
      width, height = 5, 2
      new_image = Array.new(width) { Array.new(height) { SimpleImageEditor::Image::WHITE_COLOUR } }
      expect(SimpleImageEditor::Image.new(width, height).to_a).to eql(new_image)
    end
  end

  describe "#clear" do
    it "should set all the pixels to white" do
      initial_image = SimpleImageEditor::Image.new(3, 3)

      initial_image.content = [["N", "O", "M"],
                               ["X", "Y", "R"],
                               ["P", "B", "A"]]

      cleared_image = [["O", "O", "O"],
                       ["O", "O", "O"],
                       ["O", "O", "O"]]

      expect(initial_image.clear.to_a).to eql(cleared_image)
    end
  end

  describe "#colour" do
    it "should colour a pixel with a colour" do
      image = SimpleImageEditor::Image.new(2, 2)
      expect(image.colour(1, 1, 'C').to_a[0][0]).to eql('C')
    end
  end

  describe "#vertical" do
    it "should draw a vertical line" do
      image = SimpleImageEditor::Image.new(5, 5)
      x, y1, y2, c = 3, 2, 4, "C"

      image_with_vetical = [["O", "O", "O", "O", "O"],
                            ["O", "O", "O", "O", "O"],
                            ["O", "C", "C", "C", "O"],
                            ["O", "O", "O", "O", "O"],
                            ["O", "O", "O", "O", "O"]]

      expect(image.vertical(x, y1, y2, c).to_a).to eql(image_with_vetical)
    end
  end

  describe "#horizontal" do
    it "should draw a horizontal line" do
      image = SimpleImageEditor::Image.new(3, 3)
      x1, x2, y, c = 1, 2, 2, "C"

      image_with_horizontal = [["O", "C", "O"],
                               ["O", "C", "O"],
                               ["O", "O", "O"]]

      expect(image.horizontal(x1, x2, y, c).to_a).to eql(image_with_horizontal)
    end
  end

  describe "#fill_region" do
    context "when the region expands in all directions" do
      it "should fill in the region with colour C" do
        initial_image = SimpleImageEditor::Image.new(3, 3)

        initial_image.content = [["O", "L", "O"],
                                 ["L", "L", "L"],
                                 ["O", "L", "O"]]

        filled_image =  [["O", "C", "O"],
                        ["C", "C", "C"],
                        ["O", "C", "O"]]

        x, y, c = 2, 2, "C"
        expect(initial_image.fill_region(x, y, c).to_a).to eql(filled_image)
      end
    end

    context "when the region is a single pixel" do
      it "should colour the pixel with colour C" do
        initial_image = SimpleImageEditor::Image.new(3, 3)

        initial_image.content = [["O", "L", "O"],
                                 ["L", "L", "L"],
                                 ["O", "L", "O"]]

        filled_image =  [["C", "L", "O"],
                        ["L", "L", "L"],
                        ["O", "L", "O"]]

        x, y, c = 1, 1, "C"
        expect(initial_image.fill_region(x, y, c).to_a).to eql(filled_image)
      end
    end
  end

  describe "#draw_border" do

    context "when the region is a single pixel" do
      it "should colour the pixels around" do
        initial_image = SimpleImageEditor::Image.new(3, 3)

        initial_image.content = [["A", "O", "O"],
                                 ["L", "L", "L"],
                                 ["O", "L", "O"]]

        bordered_image =  [["A", "C", "O"],
                           ["L", "L", "L"],
                           ["O", "L", "O"]]

        x, y, c = 1, 1, "C"
        expect(initial_image.draw_border(x, y, c).to_a).to eql(bordered_image)
      end
    end

    context "when the region is limited by a different colour" do
      it "should colour the pixels around but not the different colour" do
        initial_image = SimpleImageEditor::Image.new(4, 4)

        initial_image.content = [["O", "O", "O", "O"],
                                 ["O", "A", "B", "O"],
                                 ["O", "A", "B", "O"],
                                 ["O", "O", "O", "O"]]

        bordered_image = [["O", "X", "O", "O"],
                          ["X", "A", "B", "O"],
                          ["X", "A", "B", "O"],
                          ["O", "X", "O", "O"]]

        x, y, c = 2, 2, "X"
        expect(initial_image.draw_border(x, y, c).to_a).to eql(bordered_image)
      end
    end

    context "when the region expands in all directions" do
      it "should draw a border around a region with colour C" do
        initial_image = SimpleImageEditor::Image.new(7, 7)

        initial_image.content = [["O", "O", "O", "O", "O", "O", "O"],
                                 ["O", "O", "O", "O", "O", "O", "O"],
                                 ["O", "O", "O", "P", "O", "O", "O"],
                                 ["O", "O", "P", "P", "P", "O", "O"],
                                 ["O", "O", "O", "P", "O", "O", "O"],
                                 ["O", "O", "O", "O", "O", "O", "O"],
                                 ["O", "O", "O", "O", "O", "O", "O"]]

        image_with_border =     [["O", "O", "O", "O", "O", "O", "O"],
                                 ["O", "O", "O", "M", "O", "O", "O"],
                                 ["O", "O", "M", "P", "M", "O", "O"],
                                 ["O", "M", "P", "P", "P", "M", "O"],
                                 ["O", "O", "M", "P", "M", "O", "O"],
                                 ["O", "O", "O", "M", "O", "O", "O"],
                                 ["O", "O", "O", "O", "O", "O", "O"]]
        x, y, c = 4, 4, "M"
        expect(initial_image.draw_border(x, y, c).to_a).to eql(image_with_border)
      end
    end
  end
end
