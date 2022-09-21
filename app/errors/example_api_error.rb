class ExampleApiError < StandardError
  attr_reader :meta

  def initialize(meta: {})
    @meta = meta
  end

  def serialize
    errors = instance_variables.each_with_object({}) do |exceptions, var|
      exceptions[var.to_s.gsub(/@/, '')] = instance_variable_get(var)
      exceptions
    end

    { errors: errors }
  end
end
