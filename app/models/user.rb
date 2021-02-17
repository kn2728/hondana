class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
  has_many :memos
  has_many :reads
  has_many :books, through: :reads
  has_many :summaries
  accepts_nested_attributes_for :reads
end
