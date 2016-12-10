# frozen_string_literal: true
class NotificationsController < PrivateController
  before_action :set_notification, only: %i(show)

  def show
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end
end
