class Book < ApplicationRecord

  has_one_attached :image
  has_many :memos
  belongs_to :user
end
