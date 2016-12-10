# frozen_string_literal: true
FactoryGirl.define do
  factory :notification do
    type   { Notification.types.keys.sample }
    title  { FFaker::Lorem.characters(32) }
  end
end
