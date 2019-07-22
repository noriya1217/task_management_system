class Label < ApplicationRecord
  has_many :labelings, dependent: :destroy
  validates :name, presence: true, length: { in: 1..20 }
  scope :latest, -> { order(created_at: :asc) }
end
