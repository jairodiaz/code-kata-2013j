require 'spec_helper'

describe SimpleImageEditor::CommandRunner do
  describe "#run" do
    let(:image) { double('image') }

    context 'when the command line has a command id which is defined by a command subclass' do

      context 'when there is not arguments' do
        COMMAND_ID = '-'
        class MySubclassCommand < SimpleImageEditor::Command
          define_key COMMAND_ID
          def transform(image=nil,args=nil)
            true
          end
        end

        it "should return true" do
          command_line = "#{COMMAND_ID}"
          expect(SimpleImageEditor::Command.run_for(image, command_line)).to eql(true)
        end
      end

      context 'when there is a specific number of arguments' do
        COMMAND_WITH_ARGS_ID = ":"
        class MySubclassCommandWithTwoArgs < SimpleImageEditor::Command
          define_key COMMAND_WITH_ARGS_ID
          number_of_arguments 2
          def transform(image=nil,args=nil)
            true
          end
        end

        context 'when the command line has exactly the required number of arguments' do
          it "should return true" do
            command_line = "#{COMMAND_WITH_ARGS_ID} arg1 arg2"
            expect(SimpleImageEditor::Command.run_for(image, command_line)).to eql(true)
          end
        end

        context 'when the command line DOES NOT have the required number of arguments' do
          it "should return the image" do
            command_line = "#{COMMAND_WITH_ARGS_ID} arg1"
            expect(SimpleImageEditor::Command.run_for(image, command_line)).to equal(image)
          end
        end
      end

    end

    context 'when the command line has a command id that it is not defined by a command subclass' do
      it "should return the image" do
        define_invalid_key = "."
        command_line = "#{define_invalid_key} some other text"
        expect(SimpleImageEditor::Command.run_for(image, command_line)).to equal(image)
      end
    end

    context 'when method validates_format_for is present' do
      context "when the argument format is valid" do
        COMMAND_WITH_VALIDATION_ID = ";"
        class MySubclassCommandWithValidation < SimpleImageEditor::Command
          define_key COMMAND_WITH_VALIDATION_ID
          number_of_arguments 2
          def transform(image=nil,args=nil)
            true
          end
        end

        it "returns true" do
          class MySubclassCommandWithValidation
            def validates_format_for(args=nil)
              true
            end
          end
          command_line = "#{COMMAND_WITH_VALIDATION_ID} 1 2"
          expect(SimpleImageEditor::Command.run_for(image, command_line)).to equal(true)
        end
      end

      context "when the argument format is invalid" do
        it "returns the image" do
          class MySubclassCommandWithValidation
            def validates_format_for(args=nil)
              false
            end
          end
          command_line = "#{COMMAND_WITH_VALIDATION_ID} 0 0"
          expect(SimpleImageEditor::Command.run_for(image, command_line)).to equal(image)
        end
      end
    end
  end
end
