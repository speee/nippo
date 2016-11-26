# frozen_string_literal: true
module NotificationDetail
  def self.[](type)
    Module.new do
      extend ActiveSupport::Concern

      included do
        belongs_to :notification
        validates :notification, presence: true
        delegate :title, to: :notification
      end

      class_methods do
        define_method :create_with_parent do |title:, **attributes|
          Notification.transaction do
            notification = Notification.create(type: type, title: title)
            create(notification: notification, **attributes)
          end
        end
      end
    end
  end
end
