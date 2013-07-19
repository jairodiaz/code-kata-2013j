require 'spec_helper'

describe SimpleImageEditor::ImageCommands do

  describe '#execute' do
    let(:image) { double('image') }
    let(:image_commands) { SimpleImageEditor::ImageCommands.new image}

    context "when calling the command 'clear'" do
      it "should call to clear on the image" do
        image.should_receive(:clear)
        image_commands.execute 'C'
      end
    end

    context "when calling the command 'exit'" do
      it "should return 'nil'" do
        expect { image_commands.execute 'X'}.to throw_symbol(:exit)
      end
    end

    context "when calling the command 'show'" do
      let (:std_output) { double('std_output') }

      it "should do nothing to an image" do
        std_output.stub(:puts)
        image.stub(:to_a).and_return([])
        image_commands_with_output = SimpleImageEditor::ImageCommands.new(image, std_output)
        expect(image_commands_with_output.execute 'S').to equal(image)
      end

      it "should display the image to the standard output" do
        image = SimpleImageEditor::Image.new(2, 2)
        std_output.should_receive(:puts).with("=>\nOO\nOO\n\n")
        image_commands_with_output = SimpleImageEditor::ImageCommands.new(image, std_output)
        expect(image_commands_with_output.execute 'S').to equal(image)
      end
    end

    describe "When calling the command 'fill'" do
      it "should expect 3 arguments" do
       expect(image_commands.commands['F'].number_of_arguments).to eql(3)
      end

      it "should call to fill region on the image" do
        image.should_receive(:fill_region).with(2, 4, "C")
        image_commands.execute 'F 2 4 C'
      end

      describe "#valid_format?" do
        context "when the arguments are two numbers and a character" do
          it "should return true " do
            expect(image_commands.commands['F'].valid_format? ["1", "1", "C"]).to be_true
          end
        end

        context "when the arguments are NOT three numbers and a character" do
          it "should return false" do
            expect(image_commands.commands['F'].valid_format? ["C", "3", "C"]).to be_false
            expect(image_commands.commands['F'].valid_format? ["1", "3", "0"]).to be_false
          end
        end
      end
    end

    describe "When calling the command 'draw border'" do
      it "should expect 3 arguments" do
       expect(image_commands.commands['B'].number_of_arguments).to eql(3)
      end

      it "should call to draw a border around a region" do
        image.should_receive(:draw_border).with(2, 4, "C")
        image_commands.execute 'B 2 4 C'
      end

      describe "#valid_format?" do
        context "when the arguments are two numbers and a character" do
          it "should return true " do
            expect(image_commands.commands['B'].valid_format? ["1", "1", "C"]).to be_true
          end
        end

        context "when the arguments are NOT three numbers and a character" do
          it "should return false" do
            expect(image_commands.commands['B'].valid_format? ["C", "3", "C"]).to be_false
            expect(image_commands.commands['B'].valid_format? ["1", "3", "0"]).to be_false
          end
        end
      end
    end

    describe "When calling the command 'horizontal line'" do
      it "should expect 4 arguments" do
       expect(image_commands.commands['H'].number_of_arguments).to eql(4)
      end

      it "should call to draw a horizontal line" do
        image.should_receive(:horizontal).with(3, 2, 4, "C")
        image_commands.execute 'H 3 2 4 C'
      end

      describe "#valid_format?" do
        context "when the arguments are three numbers and a character" do
          it "should return true " do
            expect(image_commands.commands['H'].valid_format? ["1", "1", "1", "C"]).to be_true
          end
        end

        context "when the arguments are NOT three numbers and a character" do
          it "should return false" do
            expect(image_commands.commands['H'].valid_format? ["C", "3", "1", "C"]).to be_false
            expect(image_commands.commands['H'].valid_format? ["1", "3", "1", "0"]).to be_false
          end
        end
      end
    end

   describe "When calling the command 'vertical line'" do
      it "should expect 4 arguments" do
       expect(image_commands.commands['V'].number_of_arguments).to eql(4)
      end

      it "should call to draw a vertical line" do
        image.should_receive(:vertical).with(3, 2, 4, "C")
        image_commands.execute 'V 3 2 4 C'
      end

      describe "#valid_format?" do
        context "when the arguments are three numbers and a character" do
          it "should return true " do
            expect(image_commands.commands['V'].valid_format? ["1", "1", "1", "C"]).to be_true
          end
        end

        context "when the arguments are NOT three numbers and a character" do
          it "should return false" do
            expect(image_commands.commands['V'].valid_format? ["C", "3", "1", "C"]).to be_false
            expect(image_commands.commands['V'].valid_format? ["1", "3", "1", "0"]).to be_false
          end
        end
      end
    end

   describe "When calling the command 'new image'" do
      it "should expect 2 arguments" do
       expect(image_commands.commands['I'].number_of_arguments).to eql(2)
      end

      it "should call to create new image" do
        SimpleImageEditor::Image.should_receive(:new).with(5, 3)
        image_commands.execute 'I 5 3'
      end

      describe "#valid_format?" do
        context "when both arguments are numbers between 1 and 250" do
          it "should return true " do
            expect(image_commands.commands['I'].valid_format? ["5", "3"]).to be_true
          end
        end

        context "when one argument is NOT between 1 and 250" do
          it "should return false" do
            expect(image_commands.commands['I'].valid_format? ["0", "3"]).to be_false
            expect(image_commands.commands['I'].valid_format? ["251", "3"]).to be_false
          end
        end
      end
    end

    describe "When calling the command 'colour'" do
      it "should expect 3 arguments" do
       expect(image_commands.commands['L'].number_of_arguments).to eql(3)
      end

      it "should call to colour on the image" do
        image.should_receive(:colour).with(1, 1, "C")
        image_commands.execute 'L 1 1 C'
      end

      describe "#valid_format?" do
        context "when the arguments are two numbers and a character" do
          it "should return true " do
            expect(image_commands.commands['L'].valid_format? ["1", "1", "C"]).to be_true
          end
        end

        context "when the arguments are NOT three numbers and a character" do
          it "should return false" do
            expect(image_commands.commands['L'].valid_format? ["C", "3", "C"]).to be_false
            expect(image_commands.commands['L'].valid_format? ["1", "3", "0"]).to be_false
          end
        end
      end
    end

  end
end
