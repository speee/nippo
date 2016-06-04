# frozen_string_literal: true
class HomeController < PrivateController
  def index
    @recent_nippos = Nippo
                     .where.not(sent_at: nil)
                     .order(sent_at: :desc)
                     .limit(100)
  end
end
