require 'spec_helper'

describe SimpleImageEditor::CommandValidations do

 class TestClass; end;
 let(:test_class) { TestClass.new.extend SimpleImageEditor::CommandValidations }

 describe "#validates_numericality_of" do
    context "when value is between 1 and 250" do
      it "should return true" do
        (1..250).each { |x| expect(test_class.validates_numericality_of(x)).to be_true }
      end
    end

    context "when there are multiple arguments with correct values" do
      it "should return true" do
        expect(test_class.validates_numericality_of(3, 4)).to be_true
      end
    end

    context "when there is an incorrec value" do
      it "should return false" do
        expect(test_class.validates_numericality_of(3, 0)).to be_false
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
    let (:new_command) { Class.new(SimpleImageEditor::Command) }
    it "should check Integer arguments" do
      new_command.argument_types = [Integer]
      expect(new_command.validates_format_for(["3"])).to be_true
    end

    it "should check String arguments" do
      new_command.argument_types = [String]
      expect(new_command.validates_format_for(["C"])).to be_true
    end

    it "should check String and Integer arguments" do
      new_command.argument_types = [Integer, Integer, String]
      expect(new_command.validates_format_for(["1", "1", "C"])).to be_true
    end

    it "should check String and Integer arguments" do
      new_command.argument_types = [Integer, Integer, String]
      expect(new_command.validates_format_for(["1", "1", "0"])).to be_false
    end

    it "should return true if argument_types is not defined" do
      new_command.argument_types = nil
      expect(new_command.validates_format_for(["1", "1"])).to be_true
    end
  end
end
