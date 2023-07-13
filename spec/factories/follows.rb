# frozen_string_literal: true

FactoryBot.define do
  factory :follow do
    followed_user { nil }
    user { nil }
  end
end
