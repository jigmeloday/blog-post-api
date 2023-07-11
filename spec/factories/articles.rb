# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.sentence(word_count: 100) }
    shared_count { 0 }
    like_count { 0 }
    comment_count { 0 }
    user { nil }
  end
end
