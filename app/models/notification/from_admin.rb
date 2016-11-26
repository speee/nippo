# frozen_string_literal: true
# == Schema Information
#
# Table name: notification_from_admins
#
#  id              :integer          not null, primary key
#  notification_id :integer          not null
#  body            :text(65535)
#  display_limit   :date             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_notification_from_admins_on_notification_id  (notification_id)
#
# Foreign Keys
#
#  fk_rails_578e90f969  (notification_id => notifications.id)
#

class Notification::FromAdmin < ApplicationRecord
  include NotificationDetail[:from_admin]

  validates :body, presence: true

  scope :for_display, -> { where(display_limit: Time.zone.today..Float::INFINITY) }
end
