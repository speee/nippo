# frozen_string_literal: true
FactoryGirl.define do
  factory :nippo do
    user
    subject { "【日報】%s 部署 #{FFaker::NameJA.name}" }
    body { FFaker::Lorem.paragraph }
    sequence(:reported_for) { |n| Date.new(2016, 1, 1) + n }
    status :draft
  end
end
