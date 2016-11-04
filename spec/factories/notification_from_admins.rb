# frozen_string_literal: true
FactoryGirl.define do
  factory :notification_from_admin, class: 'Notification::FromAdmin' do
    title { FFaker::Lorem.sentence }
    body { FFaker::Lorem.paragraph }
  end
end
