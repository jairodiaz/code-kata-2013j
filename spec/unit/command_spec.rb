require 'spec_helper'

describe SimpleImageEditor::Command do
  let(:my_command) { Class.new(SimpleImageEditor::Command) }

  describe "#key" do
    it "should have a key" do
      my_command.key = "N"
      expect(my_command.key).to eql("N")
    end
  end

  describe "#number_of_arguments" do
    it "should have a specif number of arguments" do
      my_command.number_of_arguments = 5
      expect(my_command.number_of_arguments).to eql(5)
    end
  end

  describe "#block" do
    it "should define a block" do
      my_command.block = lambda { |image, args| true }
      expect(my_command.block.call(:image, :args)).to be_true

    end

    it "should be called by transform" do
        my_command.block = lambda { |image, args| true }
        my_command.block.should_receive(:call).with(:image, :arg0, :arg1)
        my_command.transform(:image, :arg0, :arg1)
    end
  end

  describe "#argument_types" do
    it "should respond to argument_types" do
      new_command = Class.new(SimpleImageEditor::Command)
      expect(new_command).to respond_to :argument_types
    end
  end

end
