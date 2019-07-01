class User < ApplicationRecord
  has_many :books
  has_one :admin

  has_secure_password
  before_validation { email&.downcase! }

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 },
              format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }

  scope :search_ransack, -> (_page){ ransack(_page) }
end
