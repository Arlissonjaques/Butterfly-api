FactoryBot.define do
  factory :user do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    email { Faker::Internet.email(domain: 'gmail') }
    password { Faker::Internet.password(min_length: 8, max_length: 8) }
  end
end
