class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_one :admin, dependent: :destroy
  accepts_nested_attributes_for :admin, allow_destroy: true

  has_secure_password
  before_validation { email&.downcase! }

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }

  scope :latest, -> { order(created_at: :asc).includes(:tasks) }
  scope :search_ransack, -> (_page){ ransack(_page) }
end
