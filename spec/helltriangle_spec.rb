require "spec_helper"

describe Helltriangle do
  it "has a version number" do
    expect(Helltriangle::VERSION).not_to be nil
  end

  context "init method" do
    it "call method" do
      expect{ Helltriangle::init(nil) }.not_to raise_error
    end

    it "call method and send provider instance" do
      Helltriangle::init(Helltriangle::Calculator::Client.new(Helltriangle::Calculator::Providers::EvandroProvider.new))
      expect(Helltriangle._calculator_provider).not_to be_nil
    end
  end
  context "execute method" do
    before :each do
      provider = Helltriangle::Calculator::Client.new(Helltriangle::Calculator::Providers::EvandroProvider.new)
      Helltriangle::init(provider)
    end

    it "and triangle is null" do
      expect{ Helltriangle::execute(nil) }.to raise_error(ArgumentError, "triangle is not defined")
    end

    it "and triangle is not Array" do
      expect{ Helltriangle::execute(0) }.to raise_error(ArgumentError, "triangle must be Array")
    end

    it "and triangle Array contains 1 dimension " do
      expect{ Helltriangle::execute([1])  }.to raise_error(ArgumentError, "triangle need to have two or more dimensions")
    end

    it "and array is not triangle " do
      expect{ Helltriangle::execute([[1],[1]])  }.to raise_error(ArgumentError, "array is not triangle")
    end

    it "and triangle Array contains 2 dimension " do
      result = Helltriangle::execute([[1],[2,3]])
      expect(result[:sum]).to eq(4)
    end

    it "and triangle Array contains 4 dimension " do
      result = Helltriangle::execute( [[6],[3,5],[9,7,1],[4,6,8,4]])
      expect(result[:sum]).to eq(26)
    end

    it "and triangle Array contains 4 dimension " do
      result = Helltriangle::execute( [[6],[3,5],[9,7,1],[4,6,8,4],[4,6,8,4,9],[4,6,8,4,5,7],[4,6,8,4,3,5,8]])
      expect(result[:sum]).to eq(50)
    end
  end
end
