class Helltriangle::Calculator::Client
  def initialize(provider)
    @provider = provider
  end

  def execute(triangle)
    @provider.execute(triangle)
  end
end
