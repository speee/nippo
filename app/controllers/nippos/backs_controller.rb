# frozen_string_literal: true
class Nippos::BacksController < PrivateController
  include NippoHandleable

  def create
    render 'nippos/new'
  end

  def update
    @nippo.attributes = nippo_update_params
    render 'nippos/show'
  end
end
