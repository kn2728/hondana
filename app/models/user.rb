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

  with_options presence: true do
    validates :nickname
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
    validates :email, format: { with: VALID_EMAIL_REGEX } #uniqueness: { case_sensitive: true },
    VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)\w{6,}\z/.freeze
    validates :password,
              format: { with: VALID_PASSWORD_REGEX }
  end
end
