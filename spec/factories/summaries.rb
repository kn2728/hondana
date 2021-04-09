FactoryBot.define do
  factory :summary do
    user_id   { Faker::Number.number(digits: 3)}
    book_id   { Faker::Number.number(digits: 3)}
    matome   { Faker::Lorem.characters(number: 800)}
  end
end
