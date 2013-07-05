require 'spec_helper'

describe SimpleImageEditor::NullCommand do

  describe "#transform" do
    it "does nothing to an image" do
      image = double('image')
      expect(SimpleImageEditor::NullCommand.transform(image)).to equal(image)
    end
  end
end
