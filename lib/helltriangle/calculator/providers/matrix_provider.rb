class Helltriangle::Calculator::Providers::MatrixProvider
  attr_accessor :_triangle, :_dimensions

  def execute(triangle)
    _init(triangle)
    _isTriangle?

    sum = self._triangle[0][0]
    near_left = analyze_dimension(sum, 1, 0)
    near_right = analyze_dimension(sum, 1, 1)

    {
      sum: [near_left, near_right].max
    }

  end

  def analyze_dimension(sum, dimension, position)
    if dimension >= self._dimensions || position >= self._triangle[dimension].length
      return sum
    end

    number = self._triangle[dimension][position]

    near_left = analyze_dimension(sum + number, dimension + 1, position)
    near_right = analyze_dimension(sum + number, dimension + 1, position + 1)

    [near_left, near_right].max
  end

  private
  def _init(triangle)
    self._triangle = triangle
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
