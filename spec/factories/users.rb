# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    name { Faker::Name.first_name }
    username { Faker::Internet.username }
    article_count { 0 }
    following_count { 0 }
    follower_count { 0 }
    gender { :male }
    confirmed_at { nil }

    trait :confirmed do
      confirmed_at { DateTime.now }
    end

    trait :male do
      gender { :male }
    end

    trait :female do
      gender { :other }
    end

    trait :other do
      gender { :other }
    end
  end
end
