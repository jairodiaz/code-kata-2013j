require 'spec_helper'

describe SimpleImageEditor::NullCommand do

  describe "#transform" do
    it "should return the image unchanged" do
      image = double('image')
      expect(SimpleImageEditor::NullCommand.transform(image)).to equal(image)
    end
  end
end
