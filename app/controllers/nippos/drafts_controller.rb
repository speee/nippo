# frozen_string_literal: true
class Nippos::DraftsController < PrivateController
  include NippoHandleable

  def create
    if @nippo.save
      flash[:notice] = '日報を下書き保存しました'
      redirect_to nippo_path(@nippo)
    else
      flash.now[:alert] = @nippo.errors.full_messages
      render 'nippos/new'
    end
  end

  def update
    if update_nippo
      flash[:notice] = '日報を下書き保存しました'
      redirect_to nippo_path(@nippo)
    else
      flash.now[:alert] = @nippo.errors.full_messages
      render 'nippos/show'
    end
  end
end
