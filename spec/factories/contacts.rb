# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    email { Faker::Internet.email(domain: 'gmail') }
    message { Faker::Lorem.sentence(word_count: 3, supplemental: true) }
    product
  end
end
