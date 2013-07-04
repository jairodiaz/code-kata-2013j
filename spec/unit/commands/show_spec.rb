require 'spec_helper'

describe SimpleImageEditor::ShowCommand do

  describe "#define_key" do
    it "should be 'S'" do
      expect(SimpleImageEditor::ShowCommand.key).to eql('S')
    end
  end

  describe "#transform" do
    it "does nothing to an image" do
      image = SimpleImageEditor::Image.new(2, 3)
      Kernel.stub(:puts)
      expect(SimpleImageEditor::ShowCommand.new.transform(image)).to equal(image)
    end

    it "displays the image to the standard output" do
      image = SimpleImageEditor::Image.new(2, 2)
      Kernel.should_receive(:puts).with("=>\nOO\nOO\n\n")
      expect(SimpleImageEditor::ShowCommand.new.transform(image)).to equal(image)
    end
  end
end
