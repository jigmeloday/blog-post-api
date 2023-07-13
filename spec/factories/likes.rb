# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    likable { nil }
    user { nil }
  end
end
