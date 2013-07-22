require 'spec_helper'

describe SimpleImageEditor::FloodFill do
  let(:image3x3) { SimpleImageEditor::Image.new(3, 3) }
  let(:bg) { SimpleImageEditor::Image::WHITE_COLOUR  }

  describe "#fill_region" do
    context "when the region expands in all directions" do
      it "should fill in the region with colour C" do
        initial_image = image3x3

        initial_image.content = [[bg, "L", bg],
                                 ["L", "L", "L"],
                                 [bg, "L", bg]]

        filled_image =  [[bg, "C", bg],
                        ["C", "C", "C"],
                        [bg, "C", bg]]

        flood_fill = SimpleImageEditor::FloodFill.new(initial_image, bg)
        x, y, c = 2, 2, "C"
        expect(flood_fill.fill_region(x, y, c).to_a).to eql(filled_image)
      end
    end

    context "when the region is a single pixel" do
      it "should colour the pixel with colour C" do
        initial_image = image3x3

        initial_image.content = [[bg, "L", bg],
                                 ["L", "L", "L"],
                                 [bg, "L", bg]]

        filled_image =  [["C", "L", bg],
                        ["L", "L", "L"],
                        [bg, "L", bg]]

        flood_fill = SimpleImageEditor::FloodFill.new(initial_image, bg)
        x, y, c = 1, 1, "C"
        expect(flood_fill.fill_region(x, y, c).to_a).to eql(filled_image)
      end
    end
  end

  describe "#draw_border" do

    context "when the region is a single pixel" do
      it "should colour the pixels around" do
        initial_image = image3x3

        initial_image.content = [["A", bg, bg],
                                 ["L", "L", "L"],
                                 [bg, "L", bg]]

        bordered_image =  [["A", "C", bg],
                           ["L", "L", "L"],
                           [bg, "L", bg]]

        flood_fill = SimpleImageEditor::FloodFill.new(initial_image, bg)
        x, y, c = 1, 1, "C"
        expect(flood_fill.draw_border(x, y, c).to_a).to eql(bordered_image)
      end
    end

    context "when the region is limited by a different colour" do
      it "should colour the pixels around but not the different colour" do
        initial_image = SimpleImageEditor::Image.new(4, 4)

        initial_image.content = [[bg, bg, bg, bg],
                                 [bg, "A", "B", bg],
                                 [bg, "A", "B", bg],
                                 [bg, bg, bg, bg]]

        bordered_image = [[bg, "X", bg, bg],
                          ["X", "A", "B", bg],
                          ["X", "A", "B", bg],
                          [bg, "X", bg, bg]]

        flood_fill = SimpleImageEditor::FloodFill.new(initial_image, bg)
        x, y, c = 2, 2, "X"
        expect(flood_fill .draw_border(x, y, c).to_a).to eql(bordered_image)
      end
    end

    context "when the region expands in all directions" do
      it "should draw a border around a region with colour C" do
        initial_image = SimpleImageEditor::Image.new(7, 7)

        initial_image.content = [[bg, bg, bg, bg, bg, bg, bg],
                                 [bg, bg, bg, bg, bg, bg, bg],
                                 [bg, bg, bg, "P", bg, bg, bg],
                                 [bg, bg, "P", "P", "P", bg, bg],
                                 [bg, bg, bg, "P", bg, bg, bg],
                                 [bg, bg, bg, bg, bg, bg, bg],
                                 [bg, bg, bg, bg, bg, bg, bg]]

        image_with_border =     [[bg, bg, bg, bg, bg, bg, bg],
                                 [bg, bg, bg, "M", bg, bg, bg],
                                 [bg, bg, "M", "P", "M", bg, bg],
                                 [bg, "M", "P", "P", "P", "M", bg],
                                 [bg, bg, "M", "P", "M", bg, bg],
                                 [bg, bg, bg, "M", bg, bg, bg],
                                 [bg, bg, bg, bg, bg, bg, bg]]

        flood_fill = SimpleImageEditor::FloodFill.new(initial_image, bg)
        x, y, c = 4, 4, "M"
        expect(flood_fill .draw_border(x, y, c).to_a).to eql(image_with_border)
      end
    end
  end
end
