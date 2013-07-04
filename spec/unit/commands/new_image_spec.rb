require 'spec_helper'

describe SimpleImageEditor::NewImageCommand do
  let(:image) { double('image') }

  describe "#define_key" do
    it "should be 'I" do
      expect(SimpleImageEditor::NewImageCommand.key).to eql('I')
    end
  end

  describe "#number_of_arguments" do
    it "should be 2" do
      expect(SimpleImageEditor::NewImageCommand.total_of_arguments).to eql(2)
    end
  end

  describe "#transform" do
    it "calls to create a new image" do
      SimpleImageEditor::Image.should_receive(:new).with(5, 3)
      SimpleImageEditor::NewImageCommand.new.transform(image, ["5", "3"])
    end
  end

  describe "#validates_format_for" do
    context "when both arguments are numbers between 1 and 250" do
      it "returns true" do
        expect(SimpleImageEditor::NewImageCommand.new.validates_format_for ["5", "3"]).to be_true
      end
    end

    context "when one argument is NOT between 1 and 250" do
      it "returns false" do
        expect(SimpleImageEditor::NewImageCommand.new.validates_format_for ["0", "3"]).to be_false
        expect(SimpleImageEditor::NewImageCommand.new.validates_format_for ["251", "3"]).to be_false
      end
    end
  end
end
