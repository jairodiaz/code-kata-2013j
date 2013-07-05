require 'spec_helper'

describe SimpleImageEditor::CommandValidatable do

  let(:test_class) do
    Class.new do
      extend SimpleImageEditor::CommandValidatable
    end
  end

  describe "#validates_numericality_of" do
    context "when value is between 1 and 250" do
      it "should return true" do
        (1..250).each { |x| expect(test_class.validates_numericality_of(x)).to be_true }
      end
    end
    context "when value is 0" do
      it "should return false" do
        expect(test_class.validates_numericality_of(0)).to be_false
      end
    end
    context "when value is 251" do
      it "should return false" do
        expect(test_class.validates_numericality_of(251)).to be_false
      end
    end
  end

  describe "#validates_color_for" do
    context "when value is a uppercase character" do
      it "should return true" do
        ('A'..'Z').each { |x| expect(test_class.validates_color_for(x)).to be_true }
      end
    end

    context "when value is a digit" do
      it "should return false" do
        ('0'..'9').each { |x| expect(test_class.validates_color_for(x)).to be_false }
      end
    end
  end

 describe "#validates_format_for" do
    let (:new_command) do
      Class.new do
        include SimpleImageEditor::CommandValidatable
        attr_accessor :argument_types
      end.new
    end

    context "when argument match the expected type" do
      it "should be true for an Integer argument" do
        new_command.argument_types = [Integer]
        expect(new_command.validates_format_for(["3"])).to be_true
      end

      it "should be true for a String argument" do
        new_command.argument_types = [String]
        expect(new_command.validates_format_for(["C"])).to be_true
      end

      it "should be true for multiple Integer and String arguments" do
        new_command.argument_types = [Integer, Integer, String]
        expect(new_command.validates_format_for(["1", "1", "C"])).to be_true
      end
    end

    context "when the arguments does not match the expected type" do
      it "should be false when expecting a String but gets an Integer argument" do
        new_command.argument_types = [Integer, Integer, String]
        expect(new_command.validates_format_for(["1", "1", "0"])).to be_false
      end
    end

    context "when argument_types is not defined" do
      it "should return true" do
        new_command.argument_types = nil
        expect(new_command.validates_format_for(["1", "1"])).to be_true
      end
    end
  end
end
