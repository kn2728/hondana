FactoryBot.define do
  factory :memo do
    user_id   { Faker::Number.number(digits: 3)}
    book_id   { Faker::Number.number(digits: 3)}
    content   { Faker::Lorem.characters(number: 140)}
  end
end
