# frozen_string_literal: true
class SubmitNameConstraint
  attr_reader :name

  def initialize(name)
    @name = name.to_sym
  end

  def matches?(request)
    request.params[name]
  end
end
