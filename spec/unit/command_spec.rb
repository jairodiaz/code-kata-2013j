require 'spec_helper'

describe SimpleImageEditor::Command do
  let(:my_command) { SimpleImageEditor::Command.new [], lambda{} }

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

  describe "#number_of_arguments" do
    it "should respond to number_of_arguments" do
      expect(my_command).to respond_to :number_of_arguments
    end
  end

  describe "#argument_types" do
    it "should respond to argument_types" do
      expect(my_command).to respond_to :argument_types
    end
  end

end
