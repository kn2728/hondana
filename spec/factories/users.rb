FactoryBot.define do
  factory :user do
    nickname              { Faker::JapaneseMedia::OnePiece.character }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6, mix_case: true) + 'a1' }
    password_confirmation { password }
  end
end
