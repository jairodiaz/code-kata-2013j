require 'spec_helper'

describe SimpleImageEditor::Command do
  let(:my_command) { Class.new(SimpleImageEditor::Command) }

  describe "#define_key" do
    it "should define a key" do
      my_command.define_key "N"
      expect(my_command.key).to eql("N")
    end
  end

  describe "#number_of_arguments" do
    it "have a default number of zero arguments" do
      new_command = Class.new(SimpleImageEditor::Command)
      expect(new_command.total_of_arguments).to eql(0)
    end

    it "should have a specif number of arguments" do
      my_command.number_of_arguments 5
      expect(my_command.total_of_arguments).to eql(5)
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

  describe "#validates_format_for" do
    it "should check Integer arguments" do
      new_command = Class.new(SimpleImageEditor::Command)
      new_command.argument_types = [Integer]
      expect(new_command.new.validates_format_for(["3"])).to be_true
    end

    it "should check String arguments" do
      new_command = Class.new(SimpleImageEditor::Command)
      new_command.argument_types = [String]
      expect(new_command.new.validates_format_for(["C"])).to be_true
    end

    it "should check String and Integer arguments" do
      new_command = Class.new(SimpleImageEditor::Command)
      new_command.argument_types = [Integer, Integer, String]
      expect(new_command.new.validates_format_for(["1", "1", "C"])).to be_true
    end

    it "should check String and Integer arguments" do
      new_command = Class.new(SimpleImageEditor::Command)
      new_command.argument_types = [Integer, Integer, String]
      expect(new_command.new.validates_format_for(["1", "1", "0"])).to be_false
    end

    it "should return true if argument_types is not defined" do
      new_command = Class.new(SimpleImageEditor::Command)
      new_command.argument_types = nil
      expect(new_command.new.validates_format_for(["1", "1"])).to be_true
    end
  end
end
