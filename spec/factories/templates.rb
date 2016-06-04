# frozen_string_literal: true
FactoryGirl.define do
  factory :template do
    user
    from_name { FFaker::NameJA.name }
    subject { "【日報】<%= date %> 部署 #{from_name}" }
    body { FFaker::Lorem.paragraph }
  end
end
