# frozen_string_literal: true
class SubmitNameConstraint
  include Virtus.model

  attribute :name, Symbol

  def matches?(request)
    request.params[name]
  end
end
