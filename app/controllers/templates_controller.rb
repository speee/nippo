# frozen_string_literal: true
class TemplatesController < PrivateController
  def show
    @template = current_user.template
  end
end
