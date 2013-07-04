require "spec_helper"

describe SimpleImageEditor::Editor do
  before(:each) do
    Kernel.stub(:print).and_return("")
    Kernel.stub(:puts).and_return("")
  end

  describe "when started" do
    it "should show the propmt '> '" do
      Kernel.stub(:gets).and_return("X\n")
      Kernel.should_receive(:print).with("> ")
      editor = SimpleImageEditor::Editor.new
    end
  end

  describe "user commands" do
    after(:each) do
      Kernel.should_receive(:puts).with("Session terminated").ordered
      editor = SimpleImageEditor::Editor.new
    end

    it "should terminate the session with X" do
      Kernel.stub(:gets).and_return("X\n")
      # Find the assertion in the after-each block.
    end

    it "should show the contents of the current image with S" do
      Kernel.stub(:gets).and_return("S\n", "X\n")
      Kernel.should_receive(:puts).with("=>\n\n").ordered
    end

    it "should creates a new image with I" do
      Kernel.stub(:gets).and_return("I 3 3\n","S\n", "X\n")
      Kernel.should_receive(:puts).with("=>\nOOO\nOOO\nOOO\n\n").ordered
    end

    it "should colours a pixel with L" do
      Kernel.stub(:gets).and_return("I 3 3\n", "L 1 1 X\n", "S\n", "X\n")
      Kernel.should_receive(:puts).with("=>\nXOO\nOOO\nOOO\n\n").ordered
    end

    it "should clear the table with C" do
      Kernel.stub(:gets).and_return("I 3 3\n", "L 1 1 X\n", "C\n", "S\n", "X\n")
      Kernel.should_receive(:puts).with("=>\nOOO\nOOO\nOOO\n\n").ordered
    end

    it "should draw a vertical line with V" do
      Kernel.stub(:gets).and_return("I 3 3\n", "V 1 1 3 X\n", "S\n", "X\n")
      Kernel.should_receive(:puts).with("=>\nXOO\nXOO\nXOO\n\n").ordered
    end

    it "should draw a horizontal line with H" do
      Kernel.stub(:gets).and_return("I 3 3\n", "H 1 3 3 X\n", "S\n", "X\n")
      Kernel.should_receive(:puts).with("=>\nOOO\nOOO\nXXX\n\n").ordered
    end

    it "should fill a region with colour with F" do
      Kernel.stub(:gets).and_return("I 3 3\n", "H 1 3 2 A\n", "V 2 2 3 A\n", "F 2 2 X","S\n", "X\n")
      Kernel.should_receive(:puts).with("=>\nOOO\nXXX\nOXO\n\n").ordered
    end

    it "should draw a border around region with colour with B" do
      Kernel.stub(:gets).and_return("I 3 3\n", "H 1 3 2 A\n", "V 2 2 3 A\n", "B 2 2 X","S\n", "X\n")
      Kernel.should_receive(:puts).with("=>\nXXX\nAAA\nXAX\n\n").ordered
    end

    it "should show the prompt '> ' after Enter" do
      Kernel.stub(:gets).and_return("\n","X\n")
      Kernel.should_receive(:print).with("> ").twice
    end
  end
end
