require "helltriangle/version"
require "helltriangle/calculator/calculator"

module Helltriangle
  class << self
    attr_accessor :_calculator_provider
  end
  def self.init(calculator_provider)
    self._calculator_provider = calculator_provider
  end

  def self.execute(triangle)
    if self._calculator_provider.nil?
      raise ArgumentError, "calculator provider is not defined, call init method before."
    end

    if triangle.nil?
      raise ArgumentError, "triangle is not defined"
    end

    if not triangle.is_a? Array
      raise ArgumentError, "triangle must be Array"
    end

    self._calculator_provider.execute(triangle)
  end
end
