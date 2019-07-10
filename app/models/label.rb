class Label < ApplicationRecord
  has_many :labelings, dependent: :destroy

  # TODO: 同じ処理をuser_label.rbでも行っている。共通化する
  validates :name, presence: true, length: { in: 1..20 }
  scope :latest, -> { order(created_at: :asc) }
end
