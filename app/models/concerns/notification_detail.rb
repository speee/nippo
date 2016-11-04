# frozen_string_literal: true
module NotificationDetail
  def self.[](type)
    Module.new do
      extend ActiveSupport::Concern

      included do
        belongs_to :notification
        before_create :create_notification

        define_method :create_notification do
          self.notification = Notification.create(type: type)
        end
      end
    end
  end
end
