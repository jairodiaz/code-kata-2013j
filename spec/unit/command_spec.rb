require 'spec_helper'

describe SimpleImageEditor::Command do
  let(:my_command) { SimpleImageEditor::Command.new([], lambda{}) }

  subject { my_command }

  it { should respond_to :number_of_arguments }
  it { should respond_to :argument_types }
  it { should respond_to :transform }

  it { should respond_to :valid_format? }

  describe "#transform" do
    it { expect { |b| SimpleImageEditor::Command.new([], lambda { |i, a| instance_eval &b })
         .transform(nil, nil) }.to yield_control }
  end
end
