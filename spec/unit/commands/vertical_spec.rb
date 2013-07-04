require 'spec_helper'

describe SimpleImageEditor::VerticalCommand do
  let(:image) { double('image') }

  describe "#define_key" do
    it "should be 'V'" do
      expect(SimpleImageEditor::VerticalCommand.key).to eql('V')
    end
  end

  describe "#number_of_arguments" do
    it "should be 4" do
      expect(SimpleImageEditor::VerticalCommand.total_of_arguments).to eql(4)
    end
  end

  describe "#transform" do
    it "calls to create a vertical line" do
      image.should_receive(:vertical).with(3, 2, 4, "C")
      SimpleImageEditor::VerticalCommand.new.transform(image, ["3", "2", "4", "C"])
    end
  end

  describe "#validates_format_for" do
    context "when the arguments are three numbers and a character" do
      it "returns true " do
        expect(SimpleImageEditor::VerticalCommand.new.validates_format_for ["1", "1", "1", "C"]).to be_true
      end
    end

    context "when the arguments are NOT three numbers and a character" do
      it "returns false" do
        expect(SimpleImageEditor::VerticalCommand.new.validates_format_for ["C", "3", "1", "C"]).to be_false
        expect(SimpleImageEditor::VerticalCommand.new.validates_format_for ["1", "3", "1", "0"]).to be_false
      end
    end
  end
end
