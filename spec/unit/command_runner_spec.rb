require 'spec_helper'

describe SimpleImageEditor::CommandRunner do
  before (:all) do
    @command_runner = SimpleImageEditor::CommandRunner.new
  end

  describe "#command" do
    it 'adds a command to the list' do
      @command_runner.command ">"
      expect(@command_runner.commands.last.key).to eq(">")
    end
  end

  describe "#add_command" do
    it 'adds a command to the list' do
      command = Class.new(SimpleImageEditor::Command) do
        define_key '<'
      end
      @command_runner.add_command command
      expect(@command_runner.commands.last.key).to eq("<")
    end
  end

  describe "#apply_on" do
    let(:image) { double('image') }

    context 'when the command line has a command id which is defined by a command subclass' do

      context 'when there is not arguments' do
        it "should return true" do
          stub_const("COMMAND_ID", "-")
          command = Class.new(SimpleImageEditor::Command) do
            define_key COMMAND_ID
            def transform(image=nil,args=nil)
              true
            end
          end

          @command_runner.add_command command
          command_line = "#{COMMAND_ID}"
          expect(@command_runner.apply_on(image, command_line)).to eql(true)
        end
      end

      context 'when there is a specific number of arguments' do

        context 'when the command line has exactly the required number of arguments' do
          it "should return true" do

            COMMAND_WITH_ARGS_ID = ":"
            command = Class.new(SimpleImageEditor::Command) do
              define_key COMMAND_WITH_ARGS_ID
              number_of_arguments 2
              def transform(image=nil,args=nil)
                true
              end
            end

            @command_runner.add_command command
            command_line = "#{COMMAND_WITH_ARGS_ID} arg1 arg2"
            expect(@command_runner.apply_on(image, command_line)).to eql(true)
          end
        end

        context 'when the command line DOES NOT have the required number of arguments' do
          it "should return the image" do

            COMMAND_WITH_ARGS_ID = ":"
            command = Class.new(SimpleImageEditor::Command) do
              define_key COMMAND_WITH_ARGS_ID
              number_of_arguments 2
              def transform(image=nil,args=nil)
                # Never called
              end
            end

            @command_runner.add_command command
            command_line = "#{COMMAND_WITH_ARGS_ID} arg1"
            expect(@command_runner.apply_on(image, command_line)).to equal(image)
          end
        end
      end

    end

    context 'when the command line has a command id that it is not defined by a command subclass' do
      it "should return the image" do
        define_invalid_key = "."
        command_line = "#{define_invalid_key} some other text"
        expect(@command_runner.apply_on(image, command_line)).to equal(image)
      end
    end

    context 'when method validates_format_for is present' do
      context "when the argument format is valid" do
        it "returns true" do
          stub_const("COMMAND_WITH_VALIDATION_ID", ";")
          command = Class.new(SimpleImageEditor::Command) do
            define_key COMMAND_WITH_VALIDATION_ID
            number_of_arguments 2
            def transform(image=nil,args=nil)
              true
            end
            def validates_format_for(args=nil)
              true
            end
          end

          @command_runner.add_command command
          command_line = "#{COMMAND_WITH_VALIDATION_ID} 1 2"
          expect(@command_runner.apply_on(image, command_line)).to equal(true)
        end
      end

      context "when the argument format is invalid" do
        it "returns the image" do
          stub_const("COMMAND_WITH_VALIDATION_ID", ",")
          command = Class.new(SimpleImageEditor::Command) do
            define_key COMMAND_WITH_VALIDATION_ID
            number_of_arguments 2
            def transform(image=nil,args=nil)
              # Never called
            end
            def validates_format_for(args=nil)
              false
            end
          end

          @command_runner.add_command command
          command_line = "#{COMMAND_WITH_VALIDATION_ID} 0 0"
          expect(@command_runner.apply_on(image, command_line)).to equal(image)
        end
      end
    end
  end
end
