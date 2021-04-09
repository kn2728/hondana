FactoryBot.define do
  factory :book do
    title    { Faker::Book.title }
    author   { Faker::Name.name }
    isbn     { Faker::Number.number(digits: 10) }
  end
end
