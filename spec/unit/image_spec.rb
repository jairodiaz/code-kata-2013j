require 'spec_helper'

describe SimpleImageEditor::Image do
  let(:image3x3) { SimpleImageEditor::Image.new(3, 3) }
  let(:bg) { SimpleImageEditor::Image::WHITE_COLOUR  }

  subject { image3x3 }

  it { should respond_to :width }
  it { should respond_to :height }
  it { should respond_to :content }
  it { should respond_to :to_a }

  describe "#new" do
    it "should create an image of given width and height" do
      width, height = 5, 2
      new_image = Array.new(width) { Array.new(height) { bg } }
      expect(SimpleImageEditor::Image.new(width, height).to_a).to eql(new_image)
    end
  end

  describe "#clear" do
    it "should set all the pixels to white" do
      initial_image = image3x3

      initial_image.content = [["N", bg,  "M"],
                               ["X", "Y", "R"],
                               ["P", "B", "A"]]

      cleared_image = [[bg, bg, bg],
                       [bg, bg, bg],
                       [bg, bg, bg]]

      expect(initial_image.clear.to_a).to eql(cleared_image)
    end
  end

  describe "#colour" do
    it "should colour a pixel with a colour" do
      image = image3x3
      expect(image.colour(1, 1, 'C').to_a[0][0]).to eql('C')
    end
  end

  describe "#vertical" do
    it "should draw a vertical line" do
      image = image3x3
      x, y1, y2, c = 3, 1, 3, "C"

      image_with_vetical = [[bg, bg, bg],
                            [bg, bg, bg],
                            ["C", "C", "C"]]

      expect(image.vertical(x, y1, y2, c).to_a).to eql(image_with_vetical)
    end
  end

  describe "#horizontal" do
    it "should draw a horizontal line" do
      image = image3x3
      x1, x2, y, c = 1, 2, 2, "C"

      image_with_horizontal = [[bg, "C", bg],
                               [bg, "C", bg],
                               [bg, bg, bg]]

      expect(image.horizontal(x1, x2, y, c).to_a).to eql(image_with_horizontal)
    end
  end

  describe "delegated methods" do
    before do
      @flood_fill = double('flood_fill')
      @image = SimpleImageEditor::Image.new(3, 3, @flood_fill)
    end

    it "should delegate fill_region" do
      @flood_fill.should_receive(:fill_region)
      @image.fill_region(1, 1, "C")
    end

    it "should delegate draw_border" do
      @flood_fill.should_receive(:draw_border)
      @image.draw_border(1, 1, "C")
    end
  end
end
