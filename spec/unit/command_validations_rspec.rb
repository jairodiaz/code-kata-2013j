require 'spec_helper'

describe SimpleImageEditor::CommandValidations do

 describe "#validates_numericality_of" do
    context "when value is between 1 and 250" do
      it "returns true" do
        (1..250).each { |x| expect(validates_numericality_of(x)).to be_true }
      end
    end

    context "when there are multiple arguments with correct values" do
      it "returns true" do
        expect(validates_numericality_of(3, 4)).to be_true
      end
    end

    context "when there is an incorrec value" do
      it "returns false" do
        expect(validates_numericality_of(3, 0)).to be_false
      end
    end
  end

  describe "#validates_color_for" do
    context "when value is a uppercase character" do
      it "returns true" do
        ('A'..'Z').each { |x| expect(validates_color_for(x)).to be_true }
      end
    end

    context "when value is a digit" do
      it "returns false" do
        ('0'..'9').each { |x| expect(validates_color_for(x)).to be_false }
      end
    end
  end
end
