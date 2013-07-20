require 'spec_helper'

describe SimpleImageEditor::CommandSet do
  let(:image) { double('image') }
  let(:command_set) { SimpleImageEditor::CommandSet.new image}

  it { command_set.should respond_to :commands}

  describe "#command" do
    it 'should add a command to the list' do
      command_set.add_command "Q"
      expect(command_set.commands["Q"]).to be_an_instance_of SimpleImageEditor::Command
    end

    it 'should add a block to the command' do
      block = lambda { |image, args| true }
      command_set.add_command "Q", &block
      expect(command_set.commands["Q"].transform(nil,nil)).to be_true
    end

    it 'should add a number_of_arguments to the command' do
      command_set.add_command "Q", [Integer, String]
      expect(command_set.commands["Q"].number_of_arguments).to eq(2)
    end

    it 'should add argument_types to the command' do
      command_set.add_command "Q", [Integer, String]
      expect(command_set.commands["Q"].argument_types).to eq([Integer, String])
    end
  end

  describe "#execute" do
    context 'when the command is defined' do

      context 'when there is not arguments' do
        it "should return true" do
          command_set.add_command "A" do
            true
          end
          expect(command_set.execute("A")).to eql(true)
        end
      end

      context 'when there is a specific number of arguments' do

        context 'when the command line has exactly the required number of arguments' do
          it "should return true" do
            command_set.add_command "B", [Integer, Integer] do
              true
            end
            expect(command_set.execute("B 1 1")).to eql(true)
          end
        end

        context 'when the command line DOES NOT have the required number of arguments' do
          it "should return the image" do
            command_set.add_command "C", [Integer, Integer] do
              # Never called
            end
            expect(command_set.execute("C 1")).to equal(image)
          end
        end
      end

    end

    context 'when the command is not defined' do
      it "should return the image" do
        expect(command_set.execute("?")).to equal(image)
      end
    end

    context 'argument validation' do
      context "when the argument format is valid" do
        it "should return true" do
          command_set.add_command "D", [Integer, Integer] do
            true
          end
          expect(command_set.execute("D 1 2")).to equal(true)
        end
      end

      context "when the argument format is invalid" do
        it "should return the image" do
          command_set.add_command "E", [String, String] do
            # Never called
          end
          expect(command_set.execute("E 0 0")).to equal(image)
        end
      end
    end
  end
end
