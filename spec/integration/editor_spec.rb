require "spec_helper"

describe SimpleImageEditor::Editor do
  before(:each) do
    Kernel.stub(:print).and_return("")
    Kernel.stub(:puts).and_return("")
  end

  describe "starts" do
    it "displays '> ' when started" do
      Kernel.stub(:gets).and_return("X\n")
      Kernel.should_receive(:print).with("> ")
      editor = SimpleImageEditor::Editor.new
    end
  end

  describe "commands" do
    after(:each) do
      Kernel.should_receive(:puts).with("Session terminated").ordered
      editor = SimpleImageEditor::Editor.new
    end

    it "X - terminates session" do
      Kernel.stub(:gets).and_return("X\n")
    end

    it "S - shows the contents of the current image" do
      Kernel.stub(:gets).and_return("S\n", "X\n")
      Kernel.should_receive(:puts).with("=>\n\n").ordered
    end

    it "I - creates a new image" do
      Kernel.stub(:gets).and_return("I 3 3\n","S\n", "X\n")
      Kernel.should_receive(:puts).with("=>\nOOO\nOOO\nOOO\n\n").ordered
    end

    it "L - colours a pixel" do
      Kernel.stub(:gets).and_return("I 3 3\n", "L 1 1 X\n", "S\n", "X\n")
      Kernel.should_receive(:puts).with("=>\nXOO\nOOO\nOOO\n\n").ordered
    end

    it "C - clears the table" do
      Kernel.stub(:gets).and_return("I 3 3\n", "L 1 1 X\n", "C\n", "S\n", "X\n")
      Kernel.should_receive(:puts).with("=>\nOOO\nOOO\nOOO\n\n").ordered
    end

    it "V - draws a vertical line" do
      Kernel.stub(:gets).and_return("I 3 3\n", "V 1 1 3 X\n", "S\n", "X\n")
      Kernel.should_receive(:puts).with("=>\nXOO\nXOO\nXOO\n\n").ordered
    end

    it "H - draws a horizontal line" do
      Kernel.stub(:gets).and_return("I 3 3\n", "H 1 3 3 X\n", "S\n", "X\n")
      Kernel.should_receive(:puts).with("=>\nOOO\nOOO\nXXX\n\n").ordered
    end

    it "F - fills a region with colour" do
      Kernel.stub(:gets).and_return("I 3 3\n", "H 1 3 2 A\n", "V 2 2 3 A\n", "F 2 2 X","S\n", "X\n")
      Kernel.should_receive(:puts).with("=>\nOOO\nXXX\nOXO\n\n").ordered
    end

    it "B - draw a border around region with colour" do
      Kernel.stub(:gets).and_return("I 3 3\n", "H 1 3 2 A\n", "V 2 2 3 A\n", "B 2 2 X","S\n", "X\n")
      Kernel.should_receive(:puts).with("=>\nXXX\nAAA\nXAX\n\n").ordered
    end

    it "[ENTER KEY] - shows '> ' for next command" do
      Kernel.stub(:gets).and_return("\n","X\n")
      Kernel.should_receive(:print).with("> ").twice
    end
  end
end
