class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :blogs, dependent: :destroy
  has_many :comment, dependent: :destroy
  
  validates :name, presence: true, format: { with: /\A[^0-9`!@#\$%\^&*+_=]+\z/, message: "can not container special character"}
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  validates :password, presence: true, length: { minimum: 8 },
  format: {
    with: /\A(?=.*\d)(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z]).*\z/,
    message: "must contain at least one digit, one special character, one capital letter, and one small letter"
  }
end
 