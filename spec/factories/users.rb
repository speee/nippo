# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    email { "#{FFaker::Internet.user_name}@speee.jp" }
    provider 'google'
    sequence(:uid, 1000000)
    name { FFaker::NameJA.name }
    image 'https://pbs.twimg.com/profile_images/616309728688238592/pBeeJQDQ.png'
    token { FFaker::Internet.password }
  end
end
