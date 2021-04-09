class Summary < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates_uniqueness_of :book_id, scope: :user_id
  validates :matome, length: { maximum: 800 }, presence: true
end
