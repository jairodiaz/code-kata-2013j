require 'spec_helper'

describe SimpleImageEditor::DrawBorderCommand do
  let(:image) { double('image') }

  describe "#define_key" do
    it "should be 'B'" do
      expect(SimpleImageEditor::DrawBorderCommand.id).to eql('B')
    end
  end

  describe "#number_of_arguments" do
    it "should be 3" do
      expect(SimpleImageEditor::DrawBorderCommand.total_of_arguments).to eql(3)
    end
  end

  describe "#transform" do
    it "calls to draw a border around a region" do
      image.should_receive(:draw_border).with(2, 4, "C")
      SimpleImageEditor::DrawBorderCommand.new.transform(image, ["2", "4", "C"])
    end
  end

  describe "#validates_format_for" do
    context "when the arguments are two numbers and a character" do
      it "returns true " do
        expect(SimpleImageEditor::DrawBorderCommand.new.validates_format_for ["1", "1", "C"]).to be_true
      end
    end

    context "when the arguments are NOT three numbers and a character" do
      it "returns false" do
        expect(SimpleImageEditor::DrawBorderCommand.new.validates_format_for ["C", "3", "C"]).to be_false
        expect(SimpleImageEditor::DrawBorderCommand.new.validates_format_for ["1", "3", "0"]).to be_false
      end
    end
  end
end
