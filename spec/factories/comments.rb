# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    commentable { nil }
    body { Faker::Lorem.sentence(word_count: 100) }
    user { nil }
  end
end
