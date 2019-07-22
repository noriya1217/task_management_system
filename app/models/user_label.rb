class UserLabel < ApplicationRecord
  belongs_to :user
  has_many :user_labelings, dependent: :destroy
  validates :name, presence: true, length: { in: 1..20 }
  scope :latest, -> { order(created_at: :asc) }
end
