require 'spec_helper'

describe SimpleImageEditor::Command do
  let(:my_command) { SimpleImageEditor::Command.new [], lambda{} }

  subject { my_command }

  it { should respond_to :number_of_arguments }
  it { should respond_to :argument_types }
  it { should respond_to :transform }

  describe "#transform" do
    it "should call the block" do
      block = lambda { |image, args| true }
      block.should_receive(:call).with(:image, :arg0, :arg1)
      my_command = SimpleImageEditor::Command.new [], block
      my_command.transform(:image, :arg0, :arg1)
    end
  end

end
