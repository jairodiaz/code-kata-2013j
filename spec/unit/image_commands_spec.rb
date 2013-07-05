require 'spec_helper'

describe SimpleImageEditor::ImageCommands do

  describe '#apply_on' do
    let(:image) { double('image') }

    context "when calling the command 'clear'" do
      it "should call to clear on the image" do
        image.should_receive(:clear)
        SimpleImageEditor::ImageCommands.new.apply_on image, 'C'
      end
    end

    context "when calling the command 'exit'" do
      it "should return 'nil'" do
        expect(SimpleImageEditor::ImageCommands.new.apply_on image, 'X').to eql(nil)
      end
    end

    context "when calling the command 'show'" do
      it "should do nothing to an image" do
        image = SimpleImageEditor::Image.new(2, 3)
        Kernel.stub(:puts)
        expect(SimpleImageEditor::ImageCommands.new.apply_on image, 'S').to equal(image)
      end

      it "should display the image to the standard output" do
        image = SimpleImageEditor::Image.new(2, 2)
        Kernel.should_receive(:puts).with("=>\nOO\nOO\n\n")
        expect(SimpleImageEditor::ImageCommands.new.apply_on image, 'S').to equal(image)
      end
    end

    describe "When calling the command 'fill'" do
      it "should expect 3 arguments" do
       expect(SimpleImageEditor::ImageCommands.new.commands[3].total_of_arguments).to eql(3)
      end

      it "should call to fill region on the image" do
        image.should_receive(:fill_region).with(2, 4, "C")
        SimpleImageEditor::ImageCommands.new.apply_on image, 'F 2 4 C'
      end

      describe "#validates_format_for" do
        context "when the arguments are two numbers and a character" do
          it "should return true " do
            expect(SimpleImageEditor::ImageCommands.new.commands[3].new.validates_format_for ["1", "1", "C"]).to be_true
          end
        end

        context "when the arguments are NOT three numbers and a character" do
          it "should return false" do
            expect(SimpleImageEditor::ImageCommands.new.commands[3].new.validates_format_for ["C", "3", "C"]).to be_false
            expect(SimpleImageEditor::ImageCommands.new.commands[3].new.validates_format_for ["1", "3", "0"]).to be_false
          end
        end
      end
    end

    describe "When calling the command 'draw border'" do
      it "should expect 3 arguments" do
       expect(SimpleImageEditor::ImageCommands.new.commands[4].total_of_arguments).to eql(3)
      end

      it "should call to draw a border around a region" do
        image.should_receive(:draw_border).with(2, 4, "C")
        SimpleImageEditor::ImageCommands.new.apply_on image, 'B 2 4 C'
      end

      describe "#validates_format_for" do
        context "when the arguments are two numbers and a character" do
          it "should return true " do
            expect(SimpleImageEditor::ImageCommands.new.commands[4].new.validates_format_for ["1", "1", "C"]).to be_true
          end
        end

        context "when the arguments are NOT three numbers and a character" do
          it "should return false" do
            expect(SimpleImageEditor::ImageCommands.new.commands[4].new.validates_format_for ["C", "3", "C"]).to be_false
            expect(SimpleImageEditor::ImageCommands.new.commands[4].new.validates_format_for ["1", "3", "0"]).to be_false
          end
        end
      end
    end

    describe "When calling the command 'horizontal line'" do
      it "should expect 4 arguments" do
       expect(SimpleImageEditor::ImageCommands.new.commands[5].total_of_arguments).to eql(4)
      end

      it "should call to draw a horizontal line" do
        image.should_receive(:horizontal).with(3, 2, 4, "C")
        SimpleImageEditor::ImageCommands.new.apply_on image, 'H 3 2 4 C'
      end

      describe "#validates_format_for" do
        context "when the arguments are three numbers and a character" do
          it "should return true " do
            expect(SimpleImageEditor::ImageCommands.new.commands[5].new.validates_format_for ["1", "1", "1", "C"]).to be_true
          end
        end

        context "when the arguments are NOT three numbers and a character" do
          it "should return false" do
            expect(SimpleImageEditor::ImageCommands.new.commands[5].new.validates_format_for ["C", "3", "1", "C"]).to be_false
            expect(SimpleImageEditor::ImageCommands.new.commands[5].new.validates_format_for ["1", "3", "1", "0"]).to be_false
          end
        end
      end
    end

   describe "When calling the command 'vertical line'" do
      it "should expect 4 arguments" do
       expect(SimpleImageEditor::ImageCommands.new.commands[6].total_of_arguments).to eql(4)
      end

      it "should call to draw a vertical line" do
        image.should_receive(:vertical).with(3, 2, 4, "C")
        SimpleImageEditor::ImageCommands.new.apply_on image, 'V 3 2 4 C'
      end

      describe "#validates_format_for" do
        context "when the arguments are three numbers and a character" do
          it "should return true " do
            expect(SimpleImageEditor::ImageCommands.new.commands[6].new.validates_format_for ["1", "1", "1", "C"]).to be_true
          end
        end

        context "when the arguments are NOT three numbers and a character" do
          it "should return false" do
            expect(SimpleImageEditor::ImageCommands.new.commands[6].new.validates_format_for ["C", "3", "1", "C"]).to be_false
            expect(SimpleImageEditor::ImageCommands.new.commands[6].new.validates_format_for ["1", "3", "1", "0"]).to be_false
          end
        end
      end
    end

   describe "When calling the command 'new image'" do
      it "should expect 2 arguments" do
       expect(SimpleImageEditor::ImageCommands.new.commands[7].total_of_arguments).to eql(2)
      end

      it "should call to create new image" do
        SimpleImageEditor::Image.should_receive(:new).with(5, 3)
        SimpleImageEditor::ImageCommands.new.apply_on image, 'I 5 3'
      end

      describe "#validates_format_for" do
        context "when both arguments are numbers between 1 and 250" do
          it "should return true " do
            expect(SimpleImageEditor::ImageCommands.new.commands[7].new.validates_format_for ["5", "3"]).to be_true
          end
        end

        context "when one argument is NOT between 1 and 250" do
          it "should return false" do
            expect(SimpleImageEditor::ImageCommands.new.commands[7].new.validates_format_for ["0", "3"]).to be_false
            expect(SimpleImageEditor::ImageCommands.new.commands[7].new.validates_format_for ["251", "3"]).to be_false
          end
        end
      end
    end

    describe "When calling the command 'colour'" do
      it "should expect 3 arguments" do
       expect(SimpleImageEditor::ImageCommands.new.commands[8].total_of_arguments).to eql(3)
      end

      it "should call to colour on the image" do
        image.should_receive(:colour).with(1, 1, "C")
        SimpleImageEditor::ImageCommands.new.apply_on image, 'L 1 1 C'
      end

      describe "#validates_format_for" do
        context "when the arguments are two numbers and a character" do
          it "should return true " do
            expect(SimpleImageEditor::ImageCommands.new.commands[8].new.validates_format_for ["1", "1", "C"]).to be_true
          end
        end

        context "when the arguments are NOT three numbers and a character" do
          it "should return false" do
            expect(SimpleImageEditor::ImageCommands.new.commands[8].new.validates_format_for ["C", "3", "C"]).to be_false
            expect(SimpleImageEditor::ImageCommands.new.commands[8].new.validates_format_for ["1", "3", "0"]).to be_false
          end
        end
      end
    end

  end
end
