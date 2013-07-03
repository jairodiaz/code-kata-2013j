require 'spec_helper'

describe SimpleImageEditor::ExitCommand do

  describe "#define_key" do
    it "should be 'X'" do
      expect(SimpleImageEditor::ExitCommand.id).to eql('X')
    end
  end

  describe "#transform" do
    it "returns 'nil'" do
      expect(SimpleImageEditor::ExitCommand.new.transform).to eql(nil)
    end
  end
end
