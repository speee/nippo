# frozen_string_literal: true
class NipposController < PrivateController
  def new
    @nippo = Nippo.new(
      body: current_user.template.body,
      reported_for: current_report_date,
    )
  end

  private

  def current_report_date
    Time.zone.today
  end
end
