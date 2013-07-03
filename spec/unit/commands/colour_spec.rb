require 'spec_helper'

describe SimpleImageEditor::ColourCommand do
  let(:image) { double('image') }

  describe "#define_key" do
    it "should be 'L'" do
      expect(SimpleImageEditor::ColourCommand.id).to eql('L')
    end
  end

  describe "#number_of_arguments" do
    it "should be 3" do
      expect(SimpleImageEditor::ColourCommand.total_of_arguments).to eql(3)
    end
  end

  describe "#transform" do
    it "calls to create a new image" do
      image.should_receive(:colour).with(1, 1, "C")
      SimpleImageEditor::ColourCommand.new.transform(image, ["1", "1", "C"])
    end
  end

  describe "#validates_format_for" do
    context "when the arguments are two numbers and a character" do
      it "returns true " do
        expect(SimpleImageEditor::ColourCommand.new.validates_format_for ["1", "1", "C"]).to be_true
      end
    end

    context "when the arguments are NOT two numbers and a character" do
      it "returns false" do
        expect(SimpleImageEditor::ColourCommand.new.validates_format_for ["C", "3", "C"]).to be_false
        expect(SimpleImageEditor::ColourCommand.new.validates_format_for ["1", "3", "0"]).to be_false
      end
    end
  end
end
