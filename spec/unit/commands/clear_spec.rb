require 'spec_helper'

describe SimpleImageEditor::ClearCommand do
  let(:image) { double('image') }

  describe "#define_key" do
    it "should be 'C'" do
      expect(SimpleImageEditor::ClearCommand.id).to eql('C')
    end
  end

  describe "#transform" do
    it "calls to clear an image" do
      image.should_receive(:clear)
      SimpleImageEditor::ClearCommand.new.transform(image)
    end
  end
end
