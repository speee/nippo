# frozen_string_literal: true
class HomeController < PrivateController
  def index
    @recent_nippos = Nippo
                     .where.not(sent_at: nil)
                     .order(sent_at: :desc)
                     .limit(100)
    @notification_from_admins = Notification::FromAdmin.for_display
  end
end
