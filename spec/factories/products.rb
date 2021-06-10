# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    color { Faker::Commerce.color }
    description { Faker::Lorem.sentence(word_count: 3, supplemental: true) }
    category
  end
end
