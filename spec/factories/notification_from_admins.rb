# frozen_string_literal: true
FactoryGirl.define do
  factory :notification_from_admin, class: 'Notification::FromAdmin' do
    notification
    body          { FFaker::Lorem.paragraph }
    display_limit { Time.zone.today + rand(20) }
  end
end
