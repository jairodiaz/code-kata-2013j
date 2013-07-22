require "spec_helper"

describe SimpleImageEditor::Editor do
  let(:std_input) { double('std_input') }
  let(:std_output) { double('std_output') }
  before(:each) do
    std_output.stub(:print).and_return("")
    std_output.stub(:puts).and_return("")
  end

  describe "when started" do
    it "should show the propmt '> '" do
      std_input.stub(:gets).and_return("X\n")
      std_output.should_receive(:print).with("> ")
      SimpleImageEditor::Editor.new std_input, std_output
    end
  end

  describe "user commands" do
    after(:each) do
      std_output.should_receive(:puts).with("Session terminated").ordered
      SimpleImageEditor::Editor.new std_input, std_output
    end

    it "should terminate the session with X" do
      std_input.stub(:gets).and_return("X\n")
      # Find the assertion in the after-each block.
    end

    it "should show the contents of the current image with S" do
      std_input.stub(:gets).and_return("S\n", "X\n")
      std_output.should_receive(:puts).with("=>\n\n").ordered
    end

    it "should create a new image with I" do
      std_input.stub(:gets).and_return("I 3 3\n","S\n", "X\n")
      std_output.should_receive(:puts).with("=>\nOOO\n
                                                 OOO\n
                                                 OOO\n\n").ordered
    end

    it "should colour a pixel with L" do
      std_input.stub(:gets).and_return("I 3 3\n", "L 1 1 X\n", "S\n", "X\n")
      std_output.should_receive(:puts).with("=>\nXOO\n
                                                 OOO\n
                                                 OOO\n\n").ordered
    end

    it "should clear the table with C" do
      std_input.stub(:gets).and_return("I 3 3\n", "L 1 1 X\n", "C\n", "S\n", "X\n")
      std_output.should_receive(:puts).with("=>\nOOO
                                               \nOOO\n
                                                 OOO\n\n").ordered
    end

    it "should draw a vertical line with V" do
      std_input.stub(:gets).and_return("I 3 3\n", "V 1 1 3 X\n", "S\n", "X\n")
      std_output.should_receive(:puts).with("=>\nXOO\n
                                                 XOO\n
                                                 XOO\n\n").ordered
    end

    it "should draw a horizontal line with H" do
      std_input.stub(:gets).and_return("I 3 3\n", "H 1 3 3 X\n", "S\n", "X\n")
      std_output.should_receive(:puts).with("=>\nOOO
                                               \nOOO\n
                                                 XXX\n\n").ordered
    end

    it "should fill a region with colour with F" do
      std_input.stub(:gets).and_return("I 3 3\n", "H 1 3 2 A\n", "V 2 2 3 A\n", "F 2 2 X","S\n", "X\n")
      std_output.should_receive(:puts).with("=>\nOOO
                                               \nXXX
                                                \nOXO\n\n").ordered
    end

    it "should draw a border around region with colour with B" do
      std_input.stub(:gets).and_return("I 3 3\n", "H 1 3 2 A\n", "V 2 2 3 A\n", "B 2 2 X","S\n", "X\n")
      std_output.should_receive(:puts).with("=>\nXXX
                                               \nAAA
                                               \nXAX\n\n").ordered
    end

    it "should show the prompt '> ' after Enter" do
      std_input.stub(:gets).and_return("\n","X\n")
      std_output.should_receive(:print).with("> ").twice
    end
  end
end
