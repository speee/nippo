# frozen_string_literal: true
FactoryGirl.define do
  factory :template do
    user
    subject_yaml { "【日報】<%= date %> 部署 #{FFaker::NameJA.name}" }
    body { FFaker::Lorem.paragraphs }
  end
end
