require 'spec_helper'

describe SimpleImageEditor::CommandRunner do
  before (:all) do
    @command_runner = SimpleImageEditor::CommandRunner.new
  end

  describe "#command" do
    it 'should add a command to the list' do
      @command_runner.command ">"
      expect(@command_runner.commands.last.key).to eq(">")
    end

    it 'should add a block to the command' do
      block = lambda { true }
      @command_runner.command ">", &block
      expect(@command_runner.commands.last.block).to eql(block)
    end

    it 'should add a number_of_arguments to the command' do
      @command_runner.command ">", [Integer, String]
      expect(@command_runner.commands.last.total_of_arguments).to eq(2)
    end

    it 'should add argument_types to the command' do
      @command_runner.command ">", [Integer, String]
      expect(@command_runner.commands.last.argument_types).to eq([Integer, String])
    end
  end

  describe "#add_command" do
    it 'should add a command to the list' do
      command = Class.new(SimpleImageEditor::Command) do
        define_key '<'
      end
      @command_runner.add_command command
      expect(@command_runner.commands.last.key).to eq("<")
    end
  end

  describe "#apply_on" do
    let(:image) { double('image') }

    context 'when the command is defined and requested on the command line' do

      context 'when there is not arguments' do
        it "should return true" do
          stub_const("COMMAND_ID", "-")
          @command_runner.command "#{COMMAND_ID}" do
            true
          end
          command_line = "#{COMMAND_ID}"
          expect(@command_runner.apply_on(image, command_line)).to eql(true)
        end
      end

      context 'when there is a specific number of arguments' do

        context 'when the command line has exactly the required number of arguments' do
          it "should return true" do

            stub_const("COMMAND_WITH_ARGS_ID", ":")
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

            stub_const("COMMAND_WITH_ARGS_ID", "]")
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

    context 'when the command is not defined' do
      it "should return the image" do
        define_invalid_key = "."
        command_line = "#{define_invalid_key} some other text"
        expect(@command_runner.apply_on(image, command_line)).to equal(image)
      end
    end

    context 'when method validates_format_for is present' do
      context "when the argument format is valid" do
        it "should return true" do
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
        it "should return the image" do
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
