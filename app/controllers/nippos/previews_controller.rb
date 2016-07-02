# frozen_string_literal: true
class Nippos::PreviewsController < PrivateController
  include NippoHandleable

  def create
    if @nippo.valid?
      render 'nippos/preview'
    else
      flash.now[:alert] = @nippo.errors.full_messages
      render 'nippos/new'
    end
  end

  def update
    @nippo.attributes = nippo_update_params
    if @nippo.valid?
      render 'nippos/preview'
    else
      flash.now[:alert] = @nippo.errors.full_messages
      render 'nippos/show'
    end
  end
end
