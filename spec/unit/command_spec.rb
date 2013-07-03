require 'spec_helper'

describe SimpleImageEditor::Command do

  COMMAND_ID = '-'
  class MySubclassCommand < SimpleImageEditor::Command
    define_key COMMAND_ID
    def transform(image=nil,args=nil)
      true
    end
  end

	describe "#list_of_classes" do
    it "returns a command subclass" do
      expect(SimpleImageEditor::Command.list_of_classes).to include(MySubclassCommand)
    end
  end

  describe "#id" do
    it "has a command id" do
      expect(MySubclassCommand.id).to eql(COMMAND_ID)
    end
  end

  describe "#arguments" do
    it "has a number of arguments" do
      stub_const("ARGUMENTS", 5)
      class MySubclassCommandWithArgs < SimpleImageEditor::Command; number_of_arguments ARGUMENTS; end
      expect(MySubclassCommandWithArgs.total_of_arguments).to eql(ARGUMENTS)
    end

    it "has a default number of zero arguments" do
      class MySubclassCommandWithNoArgs < SimpleImageEditor::Command; end
      expect(MySubclassCommandWithNoArgs.total_of_arguments).to eql(0)
    end
  end
end
