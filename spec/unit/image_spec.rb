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
end
