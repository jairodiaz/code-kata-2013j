require 'spec_helper'

describe SimpleImageEditor::CommandSet do
  before (:all) do
    @command_runner = SimpleImageEditor::CommandSet.new
  end

  describe "#command" do
    it 'should add a command to the list' do
      @command_runner.add_command "Q"
      expect(@command_runner.commands.last.key).to eq("Q")
    end

    it 'should add a block to the command' do
      block = lambda { true }
      @command_runner.add_command "Q", &block
      expect(@command_runner.commands.last.block).to eql(block)
    end

    it 'should add a number_of_arguments to the command' do
      @command_runner.add_command "Q", [Integer, String]
      expect(@command_runner.commands.last.number_of_arguments).to eq(2)
    end

    it 'should add argument_types to the command' do
      @command_runner.add_command "Q", [Integer, String]
      expect(@command_runner.commands.last.argument_types).to eq([Integer, String])
    end
  end

  describe "#apply_on" do
    let(:image) { double('image') }

    context 'when the command is defined and requested on the command line' do

      context 'when there is not arguments' do
        it "should return true" do
          @command_runner.add_command "A" do
            true
          end
          expect(@command_runner.apply_on(image, "A")).to eql(true)
        end
      end

      context 'when there is a specific number of arguments' do

        context 'when the command line has exactly the required number of arguments' do
          it "should return true" do
            @command_runner.add_command "B", [Integer, Integer] do
              true
            end
            expect(@command_runner.apply_on(image, "B 1 1")).to eql(true)
          end
        end

        context 'when the command line DOES NOT have the required number of arguments' do
          it "should return the image" do
            @command_runner.add_command "C", [Integer, Integer] do
              # Never called
            end
            expect(@command_runner.apply_on(image, "C 1")).to equal(image)
          end
        end
      end

    end

    context 'when the command is not defined' do
      it "should return the image" do
        expect(@command_runner.apply_on(image, "?")).to equal(image)
      end
    end

    context 'argument validation' do
      context "when the argument format is valid" do
        it "should return true" do
          @command_runner.add_command "D", [Integer, Integer] do
            true
          end
          expect(@command_runner.apply_on(image, "D 1 2")).to equal(true)
        end
      end

      context "when the argument format is invalid" do
        it "should return the image" do
          @command_runner.add_command "E", [String, String] do
            # Never called
          end
          expect(@command_runner.apply_on(image, "E 0 0")).to equal(image)
        end
      end
    end
  end
end
