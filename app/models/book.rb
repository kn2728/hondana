class Book < ApplicationRecord

  has_one_attached :image
  has_many :memos, dependent: :destroy
  with_options presence: true do
    validates :title
    validates :author
    validates :isbn
  end
end
