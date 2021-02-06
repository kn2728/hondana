class Book < ApplicationRecord

  has_one_attached :image
  has_many :memos
  belongs_to :user
  with_options presence: true do
    validates :title
    validates :author
    validates :user_id
  end
end
