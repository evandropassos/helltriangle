class Helltriangle::Calculator::Providers::GreaterPositionProvider
  attr_accessor :_triangle, :_route, :_dimensions

  def execute(triangle)
    _init(triangle)
    _isTriangle?


    analyze_dimension(0, nil)

    {
      elements: self._route,
      sum: self._route.inject(:+)
    }

  end

  def analyze_dimension(dimension, index)
    if dimension < self._dimensions
      greater_position = find_greater_position(dimension, index)
      _route << self._triangle[dimension][greater_position]
      analyze_dimension(dimension + 1, greater_position)
    end

  end

  def find_greater_position(dimension, index)
    if index.nil?
      return self._triangle[dimension].index(self._triangle[dimension].max)
    end

    if (self._triangle[dimension][index] > self._triangle[dimension][index + 1])
      return index
    end


    return index + 1
  end

  private
  def _init(triangle)
    self._triangle = triangle
    self._route = []
    self._dimensions = self._triangle.length
  end

  def _isTriangle?
    if self._dimensions <= 1
      raise ArgumentError, "triangle need to have two or more dimensions"
    end

    after_dimension = nil
    for dimension in 0...self._dimensions
      if not after_dimension.nil?
        if after_dimension >= self._triangle[dimension].length
            raise ArgumentError, "array is not triangle"
        end
      end
      after_dimension = self._triangle[dimension].length
    end
  end
end
