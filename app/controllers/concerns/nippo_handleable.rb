# frozen_string_literal: true
module NippoHandleable
  extend ActiveSupport::Concern

  included do
    before_action :new_nippo,    only: %i(create)
    before_action :set_nippo,    only: %i(show update)
    before_action :check_status, only: %i(update)
  end

  private

  def new_nippo
    @nippo = Nippo.new(nippo_create_params)
  end

  def set_nippo
    @nippo = Nippo.find(params[:id])
  end

  def check_status
    return if @nippo.draft?

    flash[:alert] = 'この日報は送信済みです'
    redirect_to nippo_path(@nippo)
  end

  def update_nippo
    @nippo.with_lock do
      @nippo.update(nippo_update_params)
    end
  end

  def nippo_create_params
    params.require(:nippo).permit(:body, :reported_for).merge(
      user: current_user,
      subject: current_user.template.subject,
    )
  end

  def nippo_update_params
    params.require(:nippo).permit(:body)
  end
end
